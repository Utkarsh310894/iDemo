//
//  MyAccountViewController.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 22/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
import Kingfisher


class MyAccountViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
  
    @IBOutlet weak var collectionView: UICollectionView!
    


    @IBOutlet weak var imgSelectedImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Networking.net.getData {
            self.collectionView.reloadData()
        }

        // Do any additional setup after loading the view.
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
        
    
           return cell
    }
    //MARK:- CollectionView Delegate Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width/2
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      
    }

}
