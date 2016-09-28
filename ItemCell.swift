//
//  ItemCell.swift
//  Dreamlister
//
//  Created by Aiman Abdullah Anees on 27/09/16.
//  Copyright © 2016 Aiman Abdullah Anees. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet var thumb: UIImageView!
    @IBOutlet var title: UILabel!
        
    @IBOutlet var price: UILabel!
    
    @IBOutlet var details: UILabel!
    
    
    //Setting up the values of all the properties mentioned in Data Models
    func configureCell(item:Item){
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
        
        
    }
    
}
