//
//  GameViewController.swift
//  SpriteKitPlaygrounds
//
//  Created by Luis Mauricio Esparza Vazquez on 8/2/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var mainPageCollectionViewReference: MainPageCollectionViewController! //For code injection
    var storyFromMainReference: Story?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "NodeMapScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    //MARK: Helper Functions
    func returnToMainMenu(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let storyboard = appDelegate.window?.rootViewController?.storyboard else { return }
        if let vc = storyboard.instantiateInitialViewController() {
            print("Go to main menu")
            self.present(vc, animated: true, completion: nil)
        }
    }
}
