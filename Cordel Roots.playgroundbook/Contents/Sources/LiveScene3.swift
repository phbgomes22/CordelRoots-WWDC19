//
//  LiveScene3.swift
//  PlaygroundEmbeded
//
//  Created by Pedro Gomes on 22/03/19.
//  Copyright © 2019 Pedro Gomes. All rights reserved.
//

import SpriteKit

public class LiveScene3: SKScene {
    
 
    // MARK: Sprites
    
    public var backgroundSprite = SKSpriteNode()
    public var treeSprite = SKSpriteNode()
    public var finishLabelSprite = SKLabelNode()
    public var littleSunSprite = SKSpriteNode()
    public var bigSunSprite = SKSpriteNode()
    
    // Cactus
    
    var positionsCactus: [CGPoint] = [CGPoint(x: -400.0, y: -140.0), CGPoint(x: -250.0, y: -140.0), CGPoint(x: 260.0, y: -140.0), CGPoint(x: 400.0, y: -140.0)]
    var arrayCactus: [SKSpriteNode] = []

    
    public override func didMove(to view: SKView) {
        
        setupScenary()
        
        setupCactus()
        
        setupCloud()
        
        animateSun()
        
        addSound()
        
    }
    
    
    public func setupScenary() {
        
        // BackgroundSprite and overlay setup
        
        backgroundSprite.texture = SKTexture(imageNamed: "backgroundLiveView3")
        backgroundSprite.size = CGSize(width: 2*640-20, height: 880 + 230)
        backgroundSprite.position = CGPoint(x: 0.0, y: -124.0)
        backgroundSprite.zPosition = -100
        backgroundSprite.name = "background"
        self.addChild(backgroundSprite)
        
        
        treeSprite.color = .blue
        treeSprite.texture = SKTexture(imageNamed: "treeCordel")
        treeSprite.size = CGSize(width: 492.0, height: 290.0)
        treeSprite.position = CGPoint(x: 3.0, y: 10.0)
        treeSprite.zPosition = 1
        self.addChild(treeSprite)
        
        let indexInfo =  0
        
        // LittleSunSprite setup
        littleSunSprite.texture = SKTexture(imageNamed: CordelInformation.sunImage[indexInfo])
        littleSunSprite.size = CGSize(width: 90.0, height: 90.0)
        littleSunSprite.position = CGPoint(x: 80.0, y: 320.0)
        
        littleSunSprite.name = SpriteNames.littleSunSprite.rawValue
        littleSunSprite.zPosition = -70
        
        self.addChild(littleSunSprite)
        
        // BigSunSprite setup
        
        bigSunSprite.texture = SKTexture(imageNamed: CordelInformation.bigSunImage[indexInfo])
        bigSunSprite.size = CGSize(width: 400.0, height: 400.0)
        bigSunSprite.name = SpriteNames.bigSunSprite.rawValue
        bigSunSprite.zPosition = -80
        bigSunSprite.position = littleSunSprite.position
        
        self.addChild(bigSunSprite)
        
    }
    
    
    public func addSound() {
        
        let backgroundSound = SKAudioNode(fileNamed: "happySong3")
        addChild(backgroundSound)
        
        backgroundSound.run(SKAction.play())
    }
    
    
    func setupCloud() {
        
        let cloud = SKSpriteNode()
        let initPosition = CGPoint(x: 940, y: 240)
        let finishPosition = CGPoint(x: -940, y: 240)
        cloud.zPosition = -20
        cloud.size = CGSize(width: 185.0, height: 80.0)
        cloud.texture = SKTexture(imageNamed: "cloud")
        cloud.position = initPosition
        
        addChild(cloud)
        
        let actionGo = SKAction.move(to: finishPosition, duration: 10.0)
        let actionReturn = SKAction.move(to: initPosition, duration: 0)
        
        let sequence = SKAction.sequence([.wait(forDuration: 2.0), actionGo, actionReturn])
        cloud.run(.repeatForever(sequence))
        
        
        let cloud2 = SKSpriteNode()
        
        let initPosition2 = CGPoint(x: 910, y: 280)
        let finishPosition2 = CGPoint(x: -910, y: 280)
        cloud2.zPosition = -21
        cloud2.size = CGSize(width: 125.0, height: 60.0)
        cloud2.texture = SKTexture(imageNamed: "cloud")
        cloud2.position = initPosition
        
        addChild(cloud2)
        
        let actionGo2 = SKAction.move(to: finishPosition2, duration: 9.6)
        let actionReturn2 = SKAction.move(to: initPosition2, duration: 0)
        
        let sequence2 = SKAction.sequence([.wait(forDuration: 2.0), actionGo2, actionReturn2])
        cloud2.run(.repeatForever(sequence2))
    }
    
    func setupCactus() {
        
        for times in 0...3{
            let cactus = SKSpriteNode()
            if times > 1 {
                cactus.texture = SKTexture(imageNamed: "cactus0")
            }
            else {
                cactus.texture = SKTexture(imageNamed: "cactus1")
            }
            
            cactus.position = positionsCactus[times]
            cactus.size = CGSize(width: 110, height: 150)
            cactus.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            arrayCactus.append(cactus)
            self.addChild(cactus)
        }
        
        animateCactus()
        
    }
    
    func animateCactus() {
        
        let rotate = SKAction.rotate(byAngle: .pi/45, duration: 1.2)
        let rotateGroup = SKAction.repeatForever(.sequence([rotate, rotate.reversed(), rotate.reversed(), rotate]))
        
        var times: Double = 0.0
        for cactus in arrayCactus {
            
            let sequenceWait = SKAction.sequence([.wait(forDuration: times), rotateGroup])
            cactus.run(sequenceWait)
            
            times += 1
        }
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

