//
//  FavouriteTableViewCell.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 28/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
protocol deleteCellDelegate{
    func unfavouriteButtontapped(sender: FavouriteTableViewCell,state: Bool)
}

class FavouriteTableViewCell: UITableViewCell {
    var unfavouriteDelegate :  deleteCellDelegate?
    @IBOutlet weak var favoriteImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func unfavoriteButtonTapped(_ sender: UIButton) {
        unfavouriteDelegate?.unfavouriteButtontapped(sender: self, state: !sender.isSelected)
    }
}
