
import Foundation



class ManufacturedItem:ItemProtocol{
    var tax: Double=0

    func calculateTax(price: Double) -> Double {
        /*
         Calculating Tax as per the type manufactured
         */
        
        let tax1 = 0.125 * price
        let tax2 = 0.2 * (tax1 + price)
        let tax = tax1 + tax2
        return tax
    }
}
