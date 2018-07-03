//
//  CoreData.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 03/07/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
import CoreData



class CoreData : UIViewController
{
    static let core = CoreData()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    MARK:- Saving Data into CoreData
    func saveData()
    {
        do{
            try context.save()
        }
        catch{
            print("Error during saving data")
        }
    }
    
    
    
//    MARK:- Fetching Data from Core Data
    
//    Fetch data with parameter
    func fetchData(id : String) -> [Favorite]
    {
        
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@" , id )
        
        var matchArray = [Favorite]()
        do{
            matchArray = try context.fetch(request)
        }
        catch{
            print("Error duringh Saving data")
        }
        return matchArray
    }
//    Fetch data without parameter
    func loadData() -> [Favorite]
    {
        let req: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        var loadDataArray = [Favorite]()
        do{
            loadDataArray = try context.fetch(req)
        }
        catch{
            print("Error during loading data from core data")
        }
        return loadDataArray
    }

}
