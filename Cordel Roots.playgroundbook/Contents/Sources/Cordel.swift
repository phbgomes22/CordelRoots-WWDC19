import Foundation
import SpriteKit

public class Cordel {
    public var sprite: SKSpriteNode = SKSpriteNode()
    
    static var numberOfCordels = 0
    var numberInLine = 0
    public var initRotation: CGFloat = 0
    var orientation: Orientation
    
    // MARK: - Initializer
    
    public init(time: Int, orientation: Orientation, yPosition: Double = 0.0, timeOfDay: TimeOfDay){
        self.sprite = SKSpriteNode(color: .darkGray, size: CGSize(width: 30.0, height: 43.9))
        self.sprite.name = "cordel\(Cordel.numberOfCordels)"
        self.orientation = orientation
        
        Cordel.numberOfCordels += 1
        switch orientation{
        case .Upwards:
            setupUpwardsCordel(time: time, yPosition: yPosition)
            break
        case .Downwards:
            setupDownwardCordel(time: time)
        }
        
        
        self.sprite.texture = SKTexture(imageNamed: CordelInformation.cordelImage[timeOfDay.rawValue])
        
    }
    
    private func setupUpwardsCordel(time: Int, yPosition: Double) {
        self.sprite.zPosition = 10
        self.sprite.color = .gray
        let positionY = getYPosExp(time: time, yPos: yPosition)
        self.sprite.position = CGPoint(x: -300.0 + 100.0*Double(time), y: positionY)
        
        let rotation = -CGFloat.pi/2.5 + CGFloat(time)*CGFloat.pi/16
        
        self.sprite.zRotation = rotation
        self.initRotation = rotation
    }
    
    
    private func setupDownwardCordel(time: Int) {
        let yPos = getYPosLog(time: time)
        
        self.sprite.position = CGPoint(x: -300.0 + 100.0*Double(time), y: yPos)
        self.sprite.zPosition = 12
        
        var rotation = CGFloat(time)*CGFloat.pi/30
        
        if rotation > 0 {
            rotation = 0
        }
        
        self.sprite.zRotation = rotation
        self.initRotation = rotation
    }
    
    // MARK: - Position
    
    public func getYPosLog(time: Int) -> Double {
        self.numberInLine = time
        let value = 110 + -40*log(Double(time)) + 12*4/Double(time)
        
        return value
    }
    
    public func getYPosExp(time: Int, yPos: Double) -> Double {
        
        return yPos + 20*pow(1.4, Double(time)) + 12*4/Double(time)
    }
    
    // MARK: - Animations
    
    public func startWind() {
        
        self.sprite.zRotation = initRotation
        
        let animationWind = SKAction.rotate(byAngle: .pi/10, duration: 0.8)
        
        animationWind.timingMode = SKActionTimingMode.easeInEaseOut
        
        let animationLittleWind = SKAction.rotate(byAngle: .pi/30, duration: 0.4)
        animationLittleWind.timingMode = SKActionTimingMode.easeInEaseOut
        
        let animationWindBack = animationWind.reversed()
        
        animationWindBack.timingMode = SKActionTimingMode.easeInEaseOut
        
        let sequence = SKAction.sequence(
            [animationWind,
             animationLittleWind,
             animationLittleWind.reversed(),
             animationLittleWind,
             animationLittleWind.reversed(),
             animationLittleWind,
             animationLittleWind.reversed(),
             animationWindBack])
        
        self.sprite.run(SKAction.repeatForever(sequence))
        
    }
    
    
    public func dropCordel(timesDropped: Int, completion: @escaping (_ success: Bool) -> Void) {
        
        self.sprite.removeAllActions()
        self.sprite.zPosition = 14
        
        switch orientation {
        case .Downwards:
            dropCordelDownwards(timesDropped: timesDropped) { (bool) in
                completion(bool)
            }
        case .Upwards:
            dropCordelUpwards(timesDropped: timesDropped) { (bool) in
                completion(bool)
            }
        }
    }
    
    
    
    private func dropCordelDownwards(timesDropped: Int, completion: @escaping (Bool) -> Void) {
        
        // == ==== ==
        // FIRST HALF
        // == ==== ==
        
        
        let firstMove = SKAction.move(to: CGPoint(x: 150, y: 0), duration: 1.6)
        
        firstMove.timingMode = .easeInEaseOut
        
        let rotateFirst = SKAction.rotate(toAngle: .pi/2 + .pi/10, duration: 1.6)
        rotateFirst.timingMode = .easeInEaseOut
        
        let firstGroup = SKAction.group([firstMove, rotateFirst])
        
        // == ==== ==
        // SECOND HALF
        // == ==== ==
        
        let secondMove = SKAction.move(to: CGPoint(x: -150, y: -100), duration: 1.6)
        secondMove.timingMode = .easeInEaseOut
        
        let rotateSecond = SKAction.rotate(toAngle: .pi/2 - .pi/10, duration: 1.6)
        rotateSecond.timingMode = .easeInEaseOut
        
        let secondGroup = SKAction.group([secondMove, rotateSecond])
        
        
        // == ==== ==
        // THIRD HALF
        // == ==== ==
        
        let thirdMove = SKAction.move(to: CGPoint(x: 0, y: -150 + timesDropped*7), duration: 0.7)
        thirdMove.timingMode = SKActionTimingMode.easeInEaseOut
        
        let rotateThird = SKAction.rotate(toAngle: .pi/2, duration: 0.7)
        rotateThird.timingMode = SKActionTimingMode.easeInEaseOut
        
        let thirdGroup = SKAction.group([thirdMove, rotateThird])
        
        // == ===== ==
        //   GROUPS
        // == === ====
        
        let sequenceMove = SKAction.sequence([ firstGroup, secondGroup, thirdGroup])
        
        let scale = SKAction.scale(by: 1.6, duration: 3.9)
        
        let groupToMakeItBigger = SKAction.group([scale, sequenceMove])
        
        self.sprite.run(groupToMakeItBigger) { [weak self] in
            self?.animatePulse()
            completion(true)
        }
    }
    
    private func dropCordelUpwards(timesDropped: Int, completion: @escaping (Bool) -> Void) {
        // == ==== ==
        // FIRST HALF
        // == ==== ==
        
        let firstMove = SKAction.move(to: CGPoint(x: -150, y: 60), duration: 1.6)
        
        firstMove.timingMode = .easeInEaseOut
        
        let rotateFirst = SKAction.rotate(toAngle: -.pi/2 - .pi/10, duration: 1.6)
        rotateFirst.timingMode = .easeInEaseOut
        
        let firstGroup = SKAction.group([firstMove, rotateFirst])
        
        // == ==== ==
        // SECOND HALF
        // == ==== ==
        
        let secondMove = SKAction.move(to: CGPoint(x: 150, y: -100), duration: 1.6)
        secondMove.timingMode = .easeInEaseOut
        
        let rotateSecond = SKAction.rotate(toAngle: -.pi/2 + .pi/10, duration: 1.6)
        rotateSecond.timingMode = .easeInEaseOut
        
        let secondGroup = SKAction.group([secondMove, rotateSecond])
        
        
        // == ==== ==
        // THIRD HALF
        // == ==== ==
        
        let thirdMove = SKAction.move(to: CGPoint(x: 0, y: -150 + timesDropped*7), duration: 0.7)
        thirdMove.timingMode = SKActionTimingMode.easeInEaseOut
        
        let rotateThird = SKAction.rotate(toAngle: -.pi/2, duration: 0.7)
        rotateThird.timingMode = SKActionTimingMode.easeInEaseOut
        
        let thirdGroup = SKAction.group([thirdMove, rotateThird])
        
        // == ===== ==
        //   GROUPS
        // == === ====
        
        let sequenceMove = SKAction.sequence([ firstGroup, secondGroup, thirdGroup])
        
        let scale = SKAction.scale(by: 1.6, duration: 3.9)
        
        let groupToMakeItBigger = SKAction.group([scale, sequenceMove])
        
        self.sprite.run(groupToMakeItBigger) {  [weak self] in
            self?.animatePulse()
            completion(true)
        }
    }
    
    public func animatePulse() {
        
        let makeItBigger = SKAction.scale(by: 1.05, duration: 0.7)
        
        let moveItUp = SKAction.move(by: CGVector(dx: 0.0, dy: 10.0), duration: 0.7)
        
        let sequenceBig = SKAction.sequence([makeItBigger, makeItBigger.reversed()])
        
        let sequenceMove = SKAction.sequence([moveItUp, moveItUp.reversed()])
        
        let group = SKAction.group([sequenceBig, sequenceMove])
        
        self.sprite.run(.repeatForever(group))
        
    }
    
    public enum Orientation {
        case Upwards
        case Downwards
    }
}
