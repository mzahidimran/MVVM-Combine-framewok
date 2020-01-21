//
//  KiwiTests.swift
//  KiwiTests
//
//  Created by Muhammad Zahid Imran on 1/18/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import XCTest
import Combine
@testable import Kiwi

let base = "https://api.skypicker.com"

class KiwiTests: XCTestCase {
    
    let testTimeout: TimeInterval = 1
    
    var mocks: Mocks!
    var customRepository: RemoteRepository!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // URLProtocolMock.setup()
        self.mocks = Mocks()
        
        // now set up a configuration to use our mock
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        // and create the URLSession from that
        let session = URLSession(configuration: config)
        customRepository = RemoteRepository(session: session)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        //Restore the default publisher
        
        URLProtocolMock.response = nil
        URLProtocolMock.error = nil
        URLProtocolMock.testURLs = [String?: Data]()
    }
    
    func testBaseURL() {
        XCTAssertEqual(Environment.dev.rawValue, base)
    }
    
    func testURLRouter() {
        XCTAssertEqual(try? URLRouter.environment(.dev).flights().asURL().absoluteString, base + "/flights")
        XCTAssertEqual(try? URLRouter.environment(.dev).flights(id: "123").asURL().absoluteString, base + "/flights/123")
        XCTAssertEqual(try? URLRouter.environment(.dev).asURL().absoluteString, base)
    }
    
    func evalValidResponseTest<T:Publisher>(publisher: T?) -> (expectations:[XCTestExpectation], cancellable: AnyCancellable?) {
        XCTAssertNotNil(publisher)
        
        let expectationFinished = expectation(description: "finished")
        let expectationReceive = expectation(description: "receiveValue")
        let expectationFailure = expectation(description: "failure")
        expectationFailure.isInverted = true
        
        let cancellable = publisher?.sink (receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                print("--TEST ERROR--")
                print(error.localizedDescription)
                print("------")
                expectationFailure.fulfill()
            case .finished:
                expectationFinished.fulfill()
            }
        }, receiveValue: { response in
            XCTAssertNotNil(response)
            print(response)
            expectationReceive.fulfill()
        })
        return (expectations: [expectationFinished, expectationReceive, expectationFailure],
                cancellable: cancellable)
    }
    
    func evalInvalidResponseTest<T:Publisher>(publisher: T?) -> (expectations:[XCTestExpectation], cancellable: AnyCancellable?) {
        XCTAssertNotNil(publisher)
        
        let expectationFinished = expectation(description: "Invalid.finished")
        expectationFinished.isInverted = true
        let expectationReceive = expectation(description: "Invalid.receiveValue")
        expectationReceive.isInverted = true
        let expectationFailure = expectation(description: "Invalid.failure")
        
        let cancellable = publisher?.sink (receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                print("--TEST FULFILLED--")
                print(error.localizedDescription)
                print("------")
                expectationFailure.fulfill()
            case .finished:
                expectationFinished.fulfill()
            }
        }, receiveValue: { response in
            XCTAssertNotNil(response)
            print(response)
            expectationReceive.fulfill()
        })
         return (expectations: [expectationFinished, expectationReceive, expectationFailure],
                       cancellable: cancellable)
    }
    
    func testCreate() {

        let flightsURL = try! Router.request(URLRouter.environment(.dev).flights().asURL()).method(.get).parameters([:]).asURLRequest().url!
        URLProtocolMock.testURLs = [flightsURL.absoluteString: Data(mocks.popularFlightsResponse.utf8)]
        
        //When is valid
        URLProtocolMock.response = mocks.validResponse
        let publisher: AnyPublisher<FlightOfferResponse, HTTPError> = try! customRepository.searchFlights(params: [:])
        let validTest = evalValidResponseTest(publisher: publisher)
        wait(for: validTest.expectations, timeout: testTimeout)
        validTest.cancellable?.cancel()
        
        //When has invalid response
        URLProtocolMock.response = mocks.invalidResponse
        let publisher2 = try! customRepository.searchFlights(params: [:])
        let invalidTest = evalInvalidResponseTest(publisher: publisher2)
        wait(for: invalidTest.expectations, timeout: testTimeout)
        invalidTest.cancellable?.cancel()

        //When has invalid data and valid response
        URLProtocolMock.testURLs[flightsURL.absoluteString] = Data("{{}".utf8)
        URLProtocolMock.response = mocks.validResponse

        let publisher3 = try! customRepository.searchFlights(params: [:])
        let invalidTest3 = evalInvalidResponseTest(publisher: publisher3)
        wait(for: invalidTest3.expectations, timeout: testTimeout)
        invalidTest3.cancellable?.cancel()

        //Network Failure
        URLProtocolMock.response = mocks.validResponse
        URLProtocolMock.error = mocks.networkError

        let publisher4 = try! customRepository.searchFlights(params: [:])
        let invalidTest4 = evalInvalidResponseTest(publisher: publisher4)
        wait(for: invalidTest4.expectations, timeout: testTimeout)
        invalidTest4.cancellable?.cancel()
        
    }
    
    func testValidDataReceived() -> Void {
        
        let expectationFinished = expectation(description: "finished")
        let expectationReceive = expectation(description: "receiveValue")
        let expectationFailure = expectation(description: "failure")
        expectationFailure.isInverted = true
        
        let expectations = [expectationFinished, expectationReceive, expectationFailure]
        
        let flightsURL = try! Router.request(URLRouter.environment(.dev).flights().asURL()).method(.get).parameters([:]).asURLRequest().url!
        URLProtocolMock.testURLs = [flightsURL.absoluteString: Data(mocks.popularFlightsResponse.utf8)]
        
        //When is valid
        URLProtocolMock.response = mocks.validResponse
        let publisher: AnyPublisher<FlightOfferResponse, HTTPError> = try! customRepository.searchFlights(params: [:])
        let cancellable = publisher.sink (receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                print("--TEST FULFILLED--")
                print(error.localizedDescription)
                print("------")
                expectationFailure.fulfill()
            case .finished:
                expectationFinished.fulfill()
            }
        }, receiveValue: { response in
            XCTAssertNotNil(response)
            print(response)
            XCTAssertEqual(response.data?.count, 1)
            XCTAssertEqual(response.data?.first?.id, "145c0b77477400002a5f84b1_0")
            expectationReceive.fulfill()
        })
        wait(for: expectations, timeout: testTimeout)
        cancellable.cancel()
        
    }
    

}
