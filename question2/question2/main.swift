

import Foundation

enum CourseType: String{
    case A,B,C,D,E,F
}

class UserDetails {
    // To check if RollNumber Already Exists
    var rollSet = Set<Int>()
    var userObjects: [User] = []
    
    func addUser() {
        var name: String?
        var age: Int?
        var rollNumber: Int?
        var address: String?
        var courses: [CourseType] = []
        var flag = true
        var validator = true
        
        // getting name from User
        print(" Enter Full Name ")
        if let nameOptional = readLine() {
            name = nameOptional
        }
        else{
            print(" Name Not entered ")
            flag = false
        }
        
        // getting Roll Number From User
        
        print(" Enter Roll Number ")
        validator = true
        while (validator == true) {
            if let rollOptional = readLine() {
                
                if(validateStringToInt(input: rollOptional)) {
                    validator = false
                }
                else {
                    continue
                }
                rollNumber = Int(rollOptional)
                if(rollSet.contains(rollNumber!)) {
                    print("Roll number already exists !! This User can't be added ")
                    return
                }
                rollSet.insert(rollNumber!)
            }
            
        }
        
        
        //getting Age From User
        print(" Enter Age ")
        validator = true
        while (validator == true) {
            if let ageOptional = readLine() {
                if(validateStringToInt(input: ageOptional)) {
                    validator = false
                }
                else {
                    continue
                }
                age = Int(ageOptional)
            }
            
        }
        //getting Address From User
        print(" Enter Address ")
        if let addressOptional = readLine() {
            address = addressOptional
        }
        else {
            print(" Address Not Entered ")
            flag = false
        }
        
        //getting Courses from User
        print(" Enter Courses ")
        var choice = "y"
        var count = 0
        while(count < 6) {
            print(" Add a Course or press n to exit ")
            if let courseType = readLine() {
                choice = courseType
                if(choice == "n" && count>=4) {
                    break
                }
                else if (choice == "n" && count < 4) {
                    print(" Atleast 4 courses are required . Add \(4-count) more Courses ")
                    continue
                }
                if  let courseType = CourseType(rawValue: courseType) {
<<<<<<< HEAD
                    if(courses.contains(courseType)) {
                        print("This Course Already Taken By User !")
                    }
                    else {
                        courses.append(courseType)
                        count+=1
                    }
=======
                    courses.append(courseType)
                    count += 1
>>>>>>> 90fa4723f41d7c24ee5dc0f1b6aa83b22e264626
                }
                else {
                    print("The Correct Course to be Specified")
                }
            }
        }
        
        if(flag == true ) {
            if let nameEntered = name, let rollNumberEntered = rollNumber, let ageEntered = age, let addressEntered = address {
                
                let newUser = User(name: nameEntered, rollNumber: rollNumberEntered, age: ageEntered, address: addressEntered, course: courses)
                
                userObjects.append(newUser)
            }
            
        }
        else {
            print("User was not Added !!")
        }
        
        
    }
    
    func displayUser() {
        
        if(userObjects.count == 0) {
            print(" Sorry !! No Users Present ")
        }
        
        userObjects = userObjects.sorted(by: sortNameAscending(u1:u2:))
        printUsers(userObjects)
        
        var categoryOption: Int?
        var sortOption: Int?
        outerloop : while(true) {
            print(" Use the Following Options ")
            print("1. To Sort Based on Names in Descending\n 2. To Sort Based on Age \n 3. To Sort Based on RollNumber\n 4. To Sort Based on Address\n 5. To goto main Menu ")
            if let categoryChoice = readLine() {
                categoryOption = Int(categoryChoice)
                if (categoryOption == 5 ) {
                    break outerloop
                }
            }
            if(categoryOption != 1) {
                print("1. For Ascending\n 2. For Descending")
                if let sortPreference = readLine() {
                    sortOption = Int(sortPreference)
                }
            }
            
            switch categoryOption {
            case 1:
                userObjects = userObjects.sorted(by: sortNameDescending(u1:u2:))
                printUsers(userObjects)
                
            case 2:
                if (sortOption == 1 ) {
                    userObjects = userObjects.sorted(by: sortAgeAscending(u1:u2:))
                }
                else if (sortOption == 2) {
                    userObjects = userObjects.sorted(by: sortAgeDescending(u1:u2:))
                }
                printUsers(userObjects)
            case 3:
                if (sortOption == 1 ) {
                    userObjects = userObjects.sorted(by: sortRollAscending(u1:u2:))
                }
                else if (sortOption == 2) {
                    userObjects = userObjects.sorted(by: sortRollDescending(u1:u2:))
                }
                printUsers(userObjects)
            case 4:
                if (sortOption == 1 ) {
                    userObjects = userObjects.sorted(by: sortAddressAscending(u1:u2:))
                }
                else if (sortOption == 2) {
                    userObjects = userObjects.sorted(by: sortAddressDescending(u1:u2:))
                }
                printUsers(userObjects)
            case 5:
                break outerloop
            default:
                print("Option is Wrong")
            }
            
            
        }
        
    }
    
    func deleteUser() {
        print(" Enter the Roll Number of User to delete ")
        if let rollOptional = readLine() {
            let roll = Int(rollOptional)
            if let rollNumber = roll {
                if(!rollSet.contains(rollNumber))
                {
                    print("Invalid Roll Number !")
                    return
                }
                
                userObjects.removeAll(where: {$0.rollNumber == rollNumber})
                rollSet.remove(rollNumber)
                print("User Removed Successfully !! ")
            }
        }
        
    }
    
    func home() {
        
        print("Welcome to User Management System !!! \n")
        Outerloop : while(true) {
            print("1. Add User \n 2. Display User \n 3. Delete User\n 4. Exit ")
            let input = readLine()
            var userChoice:String=""
            if let inputOptional = input {
                userChoice = inputOptional
            }
            switch userChoice {
            case "1" :
                addUser()
            case "2" :
                displayUser()
            case "3" :
                deleteUser()
            case "4" :
                break Outerloop
            default:
                print("Wrong Choice Entered")
                continue
            }
        }
        
    }
}

var details = UserDetails()
details.home()

