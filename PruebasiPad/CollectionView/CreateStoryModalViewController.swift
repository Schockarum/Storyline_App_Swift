//
//  CreateStoryModalViewController.swift
//  Storyline
//
//  Created by Luis Mauricio Esparza Vazquez on 8/4/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit

class CreateStoryModalViewController: UIViewController {

    @IBOutlet weak var createStoryImageView: UIImageView!
    @IBOutlet weak var createStoryTextFiel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup Functions

    func setupView(){
        view.backgroundColor = .clear
        
    }
    
    // MARK: - Actions
    
    @IBAction func pressCreateButton(_ sender: Any) {
    }
    
    @IBAction func pressCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

/*This view controller has to get the user info for a new story, this is an image and a name.
 However, the user can leave the fields blank, in that case, we'll use a default configuration using placeholders.*/
