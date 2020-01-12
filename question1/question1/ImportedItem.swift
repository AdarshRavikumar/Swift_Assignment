
import Foundation


class ImportedItem: ItemProtocol{
    var tax: Double=0
    func calculateTax(price: Double) -> Double {
        /*
         Calculating Tax as per type imported
         */
        
        tax = 0.1 * price
        switch price+tax {
        case ..<100 :
            tax = tax + 5
        case 100..<200:
            tax = tax + 10
        default:
            tax = 0.5 * (tax + price)
        }
        return tax
    }
}
