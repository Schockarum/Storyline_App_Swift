//
//  GameViewController.swift
//  SpriteKitPlaygrounds
//
//  Created by Luis Mauricio Esparza Vazquez on 8/2/19.
//  Copyright © 2019 Schock. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var mainPageCollectionViewReference: MainPageCollectionViewController! //For code injection
    var storyFromMainReference: Story?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = NodeMapScene(size: CGSize(width: 2732, height: 2048))
        let skview = self.view as! SKView
        skview.showsFPS = true
        skview.showsNodeCount = true
        skview.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFit
        skview.presentScene(scene)
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
