//
//  SignUPViewController.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 22/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
import CoreData

class SignUPViewController: UIViewController {
    
    
    //Outlets
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //Variable Declairation
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var userDetailArray = [UserDetails]()
   var userInfo : UserDetails?
   
    override func viewDidLoad() {
        super.viewDidLoad()
     print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }

    @IBAction func btnSignUpTapped(_ sender: UIButton) {
        userInfo = UserDetails(context: context)
        userInfo?.name = txtName.text
        userInfo?.email = txtEmail.text
        userInfo?.mobile = txtMobileNo.text
        userInfo?.password = txtMobileNo.text
        
        
//        userDetailArray.append(userInfo!)
        saveData()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let lvc = storyboard.instantiateViewController(withIdentifier: "lvc") as? LoginViewController
        navigationController?.pushViewController(lvc!, animated: true)
        
        
    }
    @IBAction func btnAddProfilePicture(_ sender: Any) {
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
//    func loadData()
//    {
//        let request : NSFetchRequest<UserDetails> = UserDetails.fetchRequest()
//       do
//       {
//         try userDetailArray = context.fetch(request)
//        }
//
//       catch{
//           print("Error during fetching data")
//        }
  //  }
    
}
