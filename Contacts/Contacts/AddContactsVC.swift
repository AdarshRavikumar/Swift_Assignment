//
//  AddContactsVCViewController.swift
//  Contacts
//
//  Created by Adarsh R on 23/01/20.
//  Copyright © 2020 Adarsh R. All rights reserved.
//

import UIKit

class AddContactsVC: UIViewController {
    
    @IBOutlet weak var OptionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //OptionButton.addTarget(self, action: #selector(OnClickOptions), for: .touchUpInside)
        
    }
    
    
    
    
    @IBAction func displayOptions(_ sender: Any) {
        let addContacts = storyboard?.instantiateViewController(withIdentifier: "DisplayOptions") as? DisplayOptions
        if addContacts != nil {
            self.navigationController?.pushViewController(addContacts!, animated: true)
            
        }
    }
}

