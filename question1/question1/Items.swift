
import Foundation

class Items {
    var name: String
    var quantity: Int
    var price: Double
    var type: ItemTypes
    var finalPrice: Double
    
    init()
    {
        /*
         This constructor is just used to create an object to access computeTax() function
         */
        name = ""
        quantity = 0
        price = 0
        type = ItemTypes.raw
        finalPrice = 0
    }
    init(name: String, quantity: Int, price: Double, type: ItemTypes, finalPrice: Double)
    {
        self.name = name
        self.quantity = quantity
        self.price = price
        self.type = type
        self.finalPrice = (price + Items().computeTax(price: price,type: type)) * (Double(quantity))
    }
    
    func computeTax(price: Double, type: ItemTypes) -> Double
    {
        /*
         Calls the respective function to compute tax for the particular typr
         */
        
        var tax: Double = 0
        switch type{
        case .raw :
            let ritem = RawItem()
            tax = ritem.calculateTax(price: price)
        case .manufactured :
            let mitem = ManufacturedItem()
            tax = mitem.calculateTax(price: price)
        case .imported :
            let iItem = ImportedItem()
            tax = iItem.calculateTax(price: price)
        }
        return tax
    }
}
