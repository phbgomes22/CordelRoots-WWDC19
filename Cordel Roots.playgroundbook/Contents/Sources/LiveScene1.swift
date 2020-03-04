//: A SpriteKit based Playground

import SpriteKit
import PlaygroundSupport

public class LiveScene1: SKScene {
   
    // MARK: - Sprite Nodes
    
    public var littleSunSprite = SKSpriteNode()
    public var bigSunSprite = SKSpriteNode()
    public var kidLeftSprite = SKSpriteNode()
   // public var backgroundSprite = SKSpriteNode()
    public var lampRightSprite = SKSpriteNode()
    public var houseLeft = SKSpriteNode()
    
    
    // POEM
    
    public override func didMove(to view: SKView){
        
        // Add other elements of scenary besides the cordels
        self.setupScenary()
        
        // Add wind and sun rotation to the scenary
    //    self.animateKids()
        self.animateSun()
        
        // Add sound
        
        self.addSound()
    }
    

    public func setupScenary() {
        
        
        let indexInfo =  0
        
        // LittleSunSprite setup
        littleSunSprite.texture = SKTexture(imageNamed: CordelInformation.sunImage[indexInfo])
        littleSunSprite.size = CGSize(width: 90.0, height: 90.0)
        littleSunSprite.position = CGPoint(x: 80.0, y: 320.0)
        
        littleSunSprite.name = SpriteNames.littleSunSprite.rawValue
        littleSunSprite.zPosition = 40
        
        self.addChild(littleSunSprite)
        
        // BigSunSprite setup
        
        bigSunSprite.texture = SKTexture(imageNamed: CordelInformation.bigSunImage[indexInfo])
        bigSunSprite.size = CGSize(width: 400.0, height: 400.0)
        bigSunSprite.name = SpriteNames.bigSunSprite.rawValue
        bigSunSprite.zPosition = 30
        bigSunSprite.position = littleSunSprite.position
        
        self.addChild(bigSunSprite)
        
        
        // BackgroundSprite and overlay setup
        
        
//        backgroundSprite.texture = SKTexture(imageNamed: CordelInformation.backgroundImage[indexInfo])
//        backgroundSprite.size = CGSize(width: 2*640-20, height: 880 + 230)
//
//        backgroundSprite.zPosition = -100
//        backgroundSprite.name = SpriteNames.backgroundSprite.rawValue
//        self.addChild(backgroundSprite)
        
//        // Lamps setup
//
//        lampRightSprite.texture = SKTexture(imageNamed: CordelInformation.lampImage[indexInfo])
//        lampRightSprite.size = CGSize(width: 82, height: 500.0)
//        lampRightSprite.position = CGPoint(x: 190 - 15, y: 40.0)
//
//        self.addChild(lampRightSprite)
//
//        // Kids setup
//
//        kidLeftSprite.texture = SKTexture(imageNamed: "kidCordel")
//        kidLeftSprite.size = CGSize(width: 210.0, height: 300.0)
//
//        kidLeftSprite.position = CGPoint(x: -120.0, y: -445.0)
//        kidLeftSprite.name = SpriteNames.kidLeftSprite.rawValue
//        kidLeftSprite.zPosition = 15
//        kidLeftSprite.zRotation = .pi/28
//        self.addChild(kidLeftSprite)
//
//        // Houses setup
//
//        let houseTexture = SKTexture(imageNamed: "houseCordelRight")
//        houseLeft.name = "house"
//        houseLeft.size = CGSize(width: 370, height: 280)
//        houseLeft.texture = houseTexture
//        houseLeft.position = CGPoint(x: -220, y: 80)
//        houseLeft.zPosition = -20
//        houseLeft.xScale = -1
//        // 480
//        self.addChild(houseLeft)
        
    }
    
    
    public func addSound() {
        
        let backgroundSound = SKAudioNode(fileNamed: CordelInformation.soundName[0])
        addChild(backgroundSound)
        
        backgroundSound.run(SKAction.play())
    }
    
    // MARK: -
    // MARK: - Interactions
    
    
    // MARK: - Touches
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        for t in touches {
            
            let touchedNodes = self.nodes(at: t.location(in: self))
            
            for node in touchedNodes{
            
                if node.name == "house" {
                    print("house")
                    let sound = SKAction.playSoundFileNamed("houses", waitForCompletion: false)
                    node.run(sound)
                    return
                }
                    
                else if  node.name == SpriteNames.kidLeftSprite.rawValue{
                    let sound = SKAction.playSoundFileNamed("heyLeft", waitForCompletion: false)
                    kidLeftSprite.run(sound)
                    return
                }
                    
                else if  node.name == SpriteNames.kidRightSprite.rawValue{
                    let sound = SKAction.playSoundFileNamed("heyRight", waitForCompletion: false)
                    kidLeftSprite.run(sound)
                    
                    return
                }
            }
        }
    }
    
    
    // MARK: -
    // MARK: - Animations
    
    
    
    
    // MARK: - Wind
    
    // MARK: - Sun
    
    func animateKids() {
        
        let kidRightRotation = SKAction.rotate(byAngle: -.pi/27, duration: 3.5)
        
        kidLeftSprite.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        
        kidLeftSprite.run(.repeatForever(.sequence([kidRightRotation.reversed(), kidRightRotation])))
    }
    
    func animateSun() {
        
        let littleSunRotate = SKAction.repeatForever(.rotate(byAngle: .pi, duration: 15.0))
        
        littleSunSprite.run(littleSunRotate)
        
        let bigSunRotate = SKAction.repeatForever(.rotate(byAngle: -.pi, duration: 30.0))
        
        bigSunSprite.run(bigSunRotate)
    }

    @objc public static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
}
