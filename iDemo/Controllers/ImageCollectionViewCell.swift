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
    var tappedState:favoriteSelected?
    @IBOutlet weak var lblImgTitle: UILabel!
    @IBOutlet weak var imgImageView: UIImageView!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        tappedState?.buttonTapped(sender: self,state: !sender.isSelected)
    }
   
  
}
