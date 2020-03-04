/*:
  ![Rhymes](banner2.png)
 
 
 Experienced cordelists very often become __repentists__: they are able to recite an __improvised cordel__ while still keeping its metrics and rhymes.
 
 But to do so, they must be very **quick on their feet** to find just the perfect word.

 - Experiment: Choose a theme to play with and try to find the rhymes that are missing.

 
 ![Lets Try](tryBanner.png)
 
 
 We all know the great effect
 
 That a rhyme does when it's heard
 
 **Slide your finger👇🏽 to connect**
 
 The letters to form a word!

 */

//#-code-completion(identifier, show, Folklore, DailyLife)
//#-code-completion(everything, hide)
//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//

import PlaygroundSupport
import SpriteKit

var selection: CordelType?

func selectCordel(type: CordelType) {
    selection = type
}
        
//#-end-hidden-code
selectCordel(type: /*#-editable-code */.Folklore/*#-end-editable-code*/)
//#-code-completion(identifier, show, Folklore, DailyLife)
//#-code-completion(everything, hide)
//#-hidden-code

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 880))
if let scene = GameScene2(fileNamed: "GameScene2") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    scene.poemSelection = selection
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

//#-end-hidden-code
