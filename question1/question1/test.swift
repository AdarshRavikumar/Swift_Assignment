//
//  test.swift
//  question1
//
//  Created by Adarsh R on 13/01/20.
//  Copyright © 2020 Adarsh R. All rights reserved.
//

import Foundation

func someFunctionWithEscapingClosure(completionHandler: @escaping (Int) -> Void) {//2
    
    //Delay
    //API call
    completionHandler(10)//3
}
var x = 0
func doSomethign() {
    someFunctionWithEscapingClosure { (param) in [weak self]//1
        self.x = param//4
        
    }
}
