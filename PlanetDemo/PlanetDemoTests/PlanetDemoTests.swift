//
//  PlanetDemoTests.swift
//  PlanetDemoTests
//
//  Created by Tripathi, Himani on 1/8/19.
//  Copyright © 2019 Tripathi, Himani. All rights reserved.
//

import XCTest
@testable import PlanetDemo

class PlanetDemoTests: XCTestCase {
    var planetsVC: PlanetsViewController!
    
    override func setUp() {
        super.setUp()
        planetsVC = PlanetsViewController()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testLoadData() {
        planetsVC.viewModel.fetchData {
           print("Success block called")
        }
        
        sleep(10)
        XCTAssert(self.planetsVC.viewModel.planets.results.count != 0, "Data loaded successfully")
    }
    
    func testDeleteData() {
        planetsVC.viewModel.deleteData {
             print("Success block called")
        }
        
        sleep(10)
        XCTAssert(self.planetsVC.viewModel.planets.results.count == 0, "Data deleted successfully")
    }
}
