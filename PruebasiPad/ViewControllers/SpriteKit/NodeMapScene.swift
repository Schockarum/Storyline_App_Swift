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
    let creationNodeColor = "purple node"
    
    private var label : SKLabelNode?
    private var node : SKSpriteNode?
    var storyId: String? //The story uuid we selected on the collection view is injected here.
    
    var storyLabel = SKLabelNode(fontNamed: "HelveticaNeue-Thin")
    let realm = try! Realm()
    
    // Tree Navigation Variables:
    var visitedNodes: [StoryNode] = []
    var actualChildren: [StoryNode] = []
    var actualNode: SKSpriteNode?
    var childDrawn = 0 //For keeping track of the child drawn
    
    
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
        
        //addEmitter() //Laaaag

        spawnAsRootNode(node: story!.root!)
        displayCreationNode()
        
        }
    
    // MARK: - Utility Functions
    func displayCreationNode(){
        let creationNode = SKSpriteNode(imageNamed: creationNodeColor)
        creationNode.position = CGPoint(x: size.width - 100, y: 100)
        creationNode.size = CGSize(width: 100, height: 100)
        
        let nodeName = SKLabelNode(text: "+")
        nodeName.fontName = "HelveticaNeue-Bold"
        nodeName.fontSize = 60
        nodeName.fontColor = .white
        nodeName.position = CGPoint(x: 0, y: -15)
        nodeName.zPosition = 100
        nodeName.horizontalAlignmentMode = .center
        creationNode.addChild(nodeName)
        
        addChild(creationNode)
    }
    
    func spawnAsRootNode(node: StoryNode){
        visitedNodes.append(node) //We add the node to the visited list
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
        
        actualNode = rootNode
        addChild(rootNode)
        
        //Spawn every children this node has around it.
        spawnChildrenAround(node: node)
    }
    
    //The story node that is marked down here is actually our last main focused node.
    func drawChild(radius: Double, nodeCount: Int, nodeToDraw: StoryNode){
        let degrees = 360/nodeCount
        let childNode = SKSpriteNode(imageNamed: childNodeColor)
        let x = radius * cos(Double(childDrawn * degrees))
        let y = radius * sin(Double(childDrawn * degrees))
        childNode.position = CGPoint(x: x, y: y)
        childNode.size = CGSize(width: 150, height: 150)
        
        let nodeName = SKLabelNode(text: nodeToDraw.chapter?.chapterTitle ?? " ")
        nodeName.fontName = "HelveticaNeue-Thin"
        nodeName.fontSize = 20
        nodeName.fontColor = .black
        nodeName.zPosition = 100
        nodeName.horizontalAlignmentMode = .center
        childNode.addChild(nodeName)
        
        actualNode?.addChild(childNode)
    }
    
    func spawnChildrenAround(node: StoryNode){
        do {
            let numberOfChildren = node.childrenNodesUUID.count
            let realm = try Realm()
            for childId in node.childrenNodesUUID{
                let childNode =  realm.objects(StoryNode.self).filter(NSPredicate(format: "stringUUID CONTAINS %@", childId)).first
                actualChildren.append(childNode!)
                drawChild(radius: 250, nodeCount: numberOfChildren, nodeToDraw: childNode!)
                childDrawn += 1
            }
        } catch {
            print("Unable to locate node's children.")
        }
        
    }
    
    func addEmitter(){
        let emitter = SKEmitterNode(fileNamed: "particles")
        emitter?.position = CGPoint(x: size.width/2, y: size.height/2)
        emitter?.particlePositionRange = CGVector(dx: 2650, dy: 2000)
        emitter?.particleBirthRate = CGFloat(integerLiteral: 5)
        addChild(emitter!)
    }
    
    // MARK: - Interaction Functions
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let position = touches.first?.location(in: self) else { return }
        guard let tappedNode = nodes(at: position).first(where: { $0 is SKSpriteNode}) else { return }
    }
}
