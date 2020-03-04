/*:
 ![Roots](rootsBanner.png)

 Celebrating our culture is a wonderful way of better knowing our __roots__. And by doing so, we are able to have a greater understanding of ourselves.
 
 We can create lots of knowledge by __reconnecting__ with the wisdom of our ancestors, and Cordel Literature is based a lot on that.

 - Experiment: __Run the code__ and connect the roots that are separeted from the tree!

 
 ![Lets Try](tryBanner.png)
 
 🌵 __Cordel Roots__ is near the end
 
 There's no need for feeling blue
 
 Was great having you here, friend!
 
 **Hope you've had a great time too!**

 
 */

//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//

import PlaygroundSupport
import SpriteKit


// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 880))
if let scene = GameScene3(fileNamed: "GameScene3") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

//#-end-hidden-code
