//
//  TextFeildExtension.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 25/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//
import UIKit

extension SignUPViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtName:
            txtEmail.becomeFirstResponder()
        case txtEmail:
            txtMobileNo.becomeFirstResponder()
        case txtMobileNo:
            txtPassword.becomeFirstResponder()
        default:
            txtPassword.resignFirstResponder()
        }
        return true
    }
}

