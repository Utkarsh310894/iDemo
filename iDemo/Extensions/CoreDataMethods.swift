//
//  CoreDataMethods.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 27/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
import CoreData

class CoreData
{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func saveData()
    {
        do{
            try context.save()
        }
        catch{
            print("Error during saving data")
        }
        
    }
    
    func fetchData()
    {
        let request : NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
