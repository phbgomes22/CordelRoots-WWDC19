//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

public class GameScene3: SKScene {
    
    // MARK: Sprites
    
    public var backgroundSprite = SKSpriteNode()
    public var treeSprite = SKSpriteNode()
    public var rootSprite = SKSpriteNode()
    public var finishLabelSprite = SKLabelNode()
    
    public var rightPositions: [CGPoint] = [CGPoint(x: -159, y: -48), CGPoint(x: -74.4, y: -119), CGPoint(x: 80, y: -122), CGPoint(x: 161, y: -48.5)]
    
    public var startPosition: [CGPoint] = [CGPoint(x: 0, y: -240), CGPoint(x: 150, y: -260), CGPoint(x: -90, y: -250), CGPoint(x: -140, y: -210)]
    
    public var cordelsPosition: [CGPoint] = [CGPoint(x: -142, y: 285), CGPoint(x: -60, y: 260), CGPoint(x: 60, y: 245), CGPoint(x: 140, y: 298)]
    
    public var spritesThatGlue: [SKSpriteNode] = []
    
    public var rootsToGlue: [SKSpriteNode] = []
    
    public var cordels: [SKSpriteNode] = []
    
    // Cactus
    
    var positionsCactus: [CGPoint] = [CGPoint(x: -400.0, y: 140.0), CGPoint(x: -250.0, y: 140.0), CGPoint(x: 260.0, y: 140.0), CGPoint(x: 400.0, y: 140.0)]
    var arrayCactus: [SKSpriteNode] = []
    
    
    //MARK: - Counters and saves
    
    /// THIS NEEDS TO BE -1 WHEN THE USER IS NOT HOLDING A ROOT
    var currentRootHeld: Int = -1
    public var cordelsShown = 0
    
    public override func didMove(to view: SKView) {
        
        setupFont()
        
        setupScenary()
        
        setupRootsLocked()
        
        setupRootsToGlue()
        
        setupCordels()
        
        setupFinishLabel()
        
        setupCactus()
        
        setupCloud()
        
        addSound()
    }
    
    func setupFont() {
        let fontURL = Bundle.main.url(forResource: "CordelEncarnado", withExtension: "otf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
    }
    
    public func setupScenary() {
        
        // BackgroundSprite and overlay setup
        
        backgroundSprite.texture = SKTexture(imageNamed: "backgroundPage3")
        backgroundSprite.size = CGSize(width: 2*640-20, height: 880 + 230)
        backgroundSprite.position = CGPoint(x: 0.0, y:-44.0)
        backgroundSprite.zPosition = -100
        backgroundSprite.name = "background"
        self.addChild(backgroundSprite)
        
        
        treeSprite.color = .blue
        treeSprite.texture = SKTexture(imageNamed: "treeCordel")
        treeSprite.size = CGSize(width: 492.0, height: 290.0)
        treeSprite.position = CGPoint(x: 3.0, y: 300.0)
        treeSprite.zPosition = 1
        self.addChild(treeSprite)
        
        rootSprite.texture = SKTexture(imageNamed: "rootsCordel")
        rootSprite.size = CGSize(width: 550.0, height: 320.0)
        rootSprite.position = CGPoint(x: 0.0, y: 10.0)
        rootSprite.zPosition = 2
        self.addChild(rootSprite)
    }
    
    
    public func setupRootsLocked() {
        
        var times = 0
        for point in rightPositions {
            let gluedSprite = SKSpriteNode(color: .black, size: CGSize(width: 40.0, height: 30.0))
            gluedSprite.name = "glue\(times)"
            gluedSprite.position = point
            gluedSprite.alpha = 0.0
            spritesThatGlue.append(gluedSprite)
            
            addChild(gluedSprite)
            times += 1
        }
    }
    
    public func setupRootsToGlue() {
        
        var times = 0
        for point in startPosition {
            
            let rootToGlue = SKSpriteNode()
            
            rootToGlue.texture = SKTexture(imageNamed: "rootsToGlue\(times)")
            rootToGlue.size = CGSize(width:44.0, height: 140.0)
            rootToGlue.position = point
            rootToGlue.name = "root\(times)"
            rootToGlue.zPosition = 20
            rootsToGlue.append(rootToGlue)
            
            animateRoots(root: rootToGlue)
            
            addChild(rootToGlue)
            times += 1
            
        }
    }
    
    
    
    public func setupCordels() {
        
        for point in cordelsPosition {
            let cordel = SKSpriteNode(color: .orange, size: CGSize(width: 0.1, height: 0.1))
            cordel.texture = SKTexture(imageNamed: "cordelPage3")
            cordel.position = point
            cordel.name = "cordel"
            cordel.zPosition = 10.0
            cordels.append(cordel)
            addChild(cordel)
            
            let rotate = SKAction.rotate(byAngle: .pi/8, duration: 0.5)
            let rotateBack = SKAction.rotate(byAngle: -.pi/8, duration: 0.5)
            
            cordel.run(.repeatForever(.sequence([rotate, rotate.reversed(), rotateBack, rotateBack.reversed()])))
            
        }
        
        print("Cordels Set")
        
    }
    
    func setupFinishLabel() {
        
        finishLabelSprite = SKLabelNode(fontNamed: "CordelEncarnado")
        finishLabelSprite.text = "Great!"
        finishLabelSprite.fontColor = UIColor(red: 243.0/255.0, green: 238/255.0, blue: 222.0/255.0, alpha: 1.0)
        
        //UIColor(red: 32.0/255.0, green: 32.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        finishLabelSprite.fontSize = 60.0
        finishLabelSprite.position = CGPoint(x: 0.0, y: -200.0)
        finishLabelSprite.verticalAlignmentMode = .center
        finishLabelSprite.alpha = 0.0
        finishLabelSprite.zPosition = 50.0
        
        
        let backgroundFinishLabel = SKSpriteNode()
        
        backgroundFinishLabel.texture = SKTexture(imageNamed: "greatNight")
        backgroundFinishLabel.size = CGSize(width: finishLabelSprite.frame.width + 70, height: finishLabelSprite.frame.height + 40)
        
        backgroundFinishLabel.zPosition = -1
        
        finishLabelSprite.addChild(backgroundFinishLabel)
        
        self.addChild(finishLabelSprite)
    }
    
    public func addSound() {
        
        let backgroundSound = SKAudioNode(fileNamed: "happySong3")
        addChild(backgroundSound)
        
        backgroundSound.run(SKAction.play())
    }
    
    // MARK: -
    // MARK: - Glue functions
    
    func checkIntersection(root: SKSpriteNode, glue: SKSpriteNode) -> Bool {
        
        let rootY = root.position.y + root.size.height/2.0
        
        let diffY = abs(rootY - glue.position.y)
        let diffX = abs(root.position.x - glue.position.x)
        
        if (diffY < 20 && diffX < 20){
            return true
        }
        return false
    }
    
    func glueRoot(root: SKSpriteNode, glue: SKSpriteNode) {
        root.position.x = glue.position.x
        
        root.position.y = glue.position.y - root.size.height/2.0
        
        let sound = SKAction.playSoundFileNamed("rootGlueSound", waitForCompletion: false)
        
        root.run(sound)
    }
    
    // MARK: -
    // MARK: - Touch Events
    
    
    public func touchDown(atPoint pos : CGPoint) {
        
        let touchedNodes = self.nodes(at: pos)
        
        for node in touchedNodes{
            
            if let name = node.name {
                if name.starts(with: "root"){
                    
                    node.removeAllActions()
                    switch name.last! {
                    case "0":
                        currentRootHeld = 0
                    case "1":
                        currentRootHeld = 1
                    case "2":
                        currentRootHeld = 2
                    case "3":
                        currentRootHeld = 3
                    default:
                        break
                    }
                }
                else if name == "cordel" {
                    node.run(.playSoundFileNamed("letterSound", waitForCompletion: false))
                }
                
                print(currentRootHeld)
                
                return
            }
        }
    }
    
    public func touchMoved(toPoint pos : CGPoint) {
        if currentRootHeld != -1 {
            // if it is holding
            
            rootsToGlue[currentRootHeld].position = pos
        }
    }
    
    public func touchUp(atPoint pos : CGPoint) {
        
        if(currentRootHeld == -1){
            return
        }
        
        let test = checkIntersection(root: rootsToGlue[currentRootHeld], glue: spritesThatGlue[currentRootHeld])
        
        if(test) {
            //
            animateCordel(cordel: cordels[cordelsShown])
            
            // it has shown a cordel
            cordelsShown += 1
            rootsToGlue[currentRootHeld].removeAllActions()
            glueRoot(root: rootsToGlue[currentRootHeld], glue: spritesThatGlue[currentRootHeld])
            rootsToGlue[currentRootHeld].name = ""
            rootsToGlue[currentRootHeld].isUserInteractionEnabled = false
            
            if(cordelsShown == 4){
                presentFinishLabel()
            }
        }
            
        else {
            var test2 = false
            
            animateRoots(root: rootsToGlue[currentRootHeld])
            
            for glue in spritesThatGlue {
                
                test2 = glue.intersects(rootsToGlue[currentRootHeld])
                if(test2){
                    rootsToGlue[currentRootHeld].run(SKAction.move(to: CGPoint(x: glue.position.x, y: glue.position.y - 120), duration: 0.3))
                    
                    break
                }
            }
        }
        
        /// is not holding anything
        currentRootHeld = -1
    }
    
    func animateRoots(root: SKSpriteNode) {
        
        let action = SKAction.scale(by: 1.1, duration: 1.0)
        
        root.run(.repeatForever(.sequence([action, action.reversed()])))
        
    }
    
    func animateCordel(cordel: SKSpriteNode) {
        
        let scale = SKAction.scale(to: CGSize(width: 40.0, height: 57.3), duration: 1.0)
        cordel.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        scale.timingMode = SKActionTimingMode.easeIn
        cordel.run(scale)
        
    }
    
    func presentFinishLabel() {
        let action = SKAction.fadeAlpha(by: 1.0, duration: 0.3)
        finishLabelSprite.run(action)
        
        let rotate = SKAction.rotate(byAngle: .pi/29.0, duration: 1.0)
        
        let rotateBack = SKAction.rotate(byAngle: -.pi/29.0, duration: 1.0)
        
        finishLabelSprite.run(.repeatForever(.sequence([rotate, rotate.reversed(), rotateBack, rotateBack.reversed()])))
        
        let sound = SKAction.playSoundFileNamed("winSound", waitForCompletion: false)
        finishLabelSprite.run(sound)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            PlaygroundPage.current.assessmentStatus = .pass(message: " **Great!** Thanks for playing! Hope you have enjoyd 🌵**Cordel Roots!**")
        }
    }
    
    func setupCloud() {
        
        let cloud = SKSpriteNode()
        let initPosition = CGPoint(x: 940, y: 280)
        let finishPosition = CGPoint(x: -940, y: 280)
        cloud.zPosition = -20
        cloud.size = CGSize(width: 185.0, height: 80.0)
        cloud.texture = SKTexture(imageNamed: "cloud")
        cloud.position = initPosition
        
        addChild(cloud)
        
        let actionGo2 = SKAction.move(to: finishPosition, duration: 8.0)
        let actionReturn2 = SKAction.move(to: initPosition, duration: 0)
        
        let sequence2 = SKAction.sequence([.wait(forDuration: 3.0), actionGo2,actionReturn2])
        cloud.run(.repeatForever(sequence2))
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
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    
    public override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    @objc public static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
}
