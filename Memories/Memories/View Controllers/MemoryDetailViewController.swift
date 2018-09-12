//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Madison Waters on 9/12/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class MemoryDetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBAction func saveDetailButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addPhotoDetailButtonTapped(_ sender: Any) {
    }
    
    var memory: Memory?
    var memoryController: MemoryController
    
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
