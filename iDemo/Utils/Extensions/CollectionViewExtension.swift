//
//  CollectionViewExtension.swift
//  iDemo
//
//  Created by Utkarsh Sharma on 03/07/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit


extension MyAccountViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,favoriteSelected
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parsedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        cell.imgImageView.kf.setImage(with: parsedData[indexPath.row]?.imgURL)
        cell.lblImgTitle.text = parsedData[indexPath.row]?.title
        cell.tappedState = self
        cell.favButton.isSelected = parsedData[indexPath.row]?.state ?? false
        return cell
    }
    
    //MARK:- CollectionView Delegate Methods
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width/2
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "details") as! DisplayViewController
        dvc.showData.imgURL = parsedData[indexPath.row]?.imgURL
        dvc.showData.title = parsedData[indexPath.row]?.title
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    
    
    //MARK:- Protocol Method (Button Action)
    
    func buttonTapped(sender: ImageCollectionViewCell, state: Bool) {
        guard let index = collectionView.indexPath(for: sender) else{return}
        parsedData[index.row]?.state = state
        if parsedData[index.row]?.state == true
        {
          var checkData = CoreData.core.fetchData(id: (parsedData[index.row]?.id)!)
                if  checkData.count != 0
                {
                    for _ in checkData
                    {
                        parsedData[index.row]?.state = true
                    }
                }
                else{
                    let obj1 = Favorite(context: CoreData.core.context)
                    obj1.imageUrl = "\((parsedData[index.row]?.imgURL!)!)"
                    obj1.title = parsedData[index.row]?.title
                    obj1.state = (parsedData[index.row]?.state)!
                    obj1.id = parsedData[index.row]?.id
                    favSelected.append(obj1)
                    CoreData.core.saveData()
                }
        }
        else{
            var getData = CoreData.core.fetchData(id: (parsedData[index.row]?.id)!)
            
                if getData.count != 0
                {
                    CoreData.core.context.delete(getData[0])
                    getData.remove(at: 0)
                    CoreData.core.saveData()
                }
        }
        collectionView.reloadItems(at: [index])
    }
}
