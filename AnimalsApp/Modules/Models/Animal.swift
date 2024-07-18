//
//  AnimalResponse.swift
//  AnimalsApp
//
//  Created by Aditya Haryanov on 17/07/24.
//

import Foundation

struct Animal: Codable, Equatable {
    let name: String
    let taxonomy: [String: String]
    let locations: [String]
    let characteristics: [String: String]
}

//{
//    "name": "American Foxhound",
//    "taxonomy": {
//      "kingdom": "Animalia",
//      "phylum": "Chordata",
//      "class": "Mammalia",
//      "order": "Carnivora",
//      "family": "Canidae",
//      "genus": "Canis",
//      "scientific_name": "Canis lupus"
//    },
//    "locations": [
//      "North-America"
//    ],
//    "characteristics": {
//      "distinctive_feature": "Long legs and wide, flat ears",
//      "temperament": "Mix of affectionate, loving, and stubborn",
//      "training": "Medium",
//      "diet": "Omnivore",
//      "average_litter_size": "7",
//      "type": "Hound",
//      "common_name": "American Foxhound",
//      "slogan": "Sweet, kind, loyal, and very loving!",
//      "group": "Dog",
//      "color": "BlackWhiteTan",
//      "skin_type": "Hair",
//      "lifespan": "10 to 12 years"
//    }
//  },
