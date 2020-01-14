
import Foundation

class User {
    var name: String?
    var rollNumber: Int?
    var age: Int?
    var address: String?
    var course: [CourseType]
    
    init(name: String, rollNumber: Int, age: Int, address: String, course: [CourseType]) {
        self.name = name
        self.rollNumber = rollNumber
        self.age = age
        self.address = address
        self.course = course
    }
    
    
}
