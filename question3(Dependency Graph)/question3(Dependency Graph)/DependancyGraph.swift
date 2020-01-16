

import Foundation

class DependancyGraph : Operations {
    static var count = 0
    static var incrementSize = 1
    let capacity = 100
    var dependancyGraph: [[Int]] = [[]]
    var nodesOfGraph: [Int : Node] = [:]
    var hasCycle: Bool = false
    var reverseDependancyGraph: [[Int]] = [[]]
    
    init() {
        for _ in 0...(capacity-1) {
            dependancyGraph.append([])
            reverseDependancyGraph.append([])
        }
    }
    
    func displayGraph(graph: [[Int]]) {
        var flag = false
        for node in 0...(dependancyGraph.count-1) {
            if(graph[node].count > 0) {
                flag = true
                print("\(Node.revMapID[node]!) -------> ", terminator: " ")
                for adjacentNodes in 0...(graph[node].count-1) {
                    print(Node.revMapID[graph[node][adjacentNodes]]! ,terminator: " ")
                }
                print("\n")
            }
        }
        if(flag == false) {
            print("The Graph is Empty")
        }
    }
    
    func addNode(id: Int, node: Node) {
        DependancyGraph.count += 1
        if (DependancyGraph.count == (100*DependancyGraph.incrementSize-1) )
        {
            //print(" Extending Array Size ")
            for _ in 0...10 {
                dependancyGraph.append([])
                reverseDependancyGraph.append([])
            }
            DependancyGraph.incrementSize += 1
        }
        if nodesOfGraph[id] == nil {
            nodesOfGraph[id] = node
        }
        else {
            print("Node Already exists ")
        }
        
    }
    
    func getParents(id: Int) -> [Int] {
        return reverseDependancyGraph[id]
    }
    
    func getChildren(id: Int) -> [Int] {
        return dependancyGraph[id]
    }
    
    func getAncestors(id: Int) -> [Int] {
        let dfs = DFS()
        return dfs.DFS(startingNode: id, graph: &reverseDependancyGraph)
    }
    
    func getDescendants(id: Int) -> [Int] {
        let dfs = DFS()
        return dfs.DFS(startingNode: id, graph: &dependancyGraph)
    }
    
    func addDependancy(id1: Int, id2: Int) {
        print("here in dependancy ")
        if ( nodesOfGraph[id1] == nil || nodesOfGraph[id2] == nil) {
            print("one or more entered Node doesn't exist ")
        }
        else {
            if ( dependancyGraph[id1].contains(id2)) {
                print("The Dependancy Already exits")
            }
            else {
                dependancyGraph[id1].append(id2)
                reverseDependancyGraph[id2].append(id1)
                let cycle = CheckCycle()
                if(cycle.isCyclic(graph: &dependancyGraph, id1: id1, id2: id2)) {
                    print("This Edge cant be added, It would create a cycle ")
                    deleteDependancy(parentId: id1, childId: id2)
                }
            }
        }
        
    }
    
    func deleteNode(id: Int) {
        
        dependancyGraph[id] = []
        reverseDependancyGraph[id] = []
        nodesOfGraph[id] = nil
        
        for ids in 0...(dependancyGraph.count-1) {
            if ( dependancyGraph[ids].contains(id) ) {
                dependancyGraph[ids].removeAll(where: {$0 == id} )
            }
            if ( reverseDependancyGraph[ids].contains(id) ) {
                reverseDependancyGraph[ids].removeAll(where: {$0 == id})
            }
            
        }
        
    }
    
    func deleteDependancy(parentId: Int, childId: Int) {
        
        dependancyGraph[parentId].removeAll (where: {$0 == childId} )
        reverseDependancyGraph[childId].removeAll(where: {$0 == parentId })
    }
    
}
