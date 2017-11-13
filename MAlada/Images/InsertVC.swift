//
//  InsertVC.swift
//  MAlada
//
//  Created by Maahi on 13/11/17.
//  Copyright © 2017 KTechnology. All rights reserved.
//

import UIKit

class InsertVC: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    var chosenImage : UIImage = UIImage()
    let imagePicker = UIImagePickerController()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.gray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.black
    
    
    
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
    @IBAction func selectImage(_ sender: Any) {
    
        let uiAlert = UIAlertController(title: "Profile Picture", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        self.present(uiAlert, animated: true, completion: nil)
        
        uiAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.shootPhoto()
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: { action in
            self.photoFromLibrary()
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            uiAlert .dismiss(animated: true, completion: nil)
        }))
    
    }
    
    
    
    
    @IBAction func uploadImage(_ sender: Any) {
        
        
        
        
        
    }
    
    
    
}


//Camera picker Extension
extension InsertVC :UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    
    func photoFromLibrary() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker,  animated: true, completion: nil)//4
        //imagePicker.popoverPresentationController?.barButtonItem = sender
        
    }
    
    func shootPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,  animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction( title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        //let chosenImage : UIImage
        if (info[UIImagePickerControllerEditedImage] as? UIImage) != nil {
            chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            self.imageView.image = chosenImage
            
        } else if (info[UIImagePickerControllerOriginalImage] as? UIImage) != nil {
            chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            self.imageView.image = chosenImage
        }
        
        self.imageView.layer.cornerRadius =  self.imageView.frame.size.width / 2
        dismiss(animated: true, completion: nil) //5
    }
    
    
    
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true,    completion: nil)
    }
    
    
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}


public extension UIImage
{
    func base64Encode() -> String?
    {
        guard let imageData = UIImagePNGRepresentation(self) else
        {
            return nil
        }
        
        
        // let fullBase64String = imageData.base64EncodedString()
        
        
        let base64String = imageData.base64EncodedString()
        let fullBase64String = "data:image/png;base64,\(base64String))"
        
        return fullBase64String
    }
}
