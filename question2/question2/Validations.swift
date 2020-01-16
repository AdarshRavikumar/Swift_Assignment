
import Foundation

func validateStringToInt(input: String) -> Bool {
    
    if let _ = Int(input) {
        return true
    }
    else {
        print("Wrong Type for Entered , Only Int is Allowed !!")
        return false
    }
    
}
