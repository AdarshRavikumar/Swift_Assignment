
import Foundation

class DFS {
    
    func DFSUtil(_ startingNode: Int, graph: inout [[Int]], resultOfDFS: inout [Int],  visited: inout [Bool]) {
        
        visited[startingNode] = true
        resultOfDFS.append(startingNode)
        
        for nodes in graph[startingNode] {
            if !visited[nodes] {
                DFSUtil(nodes, graph: &graph, resultOfDFS: &resultOfDFS, visited: &visited)
            }
        }
        
    }
    
    
    func DFS (startingNode: Int, graph: inout [[Int]]) -> [Int] {
        var visited = [Bool]()
        for _ in 0...(DependancyGraph.count - 1) {
            visited.append(false)
        }
        var resultOfDFS = [Int]()
        DFSUtil(startingNode,graph: &graph,resultOfDFS: &resultOfDFS,visited: &visited)
        resultOfDFS.remove(at: 0)
        return resultOfDFS
        
    }
}
