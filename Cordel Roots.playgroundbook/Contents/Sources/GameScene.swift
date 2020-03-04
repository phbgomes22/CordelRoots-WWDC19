//: A SpriteKit based Playground
// TODO: LOCK SHAKE UNTIL THEY CLICK IN THE CORDEL => OTHERWISE THE GREAT WILL APPEAR BEFORE IT

import PlaygroundSupport
import SpriteKit
import CoreMotion

public class GameScene: SKScene {
    
    // MARL : - PLAYGROUND INTERACTION:
    
    public var dayPeriod: TimeOfDay?
    
    // Motion Managers
    public var numberOfCordels = 0
    
    public var cordelsDropped = 0
    
    // MARK: - Sprite Nodes
    
    public var cordels: [Cordel] = []
    public var cordelsToDrop: Int = -1
    public var cordelsNotToDrop = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    public var littleSunSprite = SKSpriteNode()
    public var bigSunSprite = SKSpriteNode()
    public var kidLeftSprite = SKSpriteNode()
    public var kidRightSprite = SKSpriteNode()
    public var backgroundSprite = SKSpriteNode()
    public var lampLeftSprite = SKSpriteNode()
    public var lampRightSprite = SKSpriteNode()
    public var houseLeft = SKSpriteNode()
    public var houseRight = SKSpriteNode()
    public var overlaySprite = SKSpriteNode()
    public var linesSprite = SKSpriteNode()
    
    // INITIAL
    
    public var curtina1 = SKSpriteNode()
    public var curtina2 = SKSpriteNode()
    public var rope = SKSpriteNode()
    public var pushToStart = SKSpriteNode()
    
    var initPushPos: CGPoint = CGPoint.zero
    var ropeInitPos: CGPoint = CGPoint.zero
    
    var hasDroppedCurtina = false
    
    
    // POEM
    
    public var labelsPoem: [SKLabelNode] = []
    public var poem: [String] = []
    
    // MARK: - Bools
    
    /// Default value is false
    var isCordelPageOn = false
    
    /// Default value is true
    var shouldDropPaper = true
    /// Default value is false
    var isCordelDropped = false
    
    /// If there is a cordel on the floor
    var hasCordelDown = false
    
    
    public var motionManager = CMMotionManager()
    
    
    public override func didMove(to view: SKView){
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        
        motionManager.accelerometerUpdateInterval = 1.0/60.0
        motionManager.showsDeviceMovementDisplay = true
        
        
        self.setupFont()
        
        self.setupFolderTop()
        
        // Setup the cordel folders
        self.setupCordels()
        
        // Add other elements of scenary besides the cordels
        self.setupScenary()
        
        // Setup labels that will present the poem
        self.setupLabelsPoem()
        
        // Add wind and sun rotation to the scenary
        self.animateKids()
        self.animateSun()
        self.setupWind()
        self.animateHouses()
        
        // Add sound
        
        self.addSound()
        
        let indexInfo = dayPeriod?.rawValue ?? 0
        cordelsToDrop = CordelInformation.cordelToDrop[indexInfo]
    }
    
    public func setupFolderTop() {
        
        // CURTINAS
        curtina1.position = CGPoint(x: -300.0, y: 0.0)
        curtina1.size = CGSize(width: 600.0, height: 880.0)
        curtina1.texture = SKTexture(imageNamed: "cortina")
        curtina1.zPosition = 500
        
        
        curtina2.position = CGPoint(x: 300.0, y: 0.0)
        curtina2.size = curtina1.size
        curtina2.texture = SKTexture(imageNamed: "cortina")
        curtina2.zPosition = curtina1.zPosition
        curtina2.xScale = -1
        
        self.addChild(curtina1)
        self.addChild(curtina2)
        
        let rotate = SKAction.rotate(byAngle: .pi/60, duration: 4.2)
        let rotateBack = SKAction.rotate(byAngle: -.pi/60, duration: 4.2)
        
        let rotateGroup = SKAction.repeatForever(.sequence([rotate, rotate.reversed(), rotateBack, rotateBack.reversed()]))
        curtina1.run(rotateGroup)
        curtina2.run(rotateGroup)
        
        // ROPE
        
        rope.position = CGPoint(x: 190.0, y: 600.0)
        rope.size = CGSize(width: 60.0, height: 1200.0)
        rope.zPosition = curtina1.zPosition + 1
        rope.texture = SKTexture(imageNamed: "rope")
        rope.name = "rope"
        ropeInitPos = rope.position
        
        self.addChild(rope)
        animateRope()
        
        pushToStart.size = CGSize(width: 300.0, height: 170.0)
        pushToStart.position = CGPoint(x: 0.0, y: 170.0)
        pushToStart.zPosition = curtina1.zPosition + 2
        pushToStart.texture = SKTexture(imageNamed: "pullToStart")
        
        pushToStart.run(.sequence([rotateBack, rotateBack.reversed(), rotate, rotate.reversed()]))
        
        self.addChild(pushToStart)
    }
    
    public func setupScenary() {
        
        
        let indexInfo = dayPeriod?.rawValue ?? 0
        
        // LittleSunSprite setup
        littleSunSprite.texture = SKTexture(imageNamed: CordelInformation.sunImage[indexInfo])
        littleSunSprite.size = CGSize(width: 90.0, height: 90.0)
        littleSunSprite.position = CGPoint(x: 80.0, y: 320.0)
        
        littleSunSprite.name = SpriteNames.littleSunSprite.rawValue
        littleSunSprite.zPosition = -30
        
        self.addChild(littleSunSprite)
        
        // BigSunSprite setup
        
        bigSunSprite.texture = SKTexture(imageNamed: CordelInformation.bigSunImage[indexInfo])
        bigSunSprite.size = CGSize(width: 400.0, height: 400.0)
        bigSunSprite.name = SpriteNames.bigSunSprite.rawValue
        bigSunSprite.zPosition = -40
        bigSunSprite.position = littleSunSprite.position
        
        self.addChild(bigSunSprite)
        
        
        // Kids setup
        
        kidLeftSprite.texture = SKTexture(imageNamed: "kidCordel")
        kidLeftSprite.size = CGSize(width: 210.0, height: 300.0)
        
        kidLeftSprite.position = CGPoint(x: -160.0, y: -445.0)
        kidLeftSprite.name = SpriteNames.kidLeftSprite.rawValue
        kidLeftSprite.zPosition = 15
        kidLeftSprite.zRotation = .pi/28
        kidRightSprite.zRotation = -.pi/28
        kidRightSprite.texture = SKTexture(imageNamed: "kidCordel")
        kidRightSprite.size = kidLeftSprite.size
        kidRightSprite.name = SpriteNames.kidRightSprite.rawValue
        kidRightSprite.position = CGPoint(x: 160.0, y: -445.0)
        kidRightSprite.zPosition = kidLeftSprite.zPosition
        
        kidRightSprite.xScale = -1
        self.addChild(kidLeftSprite)
        self.addChild(kidRightSprite)
        
        // BackgroundSprite and overlay setup
        
        
        backgroundSprite.texture = SKTexture(imageNamed: CordelInformation.backgroundImage[indexInfo])
        backgroundSprite.size = CGSize(width: 2*640-20, height: 880 + 230)
        
        backgroundSprite.zPosition = -100
        backgroundSprite.name = SpriteNames.backgroundSprite.rawValue
        self.addChild(backgroundSprite)
        
        overlaySprite = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.8), size: CGSize(width: 2*640-20, height: 880 + 230))
        overlaySprite.zPosition = 30
        overlaySprite.alpha = 0.0
        self.addChild(overlaySprite)
        
        
        
        // Lamps setup
        
        lampLeftSprite.texture = SKTexture(imageNamed: CordelInformation.lampImage[indexInfo])
        lampLeftSprite.size = CGSize(width: 82, height: 500.0)
        lampLeftSprite.position = CGPoint(x: -260 + 15, y: 40.0)
        
        lampRightSprite.texture = lampLeftSprite.texture
        lampRightSprite.size = lampLeftSprite.size
        lampRightSprite.position = CGPoint(x: 260 - 15, y: 40.0)
        
        self.addChild(lampLeftSprite)
        self.addChild(lampRightSprite)
        
        
        // Houses setup
        
        let houseTexture = SKTexture(imageNamed: "houseCordelRight")
        houseLeft.name = "house"
        houseRight.name = "house"
        houseLeft.size = CGSize(width: 370, height: 280)
        houseLeft.texture = houseTexture
        houseRight.texture = houseTexture
        houseRight.size = houseLeft.size
        houseRight.position = CGPoint(x: 480, y: 80)
        houseLeft.position = CGPoint(x: -480, y: 80)
        houseRight.zPosition = -20
        houseLeft.zPosition = -20
        // 480
        self.addChild(houseLeft)
        self.addChild(houseRight)
        
    }
    
    func setupFont() {
        
        let fontURL = Bundle.main.url(forResource: "CordelEncarnado", withExtension: "otf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
        
    }
    
    // SETUP LABELS POEM
    func setupLabelsPoem() {
        
        let indexInfo = dayPeriod?.rawValue ?? TimeOfDay.Morning.rawValue
        
        for times in 0...5 {
            let label = SKLabelNode(fontNamed: "Cordel Encarnado")
            label.text = CordelInformation.poems[indexInfo][times]
            label.alpha = 0.0
            label.fontColor = UIColor(red: 243.0/255.0, green: 238/255.0, blue: 222.0/255.0, alpha: 1.0)
            label.fontSize = 30
            label.position = CGPoint(x: 0.0, y: 0.0 - CGFloat(40*times))
            label.zPosition = 50
            self.addChild(label)
            labelsPoem.append(label)
        }
        
    }
    
    
    public func addSound() {
        
        let indexInfo = dayPeriod?.rawValue ?? TimeOfDay.Morning.rawValue
        
        let backgroundSound = SKAudioNode(fileNamed: CordelInformation.soundName[indexInfo])
        addChild(backgroundSound)
        
        backgroundSound.run(SKAction.play())
    }
    
    // MARK: - Calculate Positions
    
    
    func setupCordelFolderLog(time: Int) {
        let indexInfo = dayPeriod ?? TimeOfDay.Morning
        
        let cordelFolder = Cordel(time: time, orientation: .Downwards, timeOfDay: indexInfo)
        
        self.addChild(cordelFolder.sprite)
        cordels.append(cordelFolder)
    }
    
    func setupCordelFolderExp(time: Int, yPosition: Double) {
        
        let indexInfo = dayPeriod ?? TimeOfDay.Morning
        
        let cordelFolder = Cordel(time: time, orientation: .Upwards, yPosition: yPosition, timeOfDay: indexInfo)
        self.addChild(cordelFolder.sprite)
        cordels.append(cordelFolder)
    }
    
    public func setupCordels() {
        
        
        let indexInfo = dayPeriod?.rawValue ?? 0
        
        linesSprite.texture = SKTexture(imageNamed: CordelInformation.linesImage[indexInfo])
        linesSprite.size = CGSize(width: 500.0, height: 230.0)
        linesSprite.position = CGPoint(x: 0.0, y: 125.0)
        
        linesSprite.zPosition = -1
        
        self.addChild(linesSprite)
        
        for time in 1...5{
            setupCordelFolderExp(time: time, yPosition: 90)
        }
        
        for time in 2...5 {
            setupCordelFolderLog(time: time)
        }
        
        for time in 1...4{
            setupCordelFolderExp(time: time, yPosition: -60)
        }
        
    }
    
    // MARK: -
    // MARK: - Interactions
    
    // MARK: - Motion Handler
    
    public func accelerationHandler(_ deviceMotion: CMAccelerometerData?) {
        
        if(hasCordelDown){
            return
        }
        
        if let data = deviceMotion {
            
            if(data.acceleration.x > 1.1 || data.acceleration.y > 1.1 || data.acceleration.z > 0.8){
                if(shouldDropPaper){
                    shouldDropPaper = false
                    dropPaper { [weak self](_) in
                        
                        self?.shouldDropPaper = true
                    }
                }
            }
        }
        
    }
    
    // MARK: - Touches
    
    func touchMoved(toPoint: CGPoint) {
        
        let diffY = toPoint.y - initPushPos.y
        
        rope.position = CGPoint(x: rope.position.x, y: rope.position.y + diffY)
        
        initPushPos = toPoint
    }
    
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(initPushPos == CGPoint.zero){
            return
        }
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        for t in touches {
            
            let touchedNodes = self.nodes(at: t.location(in: self))
            
            for node in touchedNodes{
                if node.name == "rope" {
                    rope.removeAllActions()
                    initPushPos = t.location(in: self)
                    return
                }
                    
                else if node.name == "cordel\(self.cordelsToDrop)"{
                    if isCordelDropped {
                        presentCordelPage()
                        return
                    }
                }
                    
                else if node.name == "house" {
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
                    kidRightSprite.run(sound)
                    return
                }
            }
        }
    }
    
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(rope.position.y < 400 && initPushPos != CGPoint.zero && !hasDroppedCurtina){
            self.moveCurtinas()
        }
        else if (rope.position.y >= 400 && !hasDroppedCurtina) {
            let action = SKAction.move(to: ropeInitPos, duration: 1.0)
            action.timingMode = SKActionTimingMode.easeIn
            rope.run(action)
            animateRope()
        }
    }
    
    func presentCordelPage() {
        
        let indexInfo = dayPeriod?.rawValue ?? 0
        
        let duration: TimeInterval = 0.8
        
        if(self.isCordelPageOn){
            return
        } // else
        
        /// FOR TESTS WITHOUT THE IPAD, ADD DROPPAPER FUNCTION HERE
        
        let indexCordel = self.cordelsToDrop
        self.cordels[indexCordel].sprite.removeAllActions()
        
        let makeItBigger = SKAction.scale(to: CGSize(width: 150, height: 210.18), duration: duration)
        let rotate = SKAction.rotate(toAngle: 0.0, duration: duration)
        let move = SKAction.move(to: CGPoint(x: 0.0, y: 200.0), duration: duration)
        
        let groupTransition = SKAction.group([makeItBigger, rotate, move])
        
        let sound = SKAction.playSoundFileNamed("paperFlip", waitForCompletion: false)
        self.cordels[indexCordel].sprite.run(sound)
        
        
        let overlayAppear = SKAction.fadeAlpha(by: 1.0, duration: duration)
        self.overlaySprite.run(overlayAppear)
        self.cordels[indexCordel].sprite.zPosition = 31
        self.cordels[indexCordel].sprite.run(
            groupTransition,
            completion: { [weak self] in
                
                let scale = SKAction.scale(by: 1.03, duration: 1.0)
                self!.cordels[indexCordel].sprite.run(.repeatForever(.sequence([scale, scale.reversed()])))
                self!.presentLabelPoems()
                self?.isCordelPageOn = true
        })
        
    }
    
    func dismissCordelPage() {
        
        let duration: TimeInterval = 0.8
        
        let overlayAppear = SKAction.fadeAlpha(by: -1.0, duration: duration)
        self.overlaySprite.run(overlayAppear)
        
        let makeItBigger = SKAction.scale(to: CGSize(width: 40.0, height: 50.0), duration: duration)
        let rotate = SKAction.rotate(toAngle: .pi/2, duration: duration)
        let move = SKAction.move(to: CGPoint(x: 0.0, y: -150), duration: duration)
        
        let groupTransition = SKAction.group([makeItBigger, rotate, move])
        let wait = SKAction.wait(forDuration: 0.3)
        let hide = SKAction.fadeAlpha(to: 0.0, duration: 0.3)
        let sequenceReduceAndHide = SKAction.sequence([groupTransition, wait, hide])
        let cordelToAnimateIndex = cordelsToDrop
        self.cordels[cordelToAnimateIndex].sprite.run(
            sequenceReduceAndHide,
            completion: { [weak self] in
                
                // THE CORDEL IS NOT ON THE FLOOR ANYMORE
                self?.hasCordelDown = false
                
                // THE PAGE IS NOT ON ANYMORE
                self?.isCordelPageOn = false
        })
    }
    
    
    // MARK: -
    // MARK: - Animations
    
    // MARK: - Move Curtinas
    
    func moveCurtinas() {
        
        hasDroppedCurtina = true
        
        let moveRight = SKAction.move(by: CGVector(dx: 700.0, dy: 0.0), duration: 2.7)
        moveRight.timingMode = SKActionTimingMode.easeIn
        let moveUp = SKAction.move(by: CGVector(dx: 0.0, dy: 500.0), duration: 2.0)
        let rotateLabel = SKAction.rotate(byAngle: .pi/8, duration: 5.0)
        let moveUpRope = SKAction.move(by: CGVector(dx: 0.0, dy: 1200.0), duration: 2.0)
        moveUp.timingMode = SKActionTimingMode.easeIn
        moveUpRope.timingMode = SKActionTimingMode.easeIn
        curtina1.run(moveRight.reversed())
        curtina2.run(moveRight)
        
        rope.name = ""
        rope.isUserInteractionEnabled = false
        initPushPos = CGPoint.zero
        rope.run(moveUpRope)
        let sound = SKAction.playSoundFileNamed("winSound", waitForCompletion: false)
        rope.run(sound)
        pushToStart.run(.group([rotateLabel, moveUp]))
        
        motionManager.startAccelerometerUpdates(to: .main) { (deviceMotion, error) in
            self.accelerationHandler(deviceMotion)
        }
    }
    
    // MARK: - Animate Rope
    
    func changeCordelAppearance() {
        
        self.cordels[cordelsToDrop].sprite.removeAllActions()
        
        let indexInfo = dayPeriod?.rawValue ?? 0
        
        let string = CordelInformation.cordelImage[indexInfo].appending("Tap")
        let newCordel = SKSpriteNode(texture: SKTexture(imageNamed: string))
        
        newCordel.position = self.cordels[cordelsToDrop].sprite.position
        newCordel.size = self.cordels[cordelsToDrop].sprite.size
        newCordel.zPosition = self.cordels[cordelsToDrop].sprite.zPosition + 1
        newCordel.alpha = 0.0
        
        self.addChild(newCordel)
        
        newCordel.run(.fadeIn(withDuration: 0.3))
    }
    
    // MARK: - Animate Rope
    
    func animateRope(){
        
        let makeBigger = SKAction.scale(by: 1.05, duration: 0.8)
        rope.run(.repeatForever(.sequence([makeBigger, makeBigger.reversed()])))
    }
    
    
    // MARK: - Labels Poem
    
    func presentLabelPoems() {
        var times: Double = 0
        
        for label in labelsPoem {
            var addTime = 0.0
            if(times > 3.0) {
                addTime = 1.0
            }
            
            let wait = SKAction.wait(forDuration: 2*times + addTime)
            let appear = SKAction.fadeIn(withDuration: 0.3)
            
            label.run(.sequence([wait, appear]))
            
            times += 1
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)) {
             PlaygroundPage.current.assessmentStatus = .pass(message: " **Great!** When you're ready, go to the [**Next Page**](@next)!")
        }
    }
    
    // MARK: - Wind
    
    func setupWind() {
        
        for cordelPage in cordels {
            
            cordelPage.startWind()
        }
    }
    
    
    func dropPaper(completion: @escaping (_ success: Bool) -> Void) {
        
        // stops dropping
        if(cordelsDropped > 0){
            
            completion(false)
            return
        }
        
        let indexCordel = cordelsToDrop
        
        let cordel = cordels[indexCordel]
        
        // WILL HAVE A CORDEL ON THE FLOOR
        hasCordelDown = true
        
        let sound = SKAction.playSoundFileNamed("rootGlueSound", waitForCompletion: false)
        
        backgroundSprite.run(sound)
        
        cordel.dropCordel(timesDropped: cordelsDropped) { [weak self](_) in
            guard let `self` = self else {
                completion(false)
                return
            }
            
            // States that the given cordel is on the floor
            self.isCordelDropped = true
            // adds one to dropped cordels
            self.cordelsDropped += 1
            completion(true)
        }
        
    }
    
    
    // MARK: - Sun
    
    func animateKids() {
        
        let kidRightRotation = SKAction.rotate(byAngle: -.pi/27, duration: 2.0)
        
        kidLeftSprite.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        kidRightSprite.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        kidRightSprite.run(.repeatForever(.sequence([kidRightRotation, kidRightRotation.reversed()])))
        
        kidLeftSprite.run(.repeatForever(.sequence([kidRightRotation.reversed(), kidRightRotation])))
    }
    
    func animateSun() {
        
        let littleSunRotate = SKAction.repeatForever(.rotate(byAngle: .pi, duration: 15.0))
        
        littleSunSprite.run(littleSunRotate)
        
        let bigSunRotate = SKAction.repeatForever(.rotate(byAngle: -.pi, duration: 30.0))
        
        bigSunSprite.run(bigSunRotate)
    }
    
    func animateHouses() {
        let goUp = SKAction.move(by: CGVector(dx: 0.0, dy: 5.0), duration: 1.0)
        houseLeft.run(.repeatForever(.sequence([goUp, goUp.reversed()])))
        houseRight.run(.repeatForever(.sequence([goUp, goUp.reversed()])))
    }
    
    @objc public static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
}
