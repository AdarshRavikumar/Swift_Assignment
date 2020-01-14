
import Foundation

func sortNameDescending(u1: User, u2: User) -> Bool {
    if let name1 = u1.name, let name2 = u2.name {
        if(name1 == name2)
        {
            if let roll1 = u1.rollNumber, let roll2 = u2.rollNumber {
                return roll1 < roll2
            }
        }
        return name1 > name2
    }
    return false
}

func sortNameAscending(u1: User, u2: User) -> Bool {
    if let name1 = u1.name, let name2 = u2.name {
        if(name1 == name2)
        {
            if let roll1 = u1.rollNumber, let roll2 = u2.rollNumber {
                return roll1 < roll2
            }
        }
        return name1 < name2
    }
    return false
}

func sortAgeDescending(u1: User, u2: User) -> Bool {
    if let age1 = u1.age, let age2 = u2.age {
        return age1 > age2
    }
    return false
}

func sortAgeAscending(u1: User, u2: User) -> Bool {
    if let age1 = u1.age, let age2 = u2.age {
        return age1 < age2
    }
    return false
}

func sortRollDescending(u1: User, u2: User) -> Bool {
    if let roll1 = u1.rollNumber, let roll2 = u2.rollNumber {
        return roll1 > roll2
    }
    return false
}

func sortRollAscending(u1: User, u2: User) -> Bool {
    if let roll1 = u1.rollNumber, let roll2 = u2.rollNumber {
        return roll1 < roll2
    }
    return false
}

func sortAddressDescending(u1: User, u2: User) -> Bool {
    if let address1 = u1.address, let address2 = u2.address {
        return address1 > address2
    }
    return false
}

func sortAddressAscending(u1: User, u2: User) -> Bool {
    if let address1 = u1.address, let address2 = u2.address {
        return address1 < address2
    }
    return false
}



func printUsers(_ userObject: [User])  {
    
    print("--------------------------------------------------------------------------------------------------")
    
    print("Name \t  Roll   Number \t  Age \t  Address  \t  Courses")
    print("--------------------------------------------------------------------------------------------------")
    
    
    for user in userObject {
        if let name = user.name , let roll = user.rollNumber, let age = user.age , let address = user.address {
            print("\(name)   \(roll)   \(age)   \(address)   ",terminator: " ")
            print("( ", terminator: " ")
            for courses in user.course {
                print(courses, terminator: " ")
            }
            print(" )", terminator: " ")
            print("---------------------------------------------------------------------------------------------------------------------------------")
            
        }
    }
    
}
