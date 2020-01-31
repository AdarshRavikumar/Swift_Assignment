

import Foundation

class Person {
    var name: String
    var phone: [[String : String]]
    var company: String
    var email: [[String : String]]
    var image: String?
    var birthDay: String?
    
    init(name: String, phone: [[String : String]], company: String, email: [[String : String]])
    {
        self.name = name
        self.phone = phone
        self.company = company
        self.email = email
       
    }
}
