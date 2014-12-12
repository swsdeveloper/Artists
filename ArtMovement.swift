//
//  ArtMovement.swift
//  artists3
//
//  Created by Steven Shatz on 8/12/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

import Foundation
import UIKit

/*
A custom class "ArtMovement" with:

1. Properties:
- ArtMovementID -- a number
- name -- a string
- artists array -- a group of Artist objects known for this art style
- image - a string (showing ArtMovement logo)

2. Methods:
- init -- does nothing apart from creating an empty ArtMovement object

3. Inheritance:
- only whatever Swift defaults to like NSObject
*/


class ArtMovement {
    var id:Int?
    var name:String?    //for internal references
    var title:String?   //to be displayed
    var artists = [Artist]()
    var image:String?
    var color:UIColor?  //background color
    
    init(id:Int, name:String, title:String, color:UIColor) {
        self.id = id
        self.name = name
        self.title = title
        self.color = color
    }
}