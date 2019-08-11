//
//  NodeMapScene.swift
//  PruebasiPad
//
//  Created by Luis Mauricio Esparza Vazquez on 8/3/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import SpriteKit
import GameplayKit

class NodeMapScene: SKScene {
    
    private var label : SKLabelNode?
    private var node : SKSpriteNode?
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "story background")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = -1
        addChild(background)
        }
}
