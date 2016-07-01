//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Stephanie Kirtiadi on 6/29/16.
//  Copyright © 2016 Cmdrtorefresh. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let topMemeTFDelegate = MemeTextFieldDelegate()
    let bottomMemeTFDelegate = MemeTextFieldDelegate()
    
    var firstReponder: UITextField!
    
    @IBOutlet weak var cameraBtnOutlet: UIBarButtonItem!
    @IBOutlet weak var imgOutlet: UIImageView!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
        
    @IBAction func pickFromPicAlbum(sender: AnyObject) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(controller, animated: true, completion: nil)
    }
    @IBAction func pickFromCamera(sender: AnyObject) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextFields()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraBtnOutlet.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotification()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgOutlet.image = image
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setTextFields() {
        
        setTextFieldDelegateAndDefaultWord(topTextField, textFieldDelegate: topMemeTFDelegate, word: "TOP")
        setTextFieldDelegateAndDefaultWord(bottomTextField, textFieldDelegate: bottomMemeTFDelegate, word: "BOTTOM")
        
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
        
        setMemeFont(topTextField, fontColor: UIColor.whiteColor(), outlineColor: UIColor.blackColor(), fontNameSize: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!, outlineWidth: 8.0)
        setMemeFont(bottomTextField, fontColor: UIColor.whiteColor(), outlineColor: UIColor.blackColor(), fontNameSize: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!, outlineWidth: 8.0)
    }
    
    func setMemeFont(tf: UITextField, fontColor: UIColor, outlineColor: UIColor, fontNameSize: UIFont, outlineWidth: Float){
        
        let memeTextAttributes: Dictionary<String, AnyObject> = [
            NSStrokeColorAttributeName: outlineColor,
            NSForegroundColorAttributeName: fontColor,
            NSFontAttributeName: fontNameSize,
            NSStrokeWidthAttributeName: outlineWidth
        ]
        
        tf.defaultTextAttributes = memeTextAttributes
    }
    
    func setTextFieldDelegateAndDefaultWord(tf: UITextField, textFieldDelegate: MemeTextFieldDelegate, word: String){
        tf.delegate = textFieldDelegate
        textFieldDelegate.sourceVC = self
        tf.text = word
        textFieldDelegate.defaultWord = word
    }

    
    func keyboardWillShow(notification: NSNotification){
        if isTextFieldCoveredByKeyboard(firstReponder, notification: notification) {
           self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        self.view.frame.origin.y = 0
    }

    @IBAction func subscribeToKeyboardNotification(sender: UITextField) {
        firstReponder = sender
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    
    func unsubscribeToKeyboardNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardDimension(notification: NSNotification) -> NSValue {
        let userInfo = notification.userInfo
        return userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        return getKeyboardDimension(notification).CGRectValue().height
    }
    
    func isTextFieldCoveredByKeyboard(tf: UITextField, notification: NSNotification) -> Bool {
        let keyboardLocation = getKeyboardDimension(notification)
        return keyboardLocation.CGRectValue().contains(tf.frame)
    }
    
    
    
    
//    func save(){
//        let meme = Meme(topString: topTextField.text, bottomString: bottomTextField.text, img: generateMemedImage())
//    }
//    
//    func generateMemedImage() -> UIImage {
//        
//        // TODO : Hide Toolbar and Navbar
//        
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
//        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        // TODO : Show Toolbar and Navbar
//        
//        return memedImage
//    }
}

//struct Meme {
//    var topString: String!
//    var bottomString: String!
//    var img: UIImage!
//}

