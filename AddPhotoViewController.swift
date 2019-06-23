//
//  AddPhotoViewController.swift
//  viewFinder
//
//  Created by Matthew Wecht on 6/21/19.
//  Copyright © 2019 Matthew Wecht. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()

    @IBOutlet weak var caption: UITextField!
    @IBOutlet weak var centralPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tappedCameraButton(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func tappedLibraryButton(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let photoToSave = ListData(entity: ListData.entity(), insertInto: context)
            photoToSave.caption = caption.text
            
            if let userImage = centralPicture.image{
                if let userImageData = userImage.pngData(){
                    photoToSave.imageData = userImageData
                }
            }
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext() //update in core
            navigationController?.popViewController(animated: true) // send back to the view controller

        }
    }

    
    
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { //gets the image from a dictionary hence why we use a key
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            centralPicture.image = selectedImage
            imagePicker.dismiss(animated: true, completion: nil)
        }
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
