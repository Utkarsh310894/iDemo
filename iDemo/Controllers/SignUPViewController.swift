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
 
   var userInfo : UserDetails?
   
    override func viewDidLoad() {
        super.viewDidLoad()
     print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }

    @IBAction func btnSignUpTapped(_ sender: UIButton) {
        //checking for empty textfeilds
        
        if((txtName.text?.isEmpty)! || (txtPassword.text?.isEmpty)! || (txtMobileNo.text?.isEmpty)! || (txtEmail.text?.isEmpty)!)
        {
            displayAlert(userMessage: "All feilds are required")
        }
        
        
        //storing User data to coreData
        
        userInfo = UserDetails(context: context)
        userInfo?.name = txtName.text
        userInfo?.email = txtEmail.text
        userInfo?.mobile = txtMobileNo.text
        userInfo?.password = txtPassword.text
        saveData()
        
//        Display  alert for registration confirmation
        let confirm = UIAlertController(title: "Success", message: "Registration Succesfull", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let lvc = storyboard.instantiateViewController(withIdentifier: "lvc") as? LoginViewController
            self.navigationController?.pushViewController(lvc!, animated: true)
        }
        confirm.addAction(okAction)
        self.present(confirm, animated: true, completion: nil)
        
        
    }
    @IBAction func btnAddProfilePicture(_ sender: Any) {
    }
 
    //func to save context into core data
    func saveData()
    {
        do{
           try context.save()
        }
        catch{
            print("Error during saving data")
        }
        
    }
    func displayAlert(userMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
