//
//  MyAccountViewController.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 22/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
import Kingfisher
import ChameleonFramework


class MyAccountViewController:UIViewController {
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnFeedType: UIButton!
    @IBOutlet weak var btnGenre: UIButton!
    
    @IBOutlet weak var countryList: UITableView!
    @IBOutlet weak var feedList: UITableView!
    @IBOutlet weak var genreList: UITableView!
  
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
    var country = ["us","gb","ar","au","bs","in","il","jp"]
    var feedType = ["hot-tracks","new-releases","top-albums","top-songs"]
    var genre = ["all"]
    var parsedData : [JSONData?] = []
    var matchArray : [Favorite?] = []
    var loadArray = [Favorite]()
       override func viewDidLoad() {
        super.viewDidLoad()
        self.countryList.isHidden = true
        self.feedList.isHidden = true
        self.genreList.isHidden = true
        Networking.net.getData {
            self.parsedData  = Networking.net.dataArray
            self.loadData()
            self.imgSelectedImage.kf.setImage(with: self.parsedData[0]?.imgURL)
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadArray.removeAll()
        loadData()
        self.collectionView.reloadData()
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK:- Checking DataBase
    
    func loadData()
    {
        for objectState in parsedData{
            objectState?.state = false
        }
          var loadArray = CoreData.core.loadData()
            for (items) in loadArray
            {
                for element in parsedData
                {
                  if items.id == element?.id
                    {
                     element?.state = true
                    }
                }
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



