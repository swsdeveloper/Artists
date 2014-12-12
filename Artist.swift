//
//  Artist.swift
//  artists3
//
//  Created by Steven Shatz on 8/12/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

import Foundation

/*
A custom class "Artist" with:

    1. Properties:
        - id -- a number
        - name -- a string
        - url - a string (pointing to a web page for the Artist)
        - artStyleID - a number (referencing the related Company object

    2. Methods:
        - init -- creates an Artist object and
            - sets its id (to the id passed by the caller)
            - sets its name (to the name passed by the caller)
            - sets its url to a Google "I feel lucky" search for the name (with "+" replacing spaces)

    3. Inheritance:
        - only whatever Swift defaults to like NSObject
*/


class Artist {
    var id: Int
    var name: String?
    var url: String?
    var movementId: Int?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        
        //remove spaces from name to make it url friendly
        var nameWithoutSpaces = ""
        for character in name{
            if character != " " {
                nameWithoutSpaces = nameWithoutSpaces + [character]
            } else {
                nameWithoutSpaces = nameWithoutSpaces + "+"
            }
        }
        
        //self.url = "http://www.google.com/search?q=artist+wikipedia+\(nameWithoutSpaces)&btnI" //&btnI = "I feel lucky" Google search, which returns the first hit
        
        self.url = "http://www.google.com/search?q=site:www.wikiart.org+\(nameWithoutSpaces)&btnI" //&btnI = "I feel lucky" Google search, which returns the first hit

    }
}