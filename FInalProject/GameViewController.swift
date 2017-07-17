//
//  GameViewController.swift
//  FInalProject
//
//  Created by Carlo Villaceran on 2016-10-08.
//  Copyright © 2016 Carlo Villaceran. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
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
    
    override func viewDidAppear(_ animated: Bool) {
       
        
    }

    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get {
            return .landscapeRight
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}



