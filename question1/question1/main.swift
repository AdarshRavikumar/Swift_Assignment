
import Foundation

protocol ItemProtocol {
    func calculateTax(price: Double) -> Double
}

enum ItemTypes: String {
    case raw = "raw"
    case manufactured = "manufactured"
    case imported = "imported"
    
}


class Home{

    var name: String?
    var quantity: Int?
    var type: ItemTypes?
    var price: Double?

/*
     To store the objects (I mean when user enter product details , each product is an object and stored in this
*/
 var itemObjects: [Items] = []
    
    func parseInputFromUser(input: String) -> Int {
        /*
         This function parses the user input string and creates an object and stores that object in array.
         Dictionary is used to initially store the parsed inputString
         */
        
        var dictionaryforInput = [String:String]()
        let inputStringWithSpaces = input.trimmingCharacters(in: .whitespacesAndNewlines)
        let inputString: [String] = inputStringWithSpaces.components(separatedBy: " ")
        
        for counter in stride (from: 0, through: inputString.count-1, by: 2) {
            if (counter >= inputString.count) {
                break
            }
            
            dictionaryforInput[inputString[counter]] = inputString[counter+1]
        }
        
        var flag: Int = 0
        if (dictionaryforInput.keys.contains("-name")) {
            name = dictionaryforInput["-name"]
        }
        else {
            print("Name is not specified\n")
            flag = 1
        }
        
        if (dictionaryforInput.keys.contains("-type")) && ( dictionaryforInput["-type"] ==  ItemTypes.raw.rawValue || dictionaryforInput["-type"] == ItemTypes.manufactured.rawValue || dictionaryforInput["-type"] == ItemTypes.imported.rawValue) {
            
            if let typeItem = dictionaryforInput["-type"]{
            type = ItemTypes(rawValue: typeItem)
            }
        }
        else {
           print("Type is not specified.Available Types are raw, manufactured, imported\n")
           flag=1
        }
               
        if(dictionaryforInput.keys.contains("-quantity")) {
            quantity = Int(dictionaryforInput["-quantity"]!)
        }
        else {
           quantity = 1
        }
               
        if(dictionaryforInput.keys.contains("-price")) {
            price = Double(dictionaryforInput["-price"]!)
        }
        else {
           price = 0
        }
      
        if(flag == 0) {
            if let nameopt = name , let quantopt = quantity , let priceopt = price, let typeopt = type {
                let newItem = Items(name: nameopt, quantity: quantopt, price: priceopt, type: typeopt, finalPrice: 0)
                itemObjects.append(newItem)
            }
        }
        else {
            print("Enter all Fields Correctly\n")
        }
        
        return flag
        }
        
    
    
    func utils() {
    
       /*
         This function prompts for user input and the main function for this program
         */
        
        var choice = "y"
        //var count:Int = 0
        while(choice == "y" || choice == "Y") {
            print("""
                  Enter in the following format
                  -name itemName -type itemType -price itemPrice -quantity itemQuantity
                   (These parameters can be typed any order and are Space Seperated)
                  """)
            
            
            
                
            let inputString: String? = readLine()
            var res: Int = 1
            if let inputStringOptional = inputString {
                 res = parseInputFromUser(input: inputStringOptional)
            }
            /*
             res =1 , only when the input string entered by user has something missing
             */
            if(res == 1) {
                continue
            }
           
            
            print("Do you want to continue ? if yes, Press y or Y,else Press any key to exit")
            choice = readLine()!
            
        }
            
        print("                                     Inventory                                        ")
        print("\n")
        print(" NAME ", "\t\t", " PRICE ", "\t\t", "Quantity", "\t\t  ", "TYPE", "\t\t  ", "TOTAL PRICE")
        print("................................................................................................")
        
        for object in itemObjects {
           
            print(object.name, "\t\t", object.price, "\t\t\t", object.quantity, "\t\t\t\t", object.type, "\t\t\t", object.finalPrice)
            
            print("................................................................................................")

        }
    }
    

}


let homeObject = Home()
homeObject.utils()



