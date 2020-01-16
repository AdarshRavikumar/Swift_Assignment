

import Foundation

protocol Operations {
    func addNode(id: Int, node: Node)
    func getParents(id: Int) -> [Int]
    func getChildren(id: Int) -> [Int]
    func getAncestors(id: Int) -> [Int]
    func getDescendants(id: Int) -> [Int]
    func addDependancy(id1: Int, id2: Int)
    func deleteNode(id: Int)
    func deleteDependancy(parentId: Int, childId: Int)
}
