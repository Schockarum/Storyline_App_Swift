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

    
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var projectNameLabel: UILabel!
    
    var storyName: String? // Here we store the storyname
    var nodeList: [SKSpriteNode] = [] //Here we store every node that this story has
    
    override func awakeFromNib() {
        super .awakeFromNib()
        //initialization code
        projectImageView.image = UIImage(named: "ivory paper")
        projectImageView.layer.cornerRadius = 10
        projectNameLabel.text = "New Story"
        }
}
