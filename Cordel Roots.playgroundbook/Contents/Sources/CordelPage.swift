import PlaygroundSupport
import SpriteKit

public class CordelPage {
    
    // MARK: - Sprite Nodes
    public var sprite: SKSpriteNode = SKSpriteNode()
    public var cordelPage = SKSpriteNode()
    public var centerImage = SKSpriteNode()
    public var versesLabel = SKLabelNode()
    public var backgroundSprite = SKSpriteNode()
    
    var cordelYPos: CGFloat = 30.0
    
    public init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        // setup Font
        self.setupFont()
        self.sprite.zPosition = 200
        // Setup Cordel Background
        self.setupCordelPage()
        // setup cordel page elements
        self.setupCordelPageElements()
        self.sprite.name = SpriteNames.cordelPageSprite.rawValue
    }
    
    public convenience init(color: UIColor = .clear, size: CGSize) {
        self.init(texture: nil, color: color, size: size)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFont() {
        
        let fontURL = Bundle.main.url(forResource: "CordelEncarnado", withExtension: "otf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
        
    }
    
    func setupButtonDismiss(position: CGPoint) {
        let dismissButton = SKLabelNode(fontNamed: "CordelEncarnado")
        dismissButton.name = SpriteNames.cordelPageDismissButton.rawValue
        dismissButton.text = "X"
        dismissButton.fontSize = 26.0
        dismissButton.fontColor = .black
        dismissButton.position = position
        dismissButton.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        dismissButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        
        let circle = SKShapeNode(circleOfRadius: 20.0 ) // Size of Circle
        circle.position = CGPoint(x: 0.0, y: 0.0)
        circle.fillColor = .lightGray
        circle.lineWidth = 0.0
        circle.zPosition = -1
        circle.name = "background" + (dismissButton.name ?? "")
        
        dismissButton.addChild(circle)
        
        sprite.addChild(dismissButton)
    }
    
    func setupCordelPage() {
        
        let backgroundSprite = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.3), size: CGSize(width: 2*640-20, height: 880 + 230))
        
        backgroundSprite.zPosition = 0
        
        sprite.addChild(backgroundSprite)
        
        
        let cordelPage = SKSpriteNode(color: .clear, size: CGSize(width: 300, height: 400))
        cordelPage.position = CGPoint(x: 0.0, y: cordelYPos)
        cordelPage.name = SpriteNames.cordelPageBackground.rawValue
        cordelPage.zPosition = 3
        
        sprite.addChild(cordelPage)
        
        
    }
    
    func setupCordelPageElements() {
        
        // Center Image
        
        centerImage = SKSpriteNode(color: .clear, size: CGSize(width: 260.0, height: 300.0))
        centerImage.zPosition = 4
        centerImage.position = CGPoint(x: 0.0, y: cordelYPos - 30)
        centerImage.name = SpriteNames.centerImage.rawValue
        sprite.addChild(centerImage)
        
        let fontURL = Bundle.main.url(forResource: "CordelEncarnado", withExtension: "otf")
        if let font = fontURL {
            CTFontManagerRegisterFontsForURL(font as CFURL, CTFontManagerScope.process, nil)
        }
        
        // Verses Label
        
        versesLabel = SKLabelNode(fontNamed: "CordelEncarnado")
        
        versesLabel.text = "To keep the old tales alive\nAs faithful as they were made\nThey warn the young not to dive\nInto the arms of the daunting mermaid\n"
        versesLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        versesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        versesLabel.numberOfLines = 0
        versesLabel.fontSize = 18.0
        versesLabel.zPosition = 4
        versesLabel.fontColor = .black
        
        versesLabel.position = CGPoint(x: 0.0, y: cordelYPos - 300)
        
        sprite.addChild(versesLabel)
        
        // dismiss button
        
        //for when the screen is divided
        setupButtonDismiss(position: CGPoint(x: -200, y: 310))
        
        
        //for when is fullscreen
        setupButtonDismiss(position: CGPoint(x: -400, y: 250))
        
        
    }
    
    public func dismiss() {
        self.sprite.removeAllActions()
        self.sprite.removeFromParent()
    }
    
    public func setupCordelPageData(title: String, image: String, verses: String) {
        self.versesLabel.text = verses
    }
    
}
