//
//  Nodes.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 7/29/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import SpriteKit
import RealmSwift

class StoryNode: Object {

    @objc dynamic var chapter = Chapter()
    @objc dynamic var childrenNodes: [StoryNode] = []
    @objc dynamic weak var parentNode: StoryNode?
    
    // MARK: - Helper functions
    
    func add(child: StoryNode){
        childrenNodes.append(child)
        child.parentNode = self
    }
}

/* This is our custom Node class, it conforms the NSCodign protocol so it can be stored.
It also holds a Chapter variable that holds information. */
