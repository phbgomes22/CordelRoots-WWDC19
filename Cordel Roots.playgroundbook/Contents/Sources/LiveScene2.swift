//
//  LiveScene2.swift
//  PlaygroundEmbeded
//
//  Created by Pedro Gomes on 22/03/19.
//  Copyright © 2019 Pedro Gomes. All rights reserved.
//

import SpriteKit

public class LiveScene2: SKScene {
    
    // MARK: - SpriteNodes
    
    var backgroundSprite = SKSpriteNode()
    var backgroundSpriteColor = SKSpriteNode()
    public var littleSunSprite = SKSpriteNode()
    public var bigSunSprite = SKSpriteNode()
    // MARK: - Bools
    
    var isGluedToLetter = false
    
    // MARK: - Counters
    
    var timesDropped = 0
    var linesShown = 0
    
    // MARK: -
    // MARK: - Functions
    
    public override func didMove(to view: SKView) {
        
        setupScenary()
        
        self.addSound()
        
        self.animateSun()
        
//        animateSpriteSide()
    }
    
    
    // MARK: - Setup Functions
    
    func setupScenary() {
        // BackgroundSprite and overlay setup
        
        let indexInformation = 0
        backgroundSprite.texture = SKTexture(imageNamed: "backgroundLiveView2")
        backgroundSprite.size = CGSize(width: 2*640-20, height: 880 + 100)
        backgroundSprite.alpha = 0.4
        
        backgroundSpriteColor = SKSpriteNode(color: MatrixInformation.charColor[indexInformation], size: CGSize(width: 2*640-20, height: 880 + 230))
        backgroundSpriteColor.zPosition = -51
        
        backgroundSprite.zPosition = -50
        backgroundSprite.name = "backgroundSprite"
        self.addChild(backgroundSprite)
        self.addChild(backgroundSpriteColor)
        
        
        
        // LittleSunSprite setup
        littleSunSprite.texture = SKTexture(imageNamed: CordelInformation.sunImage[1])
        littleSunSprite.size = CGSize(width: 90.0, height: 90.0)
        littleSunSprite.position = CGPoint(x: -80.0, y: 320.0)
        
        littleSunSprite.name = SpriteNames.littleSunSprite.rawValue
        littleSunSprite.zPosition = 40
        littleSunSprite.alpha = 0.4
        
        self.addChild(littleSunSprite)
        
        // BigSunSprite setup
        
        bigSunSprite.texture = SKTexture(imageNamed: CordelInformation.bigSunImage[1])
        bigSunSprite.size = CGSize(width: 400.0, height: 400.0)
        bigSunSprite.name = SpriteNames.bigSunSprite.rawValue
        bigSunSprite.zPosition = 30
        bigSunSprite.position = littleSunSprite.position
        bigSunSprite.alpha = 0.4
        
        self.addChild(bigSunSprite)
        
    }
    
    
    public func addSound() {
        
        let indexInfo = 0
        
        let backgroundSound = SKAudioNode(fileNamed: MatrixInformation.soundName[indexInfo])
        addChild(backgroundSound)
        
        backgroundSound.run(SKAction.play())
    }
    
    
    // MARK: -
    // MARK: Game Logic and Animations
    
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
