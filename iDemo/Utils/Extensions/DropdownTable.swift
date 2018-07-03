//
//  DropdownTable.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 28/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
import SVProgressHUD


extension MyAccountViewController : UITableViewDelegate,UITableViewDataSource
{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count : Int?
        if tableView == countryList
        {
            count = country.count
        }
        else if tableView == feedList
        {
            count = feedType.count
        }
        else if tableView == genreList
        {
            count = genre.count
        }
        return count!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell?
        
        if tableView == self.countryList{
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell?.textLabel?.text = country[indexPath.row]
           
            
        }
        else if tableView == self.feedList
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            cell!.textLabel?.text = feedType[indexPath.row]
        }
        else if tableView == self.genreList {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell?.textLabel?.text = genre[indexPath.row]
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.countryList
        {
          
            countryURL = country[indexPath.row]
            countryList.isHidden = true
            SVProgressHUD.show()
        
        }
        if tableView == self.feedList
        {
            feedTypeURL = feedType[indexPath.row]
            feedList.isHidden = true
            SVProgressHUD.show()
        }
        if tableView == self.genreList
        {
            genreURL = genre[indexPath.row]
            genreList.isHidden = true
            SVProgressHUD.show()
        }
//      MARK:- Dynamic Networking
        
        Networking.net.getData(url: dynamicURL!) {
            self.imgSelectedImage.kf.setImage(with: Networking.net.dataArray[0].imgURL)
            self.parsedData = Networking.net.dataArray
            self.collectionView.reloadData()
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
   
}
