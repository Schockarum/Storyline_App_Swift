//
//  Nodes.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 7/29/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import SpriteKit

class SKStoryNode: SKNode {

    static var secureCoding = true
    override public class var supportsSecureCoding: Bool { return secureCoding }

    var chapter = Chapter()
    var childrenNodes: [SKStoryNode] = []
    weak var parentNode: SKStoryNode?
    
    init(chapter: Chapter = Chapter(), childNodes: [SKStoryNode] = []) { //With default values
        super.init()
        self.chapter = chapter
        self.childrenNodes = childNodes
    }
    
    // MARK: - NSCoding Protocol
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let chapter = aDecoder.decodeObject(of: Chapter.self, forKey: "chapter"),
        let children = aDecoder.decodeObject(of: [SKStoryNode.self], forKey: "childrenNodes")
            else { return nil }
        self.init(chapter: chapter, childNodes: children as! [SKStoryNode])
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(chapter, forKey: "chapter")
    }
    
    // MARK: - Helper functions
    
    func add(child: SKStoryNode){
        childrenNodes.append(child)
        child.parentNode = self
    }
}

/* This is our custom Node class, it conforms the NSCodign protocol so it can be stored.
It also holds a Chapter variable that holds information. */
