//
//  Person.swift
//  HWSProject10
//
//  Created by Adam Delaney on 6/3/20.
//  Copyright © 2020 Adam Delaney. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String){
        self.name = name
        self.image = image        
    }
}
