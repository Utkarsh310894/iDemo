//
//  FavouriteTableViewCell.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 28/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
protocol unfavorite{
    func unfavoriteButtontapped(sender: FavouriteTableViewCell,index:Int)
    
    }

class FavouriteTableViewCell: UITableViewCell {
    var index : unfavorite?
    @IBOutlet weak var favoriteImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
