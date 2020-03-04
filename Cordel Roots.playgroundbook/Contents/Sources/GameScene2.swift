import PlaygroundSupport
import SpriteKit

public class GameScene2: SKScene {
    
    // MARL : - PLAYGROUND INTERACTION:
    
    public var poemSelection: CordelType?
    public var poem: [[String]] = []
    
    // MARK: - Puzzle
    
    var matrix = [[String]]()
    var matrixDidSelected = [Bool]()
    
    let numberOfColums = 4
    let numberOfLines = 3
    let numberOfPuzzles = 3
    
    let yPosDelta = 60.0
    let timeBeforeStarts = 2
    
    var wordsToFind: [String] = []
    var startTouch: CGPoint?
    var secondTouch: CGPoint?
    
    var wordCreated = ""
    
    var nodesSelected: [String] = []
    
    // MARK: - SpriteNodes
    
    var line = SKShapeNode()
    
    var backgroundSprite = SKSpriteNode()
    var backgroundSpriteColor = SKSpriteNode()
    var tableMatrixSprite = SKSpriteNode()
    var cropNodeMatrix = SKCropNode()
    public var finishLabelSprite = SKLabelNode()
    public var labelsPoem: [SKLabelNode] = []
    
    
    public var leftTopSprite = SKSpriteNode()
    
    public var startPositions: [CGPoint] = [CGPoint(x: 600.0, y: 30.0), CGPoint(x: -600.0, y: 30.0)]
    
    // MARK: - Bools
    
    var isGluedToLetter = false
    
    // MARK: - Counters
    
    var timesDropped = 0
    var linesShown = 0
    
    // MARK: -
    // MARK: - Functions
    
    public override func didMove(to view: SKView) {
        
        setupFont()
        setupScenary()
        setupMatrix()
        setupBoard()
        setupFinishLabel()
        setupLabelsPoem()
        
        startGame()
        
        self.addSound()
        self.setupImagesSides()
        
    }
    
    
    public func setupImagesSides() {
        
        let indexInformation = poemSelection?.rawValue ?? 0
        
        leftTopSprite.size = CGSize(width: 100.0, height: 100.0)
        leftTopSprite.texture = SKTexture(imageNamed: MatrixInformation.imagesPoem[indexInformation])
        leftTopSprite.position = startPositions[0]
        leftTopSprite.alpha = 0.0
        
        self.addChild(leftTopSprite)
    }
    
    // MARK: - Setup Functions
    
    func setupFont() {
        let fontURL = Bundle.main.url(forResource: "CordelEncarnado", withExtension: "otf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
    }
    
    func setupScenary() {
        // BackgroundSprite and overlay setup
        
        let indexInformation = poemSelection?.rawValue ?? 0
        backgroundSprite.texture = SKTexture(imageNamed: MatrixInformation.backgroundImageName[indexInformation])
        backgroundSprite.size = CGSize(width: 2*640-20, height: 880 + 230)
        backgroundSprite.alpha = 0.4
        
        backgroundSpriteColor = SKSpriteNode(color: MatrixInformation.charColor[indexInformation], size: CGSize(width: 2*640-20, height: 880 + 230))
        backgroundSpriteColor.zPosition = -101
        
        backgroundSprite.zPosition = -100
        backgroundSprite.name = "backgroundSprite"
        self.addChild(backgroundSprite)
        self.addChild(backgroundSpriteColor)
        
    }
    
    func setupMatrix() {
        
        let indexInformation = poemSelection?.rawValue ?? 0
        let poemFind = MatrixInformation.arrayInformation[indexInformation]
        
        wordsToFind = MatrixInformation.arrayWordsToFind[indexInformation]
        
        for array in poemFind {
            matrix.append(array)
        }
        
        
        for _ in 1 ... (numberOfLines*numberOfColums*numberOfPuzzles) {
            
            matrixDidSelected.append(false)
        }
    }
    
    func setupLabelsPoem() {
        
        let indexInformation = poemSelection?.rawValue ?? 0
        
        for i in 0...3 {
            
            let label = SKLabelNode(fontNamed: "CordelEncarnado")
            label.name = "labelPoem\(i)"
            label.text = ""
            label.fontColor = MatrixInformation.textColor[indexInformation]
            label.fontSize = 30
            label.position = CGPoint(x: 0.0, y: Double(280 - 35*i))
            label.alpha = 0.0
            labelsPoem.append(label)
            
            addChild(label)
            
        }
        
    }
    
    func clearPoemText(completion: @escaping (_ success: Bool) -> Void) {
        DispatchQueue.global().async { [weak self] in
            
            guard let `self` = self else {return}
            for label in self.labelsPoem {
                
                
                let disptchGroup = DispatchGroup()
                disptchGroup.enter()
                DispatchQueue.main.async {
                    label.run(.fadeOut(withDuration: 0.3)) {
                        disptchGroup.leave()
                    }
                }
                disptchGroup.wait()
            }
            
            self.linesShown = 0
            completion(true)
        }
    }
    
    public func addSound() {
        
        let indexInfo = poemSelection?.rawValue ?? 0
        
        let backgroundSound = SKAudioNode(fileNamed: MatrixInformation.soundName[indexInfo])
        addChild(backgroundSound)
        
        backgroundSound.run(SKAction.play())
    }
    
    
    /// THIS SHOULD BE CALLED AFTER TIMESDROPPED IS INCREASED
    func presentPoemText() {
        
        animateSpriteSide()
        
        let typeOfPoem = poemSelection?.rawValue ?? 0
        
        if timesDropped >= 3 || linesShown != 0 {
            return
        }
        
        let poem = MatrixInformation.arrayPoems[typeOfPoem][timesDropped]
        
        var times = 0
        
        for line in poem {
            
            labelsPoem[times].text = line
            
            let wait = SKAction.wait(forDuration: TimeInterval(2*times))
            let appear = SKAction.fadeIn(withDuration: 0.6)
            
            labelsPoem[times].run(.sequence([wait, appear])) { [weak self] in
                self?.linesShown += 1
            }
            times += 1
        }
    }
    
    func startGame() {
        
        presentPoemText()
        
        // MAKE PUZZLE APPEAR
        
        let action = SKAction.wait(forDuration: TimeInterval(timeBeforeStarts))
        
        let appear = SKAction.fadeIn(withDuration: 0.6)
        
        tableMatrixSprite.run(.sequence([action, appear]))
        
    }
    
    // MARK: -
    // MARK: - Letters Setup
    
    func animateLetters(node: SKLabelNode) {
        
        let rotate = SKAction.rotate(byAngle: .pi/24, duration: 0.8)
        let rotateBack = SKAction.rotate(byAngle: -.pi/24, duration: 0.8)
        
        let sequence = SKAction.sequence([rotate, rotate.reversed(), rotateBack, rotateBack.reversed()])
        
        node.run(.repeatForever(sequence))
    }
    
    func createLetterNode(letter: String, numColumn: Int, numLine: Int) {
        
        let indexInformation = poemSelection?.rawValue ?? 0
        
        let labelNode = SKLabelNode(fontNamed: "CordelEncarnado")
        labelNode.name = String(numLine) + String(numColumn) + letter
        labelNode.text = letter
        labelNode.fontSize = 30.0
        labelNode.zPosition = 50.0
        
        labelNode.position = CGPoint(x: -135.0 + Double(numColumn)*90.0, y: -35 + Double(numberOfPuzzles*numberOfLines)*70.0/2.0 - Double(numLine)*70)
        labelNode.fontColor = MatrixInformation.charColor[indexInformation]
        labelNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        
        let circle = SKShapeNode(circleOfRadius: 25 ) // Size of Circle
        circle.position = CGPoint(x: 0.0, y: 0.0)
        circle.fillColor = MatrixInformation.circleColor[indexInformation]
        circle.lineWidth = 0.0
        circle.zPosition = -1
        
        labelNode.addChild(circle)
        
        animateLetters(node: labelNode)
        
        tableMatrixSprite.addChild(labelNode)
        tableMatrixSprite.alpha = 0.0
    }
    
    
    func setupBoard() {
        
        cropNodeMatrix = SKCropNode()
        
        cropNodeMatrix.maskNode = SKSpriteNode(color: .red, size: CGSize(width: 640, height: 220))
        cropNodeMatrix.zPosition = 30
        cropNodeMatrix.position = CGPoint(x: 0.0 , y: -205.0 + yPosDelta)
        
        let tableHeight = CGFloat(numberOfPuzzles*numberOfLines)*70.0
        
        let tableWidth = CGFloat(numberOfColums)*85.0
        tableMatrixSprite = SKSpriteNode(color: .clear, size: CGSize(width: tableWidth, height: tableHeight))
        tableMatrixSprite.zPosition = 10
        tableMatrixSprite.position = CGPoint(x: 0.0, y: 205.0 )
        
        cropNodeMatrix.addChild(tableMatrixSprite)
        
        var numLine = 0
        var numColumn = 0
        
        for line in matrix {
            for letter in line {
                
                createLetterNode(letter: letter, numColumn: numColumn, numLine: numLine)
                
                numColumn += 1
            }
            numColumn = 0
            numLine += 1
        }
        
        self.addChild(cropNodeMatrix)
        
    }
    
    func setupFinishLabel() {
        
        let indexInformation = poemSelection?.rawValue ?? 0
        
        finishLabelSprite = SKLabelNode(fontNamed: "CordelEncarnado")
        finishLabelSprite.text = "Great!"
        finishLabelSprite.fontColor = MatrixInformation.textColor[indexInformation]
        finishLabelSprite.fontSize = 80.0
        finishLabelSprite.position = CGPoint(x: 0.0, y: 50.0)
        finishLabelSprite.verticalAlignmentMode = .center
        finishLabelSprite.alpha = 0.0
        finishLabelSprite.zPosition = 50.0
        
        
        let backgroundFinishLabel = SKSpriteNode()
        
        backgroundFinishLabel.texture = SKTexture(imageNamed: MatrixInformation.labelGreat[indexInformation])
        print(MatrixInformation.labelGreat[indexInformation])
        backgroundFinishLabel.size = CGSize(width: finishLabelSprite.frame.width + 100, height: finishLabelSprite.frame.height + 80)
        
        backgroundFinishLabel.zPosition = -1
        
        finishLabelSprite.addChild(backgroundFinishLabel)
        
        self.addChild(finishLabelSprite)
    }
    
    /// Check if node is a Letter Node, if it is, return its index in the matrix and its name
    func checkIfNodeIsLetter(node: SKNode) -> (index: Int,letter: String, name: String, position: CGPoint)? {
        if let name = node.name {
            // GET LINE AND COLUMN OF NODE
            let line = name.first
            let column = name.dropFirst().first
            
            // RETURNS IF IT IS NOT A LETTER NODE
            guard let numLine = Int(String(line ?? Character("a"))),
                let numColumn = Int(String(column ?? Character("a"))) else {
                    return nil
            }
            
            
            if(numLine < (6 - 3*timesDropped) || numLine > (8 - 3*timesDropped)){
                return nil
            }
            
            let index = numberOfColums*numLine + numColumn
            
            let letter = name.dropFirst().dropFirst()
            
            return (index, String(letter), name, node.position)
            
        }
        
        return nil
    }
    
    // MARK - Position Fixes
    
    /// Fixes the position to give a node's position in the table matrix sprite instead of in the superview
    func calculatePositionTouchInSuperView(point: CGPoint) -> CGPoint{
        
        let positionInCropNode = CGPoint(x: point.x, y: point.y - cropNodeMatrix.position.y)
        
        
        let value = CGPoint(x: positionInCropNode.x, y: positionInCropNode.y - tableMatrixSprite.position.y)
        return value
    }
    
    /// Fixes the position to give a node's position in the superview instead of in the table matrix sprite
    func calculatePositionTouchInTableNode(point: CGPoint) -> CGPoint {
        
        // Y(tableMatrixSprite) = Y(tableMatrixSprite) + Y(cropNode) - Y(sceneView)
        // Y(sceneView) = 0
        let positionInCropNode = CGPoint(x: tableMatrixSprite.position.x, y: tableMatrixSprite.position.y + cropNodeMatrix.position.y)
        
        let value = CGPoint(x: point.x, y: point.y + positionInCropNode.y)
        
        return value
    }
    
    
    func addCharacterToWord(index: Int, letter: String, name: String, position: CGPoint) {
        
        // If the character was not selected yet
        if !matrixDidSelected[index] {
            
            // add to the list of selected nodes
            nodesSelected.append(name)
            
            secondTouch = calculatePositionTouchInTableNode(point: position)
            
            
            /// CREATES A LINE FROM THE PREVIOUS CHARACTER TO THIS CHARACTER
            let yourline = SKShapeNode()
            yourline.name = "line"
            yourline.zPosition = -2
            let pathToDraw = CGMutablePath()
            
            if let firstTouch = startTouch {
                pathToDraw.move(to: calculatePositionTouchInSuperView(point: firstTouch))
            }
            
            
            let indexInformation = poemSelection?.rawValue ?? 0
            pathToDraw.addLine(to: position)
            yourline.path = pathToDraw
            yourline.strokeColor = MatrixInformation.lineColor[indexInformation]
            yourline.lineWidth = 20.0
            tableMatrixSprite.addChild(yourline)
            
            let sound = SKAction.playSoundFileNamed("letterSound", waitForCompletion: false)
            tableMatrixSprite.run(sound)
            
            startTouch = secondTouch
            
            // ADDS THE LETTER TO THE WORD CREATED
            wordCreated += letter
            
            matrixDidSelected[index] = true
        }
        
    }
    
    // MARK: -
    // MARK: Game Logic and Animations
    
    func animateSpriteSide() {
        
        leftTopSprite.position = startPositions[0]
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        
        let rotate = SKAction.rotate(byAngle: .pi/2, duration: 2.0)
        
        let finalMove = SKAction.move(to: startPositions[1], duration: 2.0)
        
        let group = SKAction.group([rotate, .sequence([fadeIn, finalMove])])
        leftTopSprite.run(group)
        
    }
    
    func presentFinishLabel() {
        let action = SKAction.fadeAlpha(by: 1.0, duration: 0.3)
        finishLabelSprite.run(action)
        
        let sound = SKAction.playSoundFileNamed("winSound", waitForCompletion: false)
        finishLabelSprite.run(sound)
        
        let rotate = SKAction.rotate(byAngle: .pi/29.0, duration: 1.0)
        
        let rotateBack = SKAction.rotate(byAngle: -.pi/29.0, duration: 1.0)
        
        finishLabelSprite.run(.repeatForever(.sequence([rotate, rotate.reversed(), rotateBack, rotateBack.reversed()])))
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            PlaygroundPage.current.assessmentStatus = .pass(message: " **Great!** When you're ready, go to the [**Next Page**](@next)!")
        }
    }
    
    
    func dropTableMatrix() {
        
        if(timesDropped < 3){
            let actionMove = SKAction.move(by: CGVector(dx:0, dy:-Double(3)*70), duration: 0.5)
            
            tableMatrixSprite.run(actionMove)
            
            // SOUND LOGIC
            
            let indexInformation = poemSelection?.rawValue ?? 0
            
            let nameSound = MatrixInformation.soundsToPlayPoem[indexInformation][timesDropped]
            
            let sound = SKAction.playSoundFileNamed(nameSound, waitForCompletion: false)
            
            tableMatrixSprite.run(sound)
            
            
            timesDropped += 1
            
            // END SOUND LOGIC
            
            // PRESENT POEM TEXT
            clearPoemText { [weak self](_) in
                self?.presentPoemText()
                
                if(self!.timesDropped == 3){
                    self?.presentFinishLabel()
                }
            }
        }
    }
    
    
    
    // MARK: -
    // MARK : - Touch Events
    
    func touchMoved(toPoint pos : CGPoint) {
        
        
        let indexInformation = poemSelection?.rawValue ?? 0
        
        let touchedNodes = self.nodes(at: pos)
        
        secondTouch = pos
        
        if(isGluedToLetter){
            let pathToDraw = CGMutablePath()
            pathToDraw.move(to: startTouch!)
            pathToDraw.addLine(to: secondTouch!)
            line.strokeColor = MatrixInformation.lineColor[indexInformation]
            line.lineWidth = 20.0
            line.path = pathToDraw
        }
        
        if(linesShown == 4){
            for node in touchedNodes{
                
                let nodeLetterInfo = checkIfNodeIsLetter(node: node)
                
                // if the touched node was a letterNode
                if let tuple = nodeLetterInfo {
                    
                    addCharacterToWord(index: tuple.index, letter: tuple.letter, name: tuple.name, position: tuple.position)
                    return
                }
            }
        }
        
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touch")
        
        for t in touches {
            
            let touchedNodes = self.nodes(at: t.location(in: self))
            
            for node in touchedNodes{
                
                let info = checkIfNodeIsLetter(node: node)
                
                if let tuple = info {
                    
                    /// States that the line is glued to a letter
                    isGluedToLetter = true
                    
                    line.name = "mainLine"
                    line.zPosition = 10
                    
                    startTouch = calculatePositionTouchInTableNode(point: tuple.position)
                    secondTouch = calculatePositionTouchInTableNode(point: tuple.position)
                    
                    
                    let indexInformation = poemSelection?.rawValue ?? 0
                    
                    let pathToDraw = CGMutablePath()
                    pathToDraw.move(to: startTouch!)
                    pathToDraw.addLine(to: secondTouch!)
                    line.strokeColor = MatrixInformation.lineColor[indexInformation]
                    line.lineWidth = 20.0
                    line.path = pathToDraw
                    
                    addChild(line)
                    return
                }
            }
        }
    }
    
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        matrixDidSelected = matrixDidSelected.map{_ in false}
        
        secondTouch = nil
        startTouch = nil
        
        tableMatrixSprite.children.filter({ $0.name == "line" }).forEach({ $0.removeFromParent() })
        
        if(wordCreated == wordsToFind[timesDropped]){
            
            var text = labelsPoem[3].text!.dropLast().dropLast().dropLast()
            text.append(contentsOf: wordCreated)
            labelsPoem[3].text = String(text)
            
            dropTableMatrix()
            
            for nodeName in nodesSelected {
                
                tableMatrixSprite.childNode(withName: nodeName)?.removeFromParent()
                nodesSelected.removeAll()
            }
        }
        
        wordCreated = ""
        
        isGluedToLetter = false
        
        line.removeFromParent()
    }
    
    
    @objc public static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
}
