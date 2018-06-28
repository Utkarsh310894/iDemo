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


class MyAccountViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,favoriteSelected {
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnFeedType: UIButton!
    @IBOutlet weak var btnGenre: UIButton!
    
    @IBOutlet weak var countryList: UITableView!
    @IBOutlet weak var feedList: UITableView!
    @IBOutlet weak var genreList: UITableView!
    
    
    
    
    func buttonTapped(sender: ImageCollectionViewCell, state: Bool) {
        guard let index = collectionView.indexPath(for: sender) else{return}
        Networking.net.dataArray[index.row].state = state
        collectionView.reloadItems(at: [index])
        saveData()
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
    var favArray = [Favorite]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var country = ["us","gb","ar","au","bs","in","il","jp"]
    var feedType = ["coming-soon","hot-tracks","new-releases","top-albums","top-songs"]
    var genre = ["all"]
    
       override func viewDidLoad() {
        super.viewDidLoad()
        Networking.net.getData {
           
            self.imgSelectedImage.kf.setImage(with: Networking.net.dataArray[0].imgURL)
            self.countryList.isHidden = true
            self.feedList.isHidden = true
            self.genreList.isHidden = true
            
//            self.dynamicURL = "\(Networking.net.baseURL)\(self.countryURL ?? "in")/itunes-music/\(self.feedTypeURL ?? "recent-releases")/all/10/explicit.json"
            self.collectionView.reloadData()
           
        }
    
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        self.navigationItem.hidesBackButton = true
    
    }
    //MARK:- CollectionView Datasource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Networking.net.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
           cell.imgImageView.kf.setImage(with: Networking.net.dataArray[indexPath.row].imgURL) 
           cell.lblImgTitle.text = Networking.net.dataArray[indexPath.row].title
           cell.tappedState = self
        
        
            if Networking.net.dataArray[indexPath.row].state == true
            {
                let obj1 = Favorite(context: context)
                obj1.imageUrl = "\(String(describing:  Networking.net.dataArray[indexPath.row].imgURL))"
                obj1.title = Networking.net.dataArray[indexPath.row].title
                obj1.state = Networking.net.dataArray[indexPath.row].state!
                cell.favButton.tintColor = UIColor.red
                collectionView.reloadItems(at: [indexPath])
                favSelected.append(obj1)
                saveData()
              }
                
                
                
            else{
                let urlString =  "\(String(describing: Networking.net.dataArray[indexPath.row].imgURL))"
                let predicate = NSPredicate(format: "imageUrl == %@",  urlString )
                let request : NSFetchRequest<Favorite> = Favorite.fetchRequest()
                request.predicate = predicate
                
                    do{
                       favArray = try context.fetch(request)
                        if favArray.count != 0
                        {
                        context.delete(favArray[0])
                        }
                       
                    }
                 catch
                    {
                        print("Error during fetching data")
                    }
                
                cell.favButton.tintColor = UIColor.white
                collectionView.reloadItems(at: [indexPath])
                }
  
           return cell
    }
    //MARK:- CollectionView Delegate Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width/2
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
    
  
}



