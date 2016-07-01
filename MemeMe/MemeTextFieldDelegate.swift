//
//  MemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Stephanie Kirtiadi on 6/29/16.
//  Copyright © 2016 Cmdrtorefresh. All rights reserved.
//

import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var defaultWord: String!
    var sourceVC: MemeViewController!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sourceVC.firstReponder = nil
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        let text = textField.text
        if (text == defaultWord) {
            textField.text = ""
        }
    }


}
