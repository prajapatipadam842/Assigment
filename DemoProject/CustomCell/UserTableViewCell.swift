//
//  UserTableViewCell.swift
//  DemoProject
//
//  Created by Padam on 15/02/20.
//  Copyright © 2020 Padam. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    var arrItems : [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension UserTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    //MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO:- Required Method
        return arrItems.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionCell", for: indexPath) as! ItemCollectionCell
        configureCell(cell: cell, forItemAt: indexPath)
        // TODO:- Required Method
        return cell
    }
    
    func configureCell(cell: ItemCollectionCell, forItemAt indexPath: IndexPath) {
        cell.imgItemView.setImageFromURL(urlString: arrItems[indexPath.row] )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if(self.arrItems.count % 2 != 0){
           if(indexPath.row == 0){
                return CGSize(width: (collectionView.frame.size.width), height:(collectionView.frame.size.width))
            }
        }
        return CGSize(width: (collectionView.frame.size.width-10)/2, height:(collectionView.frame.size.width-10)/2 )
          
        
    }
}
