//
//  ProjectCell.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 7/28/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit
import SpriteKit

class ProjectCollectionViewCell: UICollectionViewCell{

    #warning("Nombres confusos, deberían llamarse 'StoryImageView' y 'StoryTitleLabel', arreglar al final, si queda tiempo.")
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var projectNameLabel: UILabel!
    
    
    var storyName: String? // Here we store the storyname
    //var nodeList: [SKSpriteNode] = [] //Here we store every node that this story has
    
    override func awakeFromNib() {
        super .awakeFromNib()
        //initialization code
        projectImageView.image = UIImage(named: "ivory paper")
        projectImageView.layer.cornerRadius = 10
        projectImageView.isUserInteractionEnabled = true
        projectNameLabel.text = "New Story"
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender: )))
        projectImageView.addGestureRecognizer(longPress)
        }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer){
        if sender.state == .began {
            let menu = UIMenuController.shared
            becomeFirstResponder()
            
            
        }
    }
}

/*Our custom Colection View Cell, it has an image view and a label so we can present the Story name and image (if there's any) on our app's main page */
