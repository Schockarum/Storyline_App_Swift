//
//  NodeMapScene.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 8/3/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import RealmSwift //Para acceder a los datos de las historias
import SpriteKit

class NodeMapScene: SKScene {
    
    private var label : SKLabelNode?
    private var node : SKSpriteNode?
    var storyId: String? //The story uuid we selected on the collection view is injected here.
    
    var storyLabel = SKLabelNode(fontNamed: "HelveticaNeue-Thin ")
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "story background")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = -1
        addChild(background)
        
        // Get access to Story so we can build the UI
        do {
            let realm = try Realm()
            let story = realm.objects(Story.self).filter(NSPredicate(format: "uuid CONTAINS %@", self.storyId!)).first //Query to get story based on the id
            storyLabel.fontSize = 50
            storyLabel.position = CGPoint(x: 20, y: 20)
            storyLabel.text = story?.storyName ?? " "
            storyLabel.zPosition = 1
            storyLabel.horizontalAlignmentMode = .left
            addChild(storyLabel)
        } catch {
            print("Unable to open realm database.")
        }
        
        
        
        }
}
