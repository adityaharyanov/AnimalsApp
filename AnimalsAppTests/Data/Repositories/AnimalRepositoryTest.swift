//
//  AnimalRepositoryTest.swift
//  AnimalsAppTests
//
//  Created by Aditya Haryanov on 18/07/24.
//

import XCTest
import RxSwift
@testable import AnimalsApp

final class AnimalRepositoryTest: XCTestCase {


}

class MockAnimalRepository: AnimalRepository {
    func getAnimals(by keyword: String) -> RxSwift.Observable<[Animal]> {
        return .just([Animal.createMock(), Animal.createMock()])
    }
}
