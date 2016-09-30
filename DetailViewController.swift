//
//  DetailViewController.swift
//  Dreamlister
//
//  Created by Aiman Abdullah Anees on 28/09/16.
//  Copyright © 2016 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import CoreData
class DetailViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var price: UITextField!
    
    @IBOutlet weak var detailsField: UITextField!
    
    var stores = [Store]()
    var itemToEdit : Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This pust only arrow when we move from Add/Edit screen to Homescreen without typing "DreamLister"
        
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            
        }
        
        pickerView.delegate  = self
        pickerView.dataSource = self

        // Do any additional setup after loading the view.
        
        /*let store = Store(context: context)
        store.name = "Best Buy"
        let store1 = Store(context: context)
        store1.name = "Tesla Dealers"
        let store2 = Store(context: context)
        store2.name = "Wall Mart"
        let store3 = Store(context: context)
        store3.name = "Amazon"
        let store4 = Store(context: context)
        store4.name = "Geekay"
        let store5 = Store(context: context)
        store5.name = "Sharaf DG"
        
        ad.saveContext()
    */
        getStores()
        
        //This is used to check if we have selected a cell and wish to edit...if yes then it gives complete view of that cell
        if itemToEdit != nil{
            loadItemData()
            
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Update
    }
    
    func getStores(){ //This receives all the data from database...just like it is done in ViewController.swift..check out attemptFetch()
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do{
            self.stores = try context.fetch(fetchRequest)
            self.pickerView.reloadAllComponents()
            
        }catch{
            //Error handler
        }
        
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        //This button stores new title,price,and deltails into database once save button is clicked
        let item = Item(context: context)
        
        if let title = textField.text{
            item.title = title
        }
        
        if let price = price.text{
            item.price = (price as NSString).doubleValue //since price property in "item" is double and price.text is a string,hence price.text is converted to NSString and double value can be extracted
            
        }
        
        if let details = detailsField.text{
            item.details = details
        }
        
        //Now we have to assign the above properties created to toStore relationship of item that we had created....as we have created a pickerView containing all the store there should a way to link these..hence it is done in this way
        
        item.toStore = stores[pickerView.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        //Once saved..goes back to the homescreen
        
        _ = navigationController?.popViewController(animated: true)
        
        
        
        
    }
    
    func loadItemData(){
        if let item = itemToEdit{
            textField.text = item.title
            price.text = "\(item.price)"
            detailsField.text = item.details
            
        }
        
        
        let item = Item(context: context)
        if let store = item.toStore{
            var index = 0
            repeat{
                let s = stores[index]
                if s.name == store.name{
                    pickerView.selectRow(index, inComponent: 0, animated: false)
                break
                }
                index=index+1
            }while (index < stores.count)
            
        }
            
    }
}

