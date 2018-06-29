//
//  Networking.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 25/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import SVProgressHUD


class Networking: UIViewController {
    
    static let net = Networking()

    var baseURL = "https://rss.itunes.apple.com/api/v1/"
    
    // JSON PARSING
    var dataArray = [JSONData]()

    func getData(url: String = "https://rss.itunes.apple.com/api/v1/us/itunes-music/hot-tracks/all/10/explicit.json" ,finished : @escaping () -> Void)
    {
        dataArray.removeAll()
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if response.result.isSuccess
            {
                print("Got the JSON data")
                let jsonData : JSON = JSON(response.result.value!)
                  print(jsonData)
                 let tempdata = jsonData["feed"]["results"]
                
                for (index,_) in tempdata.enumerated()
                   {
                    if let url = tempdata[index]["artworkUrl100"].url, let title = tempdata[index]["name"].string{
                        let object = JSONData()
                        object.title = title
                        object.imgURL = url
                        self.dataArray.append(object)
                        if index == tempdata.count-1
                        {
                            SVProgressHUD.dismiss()
                            finished()
                        }
                    }
                }
               
            }
            else{
                print("Error\(String(describing: response.result.error))")
            }
        }
    }

    
}

