//
//  OptionsTableViewCell.swift
//  Contacts
//
//  Created by Adarsh R on 23/01/20.
//  Copyright © 2020 Adarsh R. All rights reserved.
//

import UIKit
protocol Selection {
    func getIndex( index: IndexPath)
}
class OptionsTableViewCell: UITableViewCell{

    @IBOutlet weak var OptionsButton: UIButton!
    @IBOutlet weak var phoneOrEmailText: UITextField!
    
    var buttonDelegate: Selection?
    var index: IndexPath?
    var newButtonDelegate: AddContactViewController?
    
    var txtDelegate: UITextFieldDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state    }
    
}

    
    @IBAction func OptionButtonClicked(_ sender: Any) {
        
        print()
        if let index = index , let buttonDelegate = buttonDelegate{
            buttonDelegate.getIndex(index: index)
        }
        if let index = index , let newButtonDelegate = newButtonDelegate {
            newButtonDelegate.getIndex(index: index)
            print("here atleast i am there")
        }
        
    }
    
    
}
