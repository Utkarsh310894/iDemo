//
//  MyAccountViewController.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 22/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
import Kingfisher
import DropDown
import CoreData


class MyAccountViewController:UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,favoriteSelected {
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnFeedType: UIButton!
    @IBOutlet weak var btnGenre: UIButton!
    
    @IBOutlet weak var countryList: UITableView!
    @IBOutlet weak var feedList: UITableView!
    @IBOutlet weak var genreList: UITableView!
    
    
    
    //Protocol Method
    func buttonTapped(sender: ImageCollectionViewCell, state: Bool) {
        guard let index = collectionView.indexPath(for: sender) else{return}
        parsedData[index.row]?.state = state
        collectionView.reloadItems(at: [index])
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgSelectedImage: UIImageView!
    
    
    // Variable Declairation
    var dynamicURL : String?
    var countryURL :  String?
    {
        didSet{
            self.dynamicURL = "\(Networking.net.baseURL)\(self.countryURL ?? "in")/itunes-music/\(self.feedTypeURL ?? "recent-releases")/all/10/explicit.json"
        
        }
    }
    var feedTypeURL : String?
    {
        didSet{
            self.dynamicURL = "\(Networking.net.baseURL)\(self.countryURL ?? "in")/itunes-music/\(self.feedTypeURL ?? "recent-releases")/all/10/explicit.json"
           

        }
    }
    var genreURL : String?
    var favSelected = [Favorite]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var country = ["us","gb","ar","au","bs","in","il","jp"]
    var feedType = ["hot-tracks","new-releases","top-albums","top-songs"]
    var genre = ["all"]
    var parsedData : [JSONData?] = []
    var favArray : [Favorite?] = []
    var indexPath : IndexPath?
       override func viewDidLoad() {
        super.viewDidLoad()
        self.countryList.isHidden = true
        self.feedList.isHidden = true
        self.genreList.isHidden = true
        Networking.net.getData {
        self.collectionView.reloadData()
        self.parsedData  = Networking.net.dataArray
        self.imgSelectedImage.kf.setImage(with: self.parsedData[0]?.imgURL)
       
           
        }
    
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        self.navigationItem.hidesBackButton = true
    
    }
    //MARK:- CollectionView Datasource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parsedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        collectionView.reloadData()
        cell.imgImageView.kf.setImage(with: parsedData[indexPath.row]?.imgURL)
        cell.lblImgTitle.text = parsedData[indexPath.row]?.title
        cell.tappedState = self
        cell.favButton.isSelected = parsedData[indexPath.row]?.state ?? false
     
        let req: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        var newArray = [Favorite]()
        do{
            newArray = try context.fetch(req)
        }
        catch{
            print(error)
        }
        if newArray.count > 0{
        if cell.favButton.isSelected == true
            {
                let obj1 = Favorite(context: context)
                obj1.imageUrl = "\((parsedData[indexPath.row]?.imgURL!)!)"
                obj1.title = parsedData[indexPath.row]?.title
                obj1.state = (parsedData[indexPath.row]?.state)!
//                cell.favButton.tintColor = UIColor.red
                favSelected.append(obj1)
                saveData()
              }
            else{
              checkDatabase()
               }
        }
           return cell
    }
    //MARK:- CollectionView Delegate Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width/2
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "details") as! DisplayViewController
        dvc.showData.imgURL = parsedData[indexPath.row]?.imgURL
        dvc.showData.title = parsedData[indexPath.row]?.title
        navigationController?.pushViewController(dvc, animated: true)
        
    }

    func saveData()
    {
        do{
            try context.save()
        }
        catch{
            print("Error during saving data")
        }
    }

    //MARK:- Filter Button Actions
    @IBAction func countryButtonTapped(_ sender: UIButton) {
        
        if countryList.isHidden == true
        {
            UIView.animate(withDuration: 0.3) {
                self.countryList.isHidden = false
            }
        }
       else
        {
            UIView.animate(withDuration: 0.3) {
                self.countryList.isHidden = true
            }
        }
    }
    @IBAction func feedtypeButtonTapped(_ sender: UIButton) {
     if feedList.isHidden == true
     {
            UIView.animate(withDuration: 0.3) {
                self.feedList.isHidden = false
            }
        
        }
       else{
        UIView.animate(withDuration: 0.3) {
            self.feedList.isHidden = true
        }
        }
        
    }
    @IBAction func genreButtonTapped(_ sender: UIButton) {
       if genreList.isHidden == true
       {
        UIView.animate(withDuration: 0.3) {
            self.genreList.isHidden = false
        }
        }
        
       else{
        UIView.animate(withDuration: 0.3) {
            self.genreList.isHidden = true
        }
        }
        
    }
    func checkDatabase(){
        
        for elements in parsedData
        {
            var checkUrl = elements?.imgURL
            var urlString = "\(checkUrl!)"
            let request : NSFetchRequest<Favorite> = Favorite.fetchRequest()
            request.predicate = NSPredicate(format: "imageUrl == %@" , urlString )
            do {
                favArray = try context.fetch(request)
                if favArray.count != 0
                {
                for (index,items) in favArray.enumerated()
                {
                    if elements?.state != items?.state
                    {
                        context.delete(favArray[index]!)
                        favArray.remove(at: index)
                        saveData()
                    }
                }
                }
    
            }
            catch
            {
                print("Error during fetching data")
            }
        }
        
       
    }
    
    
  
}



