//
//  Item+CoreDataClass.swift
//  Dreamlister
//
//  Created by Aiman Abdullah Anees on 27/09/16.
//  Copyright © 2016 Aiman Abdullah Anees. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    public override func awakeFromInsert() { //Anytime when the item is created from the entity,this function is called
        super.awakeFromInsert()
        self.created = NSDate()
        
        
        
        
        
        
    }

}
