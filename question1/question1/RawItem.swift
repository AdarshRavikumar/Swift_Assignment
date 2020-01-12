
import Foundation



class RawItem:ItemProtocol{
    var tax:Double = 0
    func calculateTax(price: Double) -> Double{

        /*
         Calculating Tax as per the type Raw
         */
        let tax = 0.125 * price
        return tax
    }
}
