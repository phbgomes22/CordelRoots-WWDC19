/*:
 # Credits
 
 
 ### Game sounds
 
 - Sound effects obtained from [freesound](https://www.freesound.com/)
 
 ### Songs
 
 - All songs in this __Cordel Roots__ were kindly made available by [Trio Que Chora](https://www.youtube.com/watch?v=Z0gc_ygXAPs&fbclid=IwAR36T2U3JUL757CXkpX1j37PTqZ5H8V_sYBbNHEjAxSFf_lx-YohMfJNXyc)
 */

//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//

import UIKit
import PlaygroundSupport
import SpriteKit


// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 880))
if let scene = LiveScene2(fileNamed: "LiveScene2") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    
    // Present the scene
    sceneView.presentScene(scene)
}

// Instantiate a new instance of the live view from the book's auxiliary sources and pass it to PlaygroundSupport.
PlaygroundPage.current.liveView = sceneView
//#-end-hidden-code
