
import Foundation

func validateAge(age: String) -> Int {
    
    if(Int(age) == nil)
    {
        print("Wrong Age Type Entered , Only Integers Allowed")
        return 1
    }
    return 0
}

func validateRoll(roll: String) -> Int{
    
    if(Int(roll) == nil)
    {
        print("Wrong RollNumber Type Entered , Only Integers Allowed")
        return 1
    }
    return 0
}
