//
//  Image.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 18/07/24.
//

import Foundation

struct Image: Codable {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let avgColor: String
    let src: [String:String]
    var isFavourited: Bool?
    var objectID: NSObject?
    
    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case url
        case avgColor = "avg_color"
        case src
    }
}

//{
//      "id": 3573351,
//      "width": 3066,
//      "height": 3968,
//      "url": "https://www.pexels.com/photo/trees-during-day-3573351/",
//      "photographer": "Lukas Rodriguez",
//      "photographer_url": "https://www.pexels.com/@lukas-rodriguez-1845331",
//      "photographer_id": 1845331,
//      "avg_color": "#374824",
//      "src": {
//        "original": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png",
//        "large2x": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
//        "large": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=650&w=940",
//        "medium": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=350",
//        "small": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=130",
//        "portrait": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
//        "landscape": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
//        "tiny": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
//      },
//      "liked": false,
//      "alt": "Brown Rocks During Golden Hour"
//    }
