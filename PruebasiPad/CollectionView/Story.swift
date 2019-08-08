//
//  Stories.swift
//  Storyline
//
//  Created by Luis Mauricio Esparza Vazquez on 8/4/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit

class Story: NSObject, NSCoding {
    
    var image: UIImage? //Image for the CollectionViewController
    var storyName: String? //Name for the CVC
    var root: SKStoryNode //Root for the tree structure, it contains the rest of the story nodes recursively.
    let uuid = UUID() //Unique identifier so we never make the same data for stories with the same name
    
    
    
    init(name: String = "New Story", initialNode: SKStoryNode = SKStoryNode()){
        self.storyName = name
        self.root = initialNode
    }
    
    // MARK: - NSCoding Protocol
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let workName = aDecoder.decodeObject(forKey: "storyName") as? String,
            let rootNode = aDecoder.decodeObject(forKey: "rootNode") as? SKStoryNode
            else { return nil }
        self.init(name: workName, initialNode: rootNode)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: "image")
        aCoder.encode(storyName, forKey: "storyName")
        aCoder.encode(root, forKey: "rootNode")
    }
    
    // MARK: - Utility functions
    
    func setStoryImage(image: UIImage){
        self.image = image
    }
    
}

/*Story is the class responsible of storing the starting data of a story, such as the title, the associed image to it and the root node of it.
 It conforms to the NSCoding Protocol so it can be stored and it can persist.*/