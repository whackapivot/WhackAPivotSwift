//
//  PivotsService.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 3/24/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Foundation

protocol PeopleService {
    func getPeople() -> [Person]
}

class PeopleServiceImpl: PeopleService {
    func getPeople() -> [Person] {
        return [
            Person(name: "Abby Sturges", image: "sturges.JPG"),
            Person(name: "Adrian Zankich", image: "FullSizeRender-3.jpg"),
            Person(name: "Ambarish Joshi", image: "AksXgg-Yei2iqOgc1CkyBygeimAKUaktZxIiFaESa-Ji.jpg"),
            Person(name: "Anthony Dreessen", image: "anthony2.png"),
            Person(name: "Brian Jennings", image: "CHfHuZhUYAA6TM8.png"),
            Person(name: "Catherine Zhang", image: "226d246.jpg"),
            Person(name: "Dan Neumann", image: "xasdf.jpg"),
            Person(name: "Daniel Kamerling", image: "331fa9a.jpg"),
            Person(name: "Daniel Kaplan", image: "IMG_0103.jpg"),
            Person(name: "Darcie Fitzpatrick", image: "Darcie.jpg"),
            Person(name: "David Alvarado", image: "IMG_0250.jpg"),
            Person(name: "David Bellotti", image: "dbellotti.png"),
            Person(name: "David Croney", image: "DSC01008.JPG"),
            Person(name: "David McClure", image: "DSC01020.JPG"),
            Person(name: "David Walter", image: "33302.jpeg"),
            Person(name: "Diana Villanueva", image: "selfie.png"),
            Person(name: "Dirk Janssen", image: "dirk_talks.jpg"),
            Person(name: "Ehren Murdick", image: "ehran1.JPG"),
            Person(name: "Elizabeth Gansen", image: "egansen.png"),
            Person(name: "Evan Farrar", image: "Photo_on_2011-01-06_at_18.22__2__1__400x400.jpg"),
            Person(name: "Gabe Rosenhouse", image: "bface.jpg"),
            Person(name: "Genevieve L'Esperance", image: "12068703_10204287587904308_437491883819348924_o.jpg"),
            Person(name: "Jared Friese", image: "Screen_Shot_2015-11-04_at_1.47.33_PM.png"),
            Person(name: "Jing Li", image: "Photo_on_8-25-15_at_2.45_PM.jpg"),
            Person(name: "John Ryan", image: "flashy_viddy.gif"),
            Person(name: "Johnathon Britz", image: "dangle.jpg"),
            Person(name: "Joseph Greubel", image: "CasualPic2015.jpg"),
            Person(name: "Jui Dai", image: "IMG_0561.JPG"),
            Person(name: "Kevin Kelani", image: "398777_10150997208981031_872034054_n.jpg"),
            Person(name: "Kimberly Viverette", image: "FullSizeRender.jpg"),
            Person(name: "Kristi Grassi", image: "kristi.jpg"),
            Person(name: "Lenny Koepsell", image: "lenny-caterpillar.jpg"),
            Person(name: "Liam Morley", image: "11891257_899662347572_4718471540348062734_n.jpg"),
            Person(name: "Maria Villegas", image: "IMG_0175.jpg"),
            Person(name: "Mariana Lenetis", image: "DSC00579.JPG"),
            Person(name: "Mary Baldwin", image: "Screen_Shot_2014-12-03_at_4.46.05_PM.png"),
            Person(name: "Mayra Vega", image: "IMG_0043_Mayra.jpg"),
            Person(name: "Melissa Parkerson", image: "IMG_0174.jpg"),
            Person(name: "Michael McCormick", image: "mmccormick.png"),
            Person(name: "Michael Oleske", image: "IMG_0471.jpg"),
            Person(name: "Michelle Medlock", image: "DSC01017.JPG"),
            Person(name: "Navyasri Canumalla", image: "nav.jpg"),
            Person(name: "Nicholas Mahoney", image: "Photo_on_8-25-15_at_6.10_PM__2.jpg"),
            Person(name: "Nina Sawhney", image: "pivotPic.png"),
            Person(name: "Paul Farino", image: "IMG_0393.JPG"),
            Person(name: "Peter Alfvin", image: "DSC00587.jpg"),
            Person(name: "PJ Hurley", image: "Pasted_image_at_2015_11_19_11_17_PM.png"),
            Person(name: "Ross Hale", image: "DSC00583.JPG"),
            Person(name: "Ryan Moran", image: "rmoran.png"),
            Person(name: "Scott Orlyck", image: "IMG_3229.GIF"),
            Person(name: "Suzan Choy", image: "AAEAAQAAAAAAAAKaAAAAJDZiOThmOWRiLTEzNjYtNDljMy04Yzc3LThlMDE0MmRiY2I1MQ.jpg"),
            Person(name: "Sylvia Lai", image: "profile.jpg"),
            Person(name: "Tim Kersey", image: "FullSizeRender-8.jpg"),
            Person(name: "Tommy Orr", image: "IMG_0557.JPG"),
            Person(name:"Zachary Gershman", image: "FullSizeRender-Zach.jpg")
        ]
    }
}
