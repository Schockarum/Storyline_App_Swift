//
//  ProjectCell.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 7/28/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell{

    
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var projectNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super .awakeFromNib()
        //initialization code
        projectImageView.image = UIImage(named: "MainBackground")
        projectImageView.layer.cornerRadius = 8
        projectNameLabel.text = "It Works!"
    }
    
}
