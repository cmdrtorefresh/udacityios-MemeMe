//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Stephanie Kirtiadi on 6/29/16.
//  Copyright © 2016 Cmdrtorefresh. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraBtnOutlet: UIBarButtonItem!
    @IBOutlet weak var imgOutlet: UIImageView!
    
    @IBOutlet weak var topBtnOutlet: UIButton!
    
    @IBOutlet weak var bottomBtnOutlet: UIButton!
    
    @IBAction func topBtnAction(sender: AnyObject) {
    }
    
    @IBAction func bottomBtnAction(sender: AnyObject) {
    }
    
    
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
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraBtnOutlet.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
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


}

