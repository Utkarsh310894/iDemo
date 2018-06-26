//
//  LoginViewController.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 22/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    
    var userDetailArray = [UserDetails]()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Fetching data from core data
    
    func fetchData(with request: NSFetchRequest<UserDetails> = UserDetails.fetchRequest()){
      
         let predicate = NSPredicate(format: "email MATCHES %@", txtUserName.text!)
         request.predicate = predicate
        do{
            userDetailArray = (try context?.fetch(request))!
            
            if(userDetailArray.count != 0)
            {
           
            if(userDetailArray[0].password == txtPassword.text)
            {
                let alert = UIAlertController(title: "Welcome", message: "Login Successful", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ENTER", style: .default) { (action) in
                     SVProgressHUD.show()
                    self.performSegue(withIdentifier: "mavc", sender: nil)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "Login Unsuccessful", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            }
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "Invalid Username or Password", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        catch{
            print("Error during fetching data")
        }
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
         fetchData()
        
    }
   
}
