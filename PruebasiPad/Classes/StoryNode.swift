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

    @objc dynamic var chapter: Chapter?
    @objc dynamic var stringUUID: String? = UUID().uuidString
    var childrenNodesUUID = List<String>()
    @objc dynamic weak var parentNode: StoryNode?

    
    // MARK: - Helper functions
    func add(child: StoryNode){
        self.childrenNodesUUID.append(child.stringUUID!)
        child.parentNode = self
    }
    
    func deleteSons(){
        do {
            let realm = try Realm()
            for childId in childrenNodesUUID{
                let childNode = realm.objects(StoryNode.self).filter(NSPredicate(format: "stringUUID CONTAINS %@", childId)).first
                childNode?.deleteSons()
                try realm.write {
                    realm.delete(childNode!)
                }
            }
        } catch {
            print("Unable to locate and delete sons")
        }
    }
}

/* This is our custom Node class, it conforms the NSCodign protocol so it can be stored.
It also holds a Chapter variable that holds information. */
