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
    
    let mainNodeColor = "light green node"
    let childNodeColor = "yellow node"
    
    private var label : SKLabelNode?
    private var node : SKSpriteNode?
    var storyId: String? //The story uuid we selected on the collection view is injected here.
    
    var storyLabel = SKLabelNode(fontNamed: "HelveticaNeue-Thin")
    let realm = try! Realm()
    
    // Tree Navigation Variables:
    var visitedNodes: [StoryNode] = []
    var actualNode: StoryNode?
    
    
    // MARK: - Override Functions
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "story background")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = -1
        addChild(background)
        
        // Get access to Story so we can build the UI
        let story = realm.objects(Story.self).filter(NSPredicate(format: "uuid CONTAINS %@", self.storyId!)).first //Query to get story based on the id
        storyLabel.fontSize = 50
        storyLabel.position = CGPoint(x: 20, y: 20)
        storyLabel.text = story?.storyName ?? " "
        storyLabel.zPosition = 1
        storyLabel.horizontalAlignmentMode = .left
        addChild(storyLabel)
        
        addEmitter()
        //Ya tenemos el story, ahora obtenemos su info
        spawnAsRootNode(node: story!.root!)
        
        }
    
    // MARK: - Utility Functions
    
    func spawnAsRootNode(node: StoryNode){
        visitedNodes.append(node) //We add the node to the visited list
        actualNode = node //We change the focus of the actual node
        let rootNode = SKSpriteNode(imageNamed: mainNodeColor)
        rootNode.position = CGPoint(x: size.width/2, y: size.height/2)
        rootNode.size = CGSize(width: 200, height: 200)
        
        let nodeName = SKLabelNode(text: node.chapter?.chapterTitle ?? " ")
        nodeName.fontName = "HelveticaNeue-Thin"
        nodeName.fontSize = 25
        nodeName.fontColor = .black
        nodeName.zPosition = 100
        nodeName.horizontalAlignmentMode = .center
        rootNode.addChild(nodeName)
        
        addChild(rootNode)
        
        //Spawn everychildren around this node.
        spawnChildrenAround(node: node)
    }
    
    func spawnChildrenAround(node: StoryNode){
        
    }
    
    func addEmitter(){
        let emitter = SKEmitterNode(fileNamed: "particles")
        emitter?.position = CGPoint(x: size.width/2, y: size.height/2)
        emitter?.particlePositionRange = CGVector(dx: 2650, dy: 2000)
        emitter?.particleBirthRate = CGFloat(integerLiteral: 5)
        addChild(emitter!)
    }
}
