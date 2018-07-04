//
//  FavoriteTableViewController.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 27/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class FavoriteTableViewController: UITableViewController,deleteCellDelegate{
    func unfavouriteButtontapped(sender: FavouriteTableViewCell, state: Bool) {
        guard let index = tableView.indexPath(for: sender) else{return}
       CoreData.core.context.delete(favArray[index.row]!)
       favArray.remove(at: index.row)
       CoreData.core.saveData()
       tableView.reloadData()
    }
    var favArray : [Favorite?] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        favArray = CoreData.core.loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavouriteTableViewCell
        cell.favoriteImage.kf.setImage(with: URL(string: (favArray[indexPath.row]?.imageUrl)!))
        cell.unfavouriteDelegate=self
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "details") as! DisplayViewController
        dvc.showData.imgURL = URL(string:(favArray[indexPath.row]?.imageUrl)!)
        dvc.showData.title = favArray[indexPath.row]?.title
        navigationController?.pushViewController(dvc, animated: true)
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
 
    
    
}
