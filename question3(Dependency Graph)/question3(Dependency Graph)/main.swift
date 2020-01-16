
import Foundation



func display(listofNodes: [Int]) {
    
    for node in listofNodes {
        if let keyValue = Node.revMapID[node] {
            print(keyValue, terminator: " ")
        }
    }
    print()
}

func readOneInput() -> Int {
    
    if  let input1 = readLine() {
        let inputToInt = Int(input1)
        if let inputToIntOptional = inputToInt {
            return inputToIntOptional
        }
        else {
            print("Wrong Type Entered . Only Integers Allowed ")
            return -1
        }
    }
    else {
        return -1
    }
    
}


func readTwoInput() -> (input1: Int, input2: Int) {
    
    if let input1 = readLine(), let input2 = readLine() {
        let intInput1 = Int(input1)
        let intInput2 = Int(input2)
        
        if let intInput1Optional = intInput1, let intInput2Optional = intInput2 {
            return (input1: intInput1Optional, input2: intInput2Optional)
        }
        else {
            return (input1: -1, input2: -1)
        }
        
    }
    else {
        return (input1: -1, input2: -1)
    }
    
}




print( " Dependancy Graph Data Structure \n  ")
var graph = DependancyGraph()
outerloop :while(true) {
    
    print(" Select your choice ! ")
    print("0. Exit")
    print("1. Add Node to the graph")
    print("2. Add dependency")
    print("3. Delete a dependency")
    print("4. Delete node")
    print("5. Get descendants")
    print("6. Get ancestors")
    print("7. Get parents (immediate ancestors")
    print("8. Get children (immediate descendants")
    print("9. Display Graph")
    
    
    let choice = readOneInput()
    
    switch choice {
    case 0:
        break outerloop
        
    case 1:
        print("Enter Node Id ")
        let id = readOneInput()
        print("Enter Node Name ")
        var name = ""
        if let nameOptional = readLine() {
            name = nameOptional
        }
        Node.mapId[id] = Node.counter
        Node.revMapID[Node.counter] = id
        Node.counter += 1
        if let value = Node.mapId[id]{
            let node = Node(id: value, name: name)
            graph.addNode(id: value, node: node)
        }
        
        
        
    case 2:
        print("Enter the Two Node Ids one after the other ")
        let input = readTwoInput()
        if let value1 = Node.mapId[input.input1] , let value2 = Node.mapId[input.input2] {
            graph.addDependancy(id1: value1, id2: value2 )
        }
        else {
            print("One or more Nodes Doesn't Exist !")
        }
        
    case 3:
        print("Enter the Two Node Id's one after the other ")
        let input = readTwoInput()
        if let value1 = Node.mapId[input.input1] , let value2 = Node.mapId[input.input2] {
            graph.deleteDependancy(parentId: value1, childId: value2)
        }
    case 4:
        print("Enter The Node to Delete ")
        let input = readOneInput()
        if let value = Node.mapId[input]{
            graph.deleteNode(id: value)
        }
    case 5:
        print("Enter Node ")
        let input = readOneInput()
        if let value = Node.mapId[input]{
            let descendants = graph.getDescendants(id: value)
            print("Descendants of node \(input)")
            display(listofNodes: descendants)
        }
    case 6:
        print("Enter Node ")
        let input = readOneInput()
        if let value = Node.mapId[input]{
            let ancestors = graph.getAncestors(id: value)
            print("Ancestors of node \(input)")
            display(listofNodes: ancestors)
        }
    case 7:
        print("Enter Node ")
        let input = readOneInput()
        if let value = Node.mapId[input]{
            let parents = graph.getParents(id: value)
            print("Parents of node \(input)")
            display(listofNodes: parents)
        }
    case 8:
        print("Enter Node ")
        let input = readOneInput()
        if let value = Node.mapId[input]{
            let children = graph.getChildren(id: value)
            print("Children of node \(input)")
            display(listofNodes: children)
        }
    case 9:
        graph.displayGraph(graph: graph.dependancyGraph)
        
    default:
        print("Enter valid Option")
    }
    
}




