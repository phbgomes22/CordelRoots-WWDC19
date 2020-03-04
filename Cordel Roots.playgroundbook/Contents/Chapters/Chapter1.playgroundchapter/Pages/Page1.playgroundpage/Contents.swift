/*:
 ![Explain Path](banner1.png)
 
 __Cordel__ Literature is a traditional literary genre of Brazil. Its content is commonly written in __verses__ printed with __woodcut__ in small __leaflets__.
 


 ![Lets Try](tryBanner.png)
 
 
 Welcome to the 🌵 **Cordel Roots**
 
 When you're hooked you can not stop
 
 Prepare your walking boots
 
 **Shake your iPad to drop!**
 
 
 
  - Experiment:  Drop a cordel During the __morning__ ☀️ or at __night__ 🌙 to see some of the most common genres of cordels that brazilians read to __shake__ off the bad mood. **Run the code** to start!
 
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

var selection: TimeOfDay?
//
func setTimeOfDay(time: TimeOfDay) {
    selection = time
}
//
//#-end-hidden-code
setTimeOfDay(time: /*#-editable-code */.Morning/*#-end-editable-code*/)
//#-code-completion(identifier, show, Morning, Night)
//#-code-completion(everything, hide)
//#-hidden-code

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 880))
if let scene = GameScene(fileNamed: "GameScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    scene.dayPeriod = selection
    
    // Present the scene
    sceneView.presentScene(scene)
}


PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
//#-end-hidden-code
