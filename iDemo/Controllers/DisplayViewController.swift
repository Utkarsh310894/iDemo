//
//  DisplayViewController.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 27/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
import Kingfisher

class DisplayViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    var showData = JSONData()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    imageView.kf.setImage(with: showData.imgURL)
    lblTitle.text = showData.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
