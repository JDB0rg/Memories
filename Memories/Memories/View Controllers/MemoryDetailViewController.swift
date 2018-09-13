//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Madison Waters on 9/12/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBAction func saveDetailButtonTapped(_ sender: Any) {
        
        guard let title = detailTextField.text,
            let bodyText = detailTextView.text,
            let imageData = detailImageView.image else { return }
        
        if let memory = memory {
            memoryController?.update(memory: memory, title: title, bodyText: title, imageData: memory.imageData)
        } else if memory == nil {
            memoryController?.create(title: title, bodyText: bodyText, imageData: (memory?.imageData)!)
        }
        navigationController?.popViewController(animated: true)
    }
    //In the bar button item's action, it should update the memory if it exists, or create a new one if it is `nil.
    
    @IBAction func addPhotoDetailButtonTapped(_ sender: Any) {
        
        PHPhotoLibrary.authorizationStatus()
            let status = PHAuthorizationStatus(rawValue: 0)
                if status == .authorized {
                presentImagePickerController()
                    
            } else if status == .notDetermined {
                PHPhotoLibrary.requestAuthorization { (status) in
                    guard status == .authorized else {
                        NSLog("Please allow access to your photos so this thing will work. Please. Please!")
                            return
                        }
                        NSLog("Access Granted! Noice!")
                        DispatchQueue.main.async {
                            self.presentImagePickerController()
                        }
                    }
        }
    }
    
    func presentImagePickerController() {
        let imageCheck = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        if imageCheck == false { return }
        else {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            picker.dismiss(animated: true, completion: nil)
            
            guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
            detailImageView.image = image
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    private func updateViews() {
        
        guard let unwrapMemory = memory else {
            if memory == nil {
                title = "Add Memory"
            } else {
                title = "Edit Memory"
            }
            return
        }
            
        title = unwrapMemory.title
        guard isViewLoaded else { return }
        
    }
    
    var memory: Memory?
    var memoryController: MemoryController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
