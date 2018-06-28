//
//  ImageCollectionViewCell.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 22/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit

protocol favoriteSelected{
func buttonTapped(sender: ImageCollectionViewCell, state: Bool)
}

class ImageCollectionViewCell: UICollectionViewCell {
    var state : Bool = false
    var tappedState:favoriteSelected?
    @IBOutlet weak var lblImgTitle: UILabel!
    @IBOutlet weak var imgImageView: UIImageView!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        if state == false{
            state = !state
            tappedState?.buttonTapped(sender: self,state: true)
           
        }
        else{
            state = !state
            tappedState?.buttonTapped(sender: self,state: false)
            
        }
    }
    override func prepareForReuse() {
        favButton.tintColor=UIColor.white
    }
  
}
