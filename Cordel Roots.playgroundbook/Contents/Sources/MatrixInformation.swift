import Foundation
import UIKit
import SpriteKit

public struct MatrixInformation {
    
    public static let arrayInformation: [[[String]]] = [
        
        [["F", "S", "J", "I"], ["M", "E", "O", "L"] , ["G", "A", "T", "Q"],
         ["T", "F", "E", "X"], ["A", "Q", "A", "R"], ["G", "Y", "N", "D"],
         ["B", "I", "W", "N"], ["G", "T", "E", "X"], ["W", "D", "C", "L"]],
        
        [["Y", "S", "E", "S"], ["W", "W", "E", "D"] , ["G", "Y", "S", "X"],
         ["W", "I", "Q", "N"], ["C", "L", "A", "Y"], ["W", "D", "N", "E"],
         ["W", "O", "W", "C"], ["D", "A", "P", "E"], ["G", "Y", "S", "Z"]],
        ]
    
    public static let arrayWordsToFind: [[String]] = [
        ["BITE", "FEAR", "MEAT", "JUST IN CASE", "JUST IN CASE", "JUST IN CASE"],
        
        ["DAYS", "CLAY", "SEED", "JUST IN CASE", "JUST IN CASE", "JUST IN CASE"],
        
        ]
    
    public static let arrayPoems: [[[String]]] = [
        [["The pale light of a full moon", "Frees a creature of the night", "Better stay down in your room", "For it has a scary ..."],
         ["But silly John went out", "And he saw it very near", "The Wolf, he had no doubt", "And he yelled out of ..."],
         ["Oh, how lucky John felt", "The wolf went out to eat", "But it scented his smell", "And tought it was rotten ..."]],
        
        [["Working hard on stony ground", "Marie tried in many ways", "Blooming flowers all around", "But it had not rained for ..."],
         ["She looked for water in vain", "In a small pond miles away", "But getting there, once again", "All that remained there was ..."],
         ["When she was about to stop", "And thought she would not succed", "From the sky a single drop", "Bloomed a flower from a ..."]]
    ]
    
    public static let imagesPoem: [String] = [
        "littleSunCordel", "imagePage2Day"
    ]
    
    public static let circleColor: [UIColor] = [
        UIColor(red: 243.0/255.0, green: 238/255.0, blue: 222.0/255.0, alpha: 1.0),
        UIColor(red: 32.0/255.0, green: 32.0/255.0, blue: 32.0/255.0, alpha: 1.0)
    ]
    
    public static let charColor: [UIColor] = [
        UIColor(red: 32.0/255.0, green: 32.0/255.0, blue: 32.0/255.0, alpha: 1.0),
        UIColor(red: 243.0/255.0, green: 238/255.0, blue: 222.0/255.0, alpha: 1.0)
    ]
    
    public static let textColor: [UIColor] = [
        UIColor(red: 243.0/255.0, green: 238/255.0, blue: 222.0/255.0, alpha: 1.0),
        UIColor(red: 32.0/255.0, green: 32.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        
    ]
    
    public static let lineColor: [UIColor] = [
        UIColor(red: 253.0/255.0, green: 248/255.0, blue: 232.0/255.0, alpha: 1.0),
        UIColor(red: 62.0/255.0, green: 62.0/255.0, blue: 62.0/255.0, alpha: 1.0)
    ]
    
    public static let backgroundImageName: [String] = [
        "backgroundPageNight", "backgroundPage1"
    ]
    
    public static let labelGreat: [String] = [
        "greatNight", "great"
    ]
    
    
    public static let soundName: [String] = ["sadSong2", "happySong2"]
    
    public static let soundsToPlayPoem: [[String]] = [
        ["howlWolf","manYellSound","relieveManSound"],
        ["workGroundSound","womanSigh","dropWater"]
    ]
}

public enum CordelType: Int {
    case Folklore = 0
    case DailyLife = 1
}
