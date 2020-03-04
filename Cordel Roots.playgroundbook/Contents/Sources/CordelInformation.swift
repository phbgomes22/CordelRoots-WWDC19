import Foundation
import SpriteKit


public struct CordelInformation {
    
    public static let arrayInfo = [
        (title: "HOMETOWN", image: "dailyLifeImage", text: "Walking downtown you might find\nPeople reading about you\nMay be gossip, you don't mind\nYou'll love to read it too\n"),
        (title: "FOLKLORE", image: "CordelFolclore", text: "To keep the old tales alive\nAs faithful as they were made\nThey warn the young not to dive\nInto the arms of the daunting mermaid\n")
    ]
    
    public static let poems: [[String]] = [
        ["When we love we want to share", "Feelings always overflow", "How we feel the lack of air", "How we miss them when they go",  "The struggles that we bare", "Just as next Page will show"],
        
        ["To keep the old tales alive", "As faithful as they were made", "They warn the young not to dive", "To the arms of the daunting mermaid", "To know more of how to survive", "The next Page might give you aid"]
    ]
    
    public static let backgroundImage: [String] = ["backgroundPage1", "backgroundPageNight"]
    
    public static let linesImage: [String] = ["linesCordel", "linesCordelNight"]
    
    public static let lampImage: [String] = ["lampCordel", "lampCordelNight"]
    
    public static let sunImage: [String] = ["littleSunCordel", "littleMoonCordel"]
    
    public static let bigSunImage: [String] = ["bigSunCordel", "bigMoonCordel"]
    
    public static let cordelToDrop: [Int] = [4, 6]
    
    public static let cordelImage: [String] = ["cordelPageDay", "cordelPageNight"]
    
    public static let soundName: [String] = ["happySong1", "sadSong1"]
}

public enum TimeOfDay: Int {
    case Morning = 0
    case Night = 1
}
