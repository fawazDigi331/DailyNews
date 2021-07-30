//
//  DailyNewsTests.swift
//  DailyNewsTests
//
//  Created by D&C Dev on 28/07/2021.
//

import XCTest
import Alamofire
@testable import DailyNews

class DailyNewsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOneDayFeed(){
        let url =  "\(UrlDirectory.baseUrl)\(UrlDirectory.getPopularNewsApi(for: 1))"
            AF.request(url).validate().responseDecodable(of: Articles.self) { (response) in
                switch response.result {
                    case .success:
                      XCTAssert(true, "Got 1 Day Feed SuccessFully")
                    case .failure(let error):
                        XCTFail("1 Day Feed Fetch Failed!")
                        print(error.localizedDescription)
                    }
               }
    }
    
    func test7DayFeed(){
        let url =  "\(UrlDirectory.baseUrl)\(UrlDirectory.getPopularNewsApi(for: 7))"
            AF.request(url).validate().responseDecodable(of: Articles.self) { (response) in
                switch response.result {
                    case .success:
                      XCTAssert(true, "Got 7 Days Feed SuccessFully")
                    case .failure(let error):
                        XCTFail("1 Day Feed Fetch Failed!")
                        print(error.localizedDescription)
                    }
               }
    }
    
    func test30DayFeed(){
        let url =  "\(UrlDirectory.baseUrl)\(UrlDirectory.getPopularNewsApi(for: 30))"
            AF.request(url).validate().responseDecodable(of: Articles.self) { (response) in
                switch response.result {
                    case .success:
                      XCTAssert(true, "Got 30 Days Feed SuccessFully")
                    case .failure(let error):
                        XCTFail("1 Day Feed Fetch Failed!")
                        print(error.localizedDescription)
                    }
               }
    }
  

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
