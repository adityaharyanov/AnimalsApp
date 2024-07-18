//
//  AnimalTest.swift
//  AnimalsAppTests
//
//  Created by Aditya Haryanov on 18/07/24.
//

import Foundation
import XCTest
@testable import AnimalsApp

class AnimalTest: XCTestCase {
    func test_allPropertiesMatch_shouldEqual() {
        let sut = Animal.createMock()
        let other = Animal.createMock()
        
        XCTAssertEqual(sut, other)
        XCTAssertEqual(other, sut)
    }
    
    func test_nameDifferent_shouldNotEqual() {
        let sut = Animal.createMock(name: "Pokemon")
        let other = Animal.createMock()
        
        XCTAssertNotEqual(sut, other)
        XCTAssertNotEqual(other, sut)
    }
}

extension Animal {
    static func createMock(name: String? = nil,
                       taxonomy: [String: String]? = nil,
                       locations: [String]? = nil,
                       characteristics: [String: String]? = nil) -> Animal {
        
        return Animal(
            name: name ?? "American Foxhound",
            taxonomy: taxonomy ?? [
                "kingdom": "Animalia",
                "phylum": "Chordata",
                "class": "Mammalia",
            ],
            locations: locations ?? ["North-America"],
            characteristics: characteristics ?? [
                "training" : "Medium",
                "diet": "Omnivore"
            ]
        )
    }
}
