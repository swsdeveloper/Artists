//
//  DataInit.swift
//  artists3
//
//  Created by Steven Shatz on 8/12/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

import Foundation
import UIKit

/*
    A custom class "DataInit" which is used to create ArtMovement and Artist objects:

    1. Properties:
        - artMovements -- an array of ArtMovement objects
        - artists -- an array of Artist objects

    2. Methods:
        - init -- creates a DataInit object, then calls createDefaultartMovementsandArtists and addArtistsToartMovements

        - getartMovements -- returns the DataInit artMovements array
        - getArtists -- returns the DataInit artists array

        - deleteArtist:Artist -- deletes specified Artist from ArtMovement object's artists array and from DataInit object's artists array

        - createDefaultartMovementsandArtists -- creates DataInit artMovements and artists arrays (from hardcoded data)

        - addArtistsToartMovements -- appends each Artist to the appropriate ArtMovement object's artists array

        - newArtistId -- assigns next Artist id, bumping by 1 each time its called

    3. Inheritance:
        - only whatever Swift defaults to like NSObject
*/


class DataInit {
    private var artmovements = Array<ArtMovement>()
    private var artists = Array<Artist>()
    
    init() {
        self.createDefaultartMovementsandArtists()
        self.addArtistsToArtMovements()
    }
    
    func getartMovements() -> [ArtMovement] {
        return self.artmovements
    }
    
    func getArtists() -> [Artist] {
        return self.artists
    }
    
    func deleteArtist(artist: Artist) {
        for movement in self.artmovements {                         //cycle thru all DataInit artmovements
            if (movement.id == artist.movementId) {                 //if we find an ArtMovement that matches Artist's movementId...
                for (var i = 0; i < movement.artists.count; i++) {  //...cycle thru all artists in that ArtMovement's artists array
                    if movement.artists[i].id == artist.id {        //if we find the specified Artist in that array...
                        movement.artists.removeAtIndex(i)           //...delete it from that array
                    }
                }
            }
        }
        
        for (var i = 0; i < self.artists.count; i++) {             //cycle thru all DataInit artists
            if self.artists[i].id == artist.id {                   //if we find an Artist in DataInit artists array that matches Artist's id...
                self.artists.removeAtIndex(i)                      //...delete it from that array
            }
        }
    }
    

    enum artMovement: Int {
        case impressionism = 1,
             postimpressionism,
             naive,
             symbolism,
             modern,
             nouveau,
             expressionism,
             surrealism,
             abstract,
             popart
    }
    
    
    let red = UIColor.redColor()
    let orange = UIColor.orangeColor()
    let yellow = UIColor.yellowColor()  //too light for text - use mustard instead
    let green = UIColor.greenColor()    //too light for text - use deepGreen instead
    let blue = UIColor.blueColor()
    let cyan = UIColor.cyanColor()      //too light for text - use periwinkle instead
    let magenta = UIColor.magentaColor()
    let purple = UIColor.purpleColor()  //too dark for background - use violet instead
    
    let periwinkle = UIColor(red:103/255.0, green:141/255.0, blue:1.0, alpha: 1.0)
    let deepGreen = UIColor(red:72/255.0, green:185/255.0, blue:83/255.0, alpha: 1.0)
    let mustard = UIColor(red:1.0, green:186/255.0, blue:2/255.0, alpha: 1.0)
    let violet = UIColor(red:187/255.0, green:68/255.0, blue:1.0, alpha: 1.0)
    let brown = UIColor(red:185/255.0, green:114/255.0, blue:52/255.0, alpha: 1.0)
    let olive = UIColor(red:126/255.0, green:130/255.0, blue:39/255.0, alpha: 1.0)
    let turquoise = UIColor(red:37/255.0, green:162/255.0, blue:174/255.0, alpha: 1.0)


    func createDefaultartMovementsandArtists() {
        
        var impressionism:ArtMovement = ArtMovement(id: artMovement.impressionism.rawValue, name: "impressionism", title: "Impressionist", color: red )
        var postimpressionism:ArtMovement = ArtMovement(id: artMovement.postimpressionism.rawValue, name: "postimpressionism", title: "Postimpressionist", color: orange )
        var naive:ArtMovement = ArtMovement(id: artMovement.naive.rawValue, name: "naive", title: "Naive", color: mustard )
        var symbolism:ArtMovement = ArtMovement(id: artMovement.symbolism.rawValue, name: "symbolism", title: "Symbolism", color: brown )
        var modern:ArtMovement = ArtMovement(id: artMovement.modern.rawValue, name: "modern", title: "Modern", color: olive )
        var nouveau:ArtMovement = ArtMovement(id: artMovement.nouveau.rawValue, name: "nouveau", title: "Art Nouveau", color: deepGreen )
        var expressionism:ArtMovement = ArtMovement(id: artMovement.expressionism.rawValue, name: "expressionism", title: "Expressionist", color: turquoise )
        var surrealism:ArtMovement = ArtMovement(id: artMovement.surrealism.rawValue, name: "surrealism", title: "Surrealist", color: periwinkle )
        var abstract:ArtMovement = ArtMovement(id: artMovement.abstract.rawValue, name: "abstract", title: "Abstract", color: magenta )
        var popart:ArtMovement = ArtMovement(id: artMovement.popart.rawValue, name: "popart", title: "Pop-Art", color: violet )
        

        self.artmovements = [
            impressionism,
            postimpressionism,
            naive,
            symbolism,
            modern,
            nouveau,
            expressionism,
            surrealism,
            abstract,
            popart
        ]
        
        var movementId:Int
        
        movementId = artMovement.impressionism.rawValue
        createArtist("Gustave Caillebotte", movementId: movementId)
        createArtist("Edgar Degas", movementId: movementId)
        createArtist("Mary Cassatt", movementId: movementId)
        createArtist("Edouard Manet", movementId: movementId)
        createArtist("Claude Monet", movementId: movementId)
        createArtist("Berthe Morisot", movementId: movementId)
        createArtist("Camille Pissarro", movementId: movementId)
        createArtist("Auguste Renoir", movementId: movementId)

        movementId = artMovement.postimpressionism.rawValue
        createArtist("Paul Cezanne", movementId: movementId)
        createArtist("Andre Derain", movementId: movementId)
        createArtist("Paul Gauguin", movementId: movementId)
        createArtist("Georges-Pierre Seurat", movementId: movementId)
        createArtist("Henri de Toulouse-Lautrec", movementId: movementId)
        createArtist("Vincent van Gogh", movementId: movementId)
        
        movementId = artMovement.naive.rawValue
        createArtist("Marc Chagall", movementId: movementId)
        createArtist("Henri Rousseau", movementId: movementId)

        movementId = artMovement.symbolism.rawValue
        createArtist("Maurice Denis", movementId: movementId)
        createArtist("Henri Fantin-Latour", movementId: movementId)
        createArtist("Maxfield Parrish", movementId: movementId)
        createArtist("Odilon Redon", movementId: movementId)
        
        movementId = artMovement.modern.rawValue
        createArtist("Georges Braque", movementId: movementId)
        createArtist("Henri Matisse", movementId: movementId)
        createArtist("Pablo Picasso", movementId: movementId)
        
        movementId = artMovement.nouveau.rawValue
        createArtist("Gustav Klimt", movementId: movementId)
        createArtist("Alphonse Mucha", movementId: movementId)
        createArtist("Konstantine Somov", movementId: movementId)
        
        movementId = artMovement.expressionism.rawValue
        createArtist("Max Beckmann", movementId: movementId)
        createArtist("Mario Eloy", movementId: movementId)
        createArtist("Lucian Freud", movementId: movementId)
        createArtist("Paul Klee", movementId: movementId)
        createArtist("Oskar Kokoschka", movementId: movementId)
        createArtist("Edvard Munch", movementId: movementId)
        createArtist("Chaim Soutine", movementId: movementId)
        
        movementId = artMovement.surrealism.rawValue
        createArtist("Salvador Dali", movementId: movementId)
        createArtist("Max Ernst", movementId: movementId)
        createArtist("Giorgio de Chirico", movementId: movementId)
        createArtist("Rene Magritte", movementId: movementId)
        createArtist("Joan Miro", movementId: movementId)
        
        movementId = artMovement.abstract.rawValue
        createArtist("Robert Delaunay", movementId: movementId)
        createArtist("Sonia Delaunay", movementId: movementId)
        createArtist("Wassily Kandinsky", movementId: movementId)
        createArtist("Jackson Pollock", movementId: movementId)
        createArtist("Mark Rothko", movementId: movementId)
        
        movementId = artMovement.popart.rawValue
        createArtist("Roy Lichtenstein", movementId: movementId)
        createArtist("Jeff Koons", movementId: movementId)
        createArtist("Andy Warhol", movementId: movementId)
        
    }

    func createArtist(name: String, movementId: Int) {
        var newArtist:Artist = Artist(id:newArtistId(), name: name) // inits caillebotte Artist object & sets its id & name
        newArtist.movementId = movementId                           // assigns relevant artMovementId
        self.artists.append(newArtist)                              // appends to DataInit artists array
    }
    
    func addArtistsToArtMovements() {
        for artist in self.artists {                              //cycle thru each Artist in DataInit's artists array
            for movement in self.artmovements {                   //for each Artist, cycle thru each ArtMovement in DataInit's artmovements array
                if (artist.movementId == movement.id) {           //if Artist's artMovementId matches ArtMovement's artMovementId...
                    movement.artists.append(artist)               //...append Artist to DataInit's ArtMovement's artists array
                }
            }
        }
    }
    
    func newArtistId() -> Int {
        return self.artists.count + 1  // each time this is called, it bumps the Artist object's ID by 1
    }

}