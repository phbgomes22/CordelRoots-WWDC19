//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Instantiates a live view and passes it to the PlaygroundSupport framework.
//

import UIKit
import PlaygroundSupport
import SpriteKit

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 880))
if let scene = LiveScene1(fileNamed: "LiveScene1") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    scene.backgroundColor = UIColor(red: 253.0/255.0, green: 248/255.0, blue: 232.0/255.0, alpha: 1.0)
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundPage.current.liveView = sceneView
