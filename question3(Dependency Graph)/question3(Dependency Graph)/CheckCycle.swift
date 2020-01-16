
import Foundation

class CheckCycle {
    
    func cyclicUtil(graph: inout [[Int]], _ id1: Int, _ id2: Int, ancestors : inout [Bool], visited: inout [Bool] ) ->Bool {
        
        if(ancestors[id1]) {
            return true
        }
        
        if(visited[id1]) {
            return true
        }
        
        visited[id1] = true
        ancestors[id1] = true
        
        for ids in graph[id1] {
            if(cyclicUtil(graph: &graph, ids, id2, ancestors: &ancestors, visited: &visited)) {
                return true
            }
        }
        
        ancestors[id1] = true
        return false
        
        
        
    }
    
    
    func isCyclic(graph: inout [[Int]], id1: Int, id2: Int) -> Bool {
        
        var ancestors = [Bool]()
        var visited = [Bool]()
        
        for _ in 0...(DependancyGraph.count - 1 ) {
            ancestors.append(false)
            visited.append(false)
        }
        
        return cyclicUtil(graph: &graph,id1,id2,ancestors: &ancestors,visited: &visited)
    }
}
