
import Foundation

func validateStringToInt(input: String) -> Int {
    
    if let _ = Int(input) {
        return 0
    }
    else {
        print("Wrong Type for Entered , Only Int is Allowed !!")
        return 1
    }
    
}
