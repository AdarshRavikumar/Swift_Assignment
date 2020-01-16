
import Foundation

class Node {
    static var mapId = [Int:Int]()
    static var revMapID = [Int:Int]()
    static var counter = 0
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func getId() -> Int {
        return id
    }
    
    func getName() -> String {
        return name
    }
}
