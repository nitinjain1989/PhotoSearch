//
//  PhotoSearchTests.swift
//  PhotoSearchTests
//
//  Created by NItin Jain  on 19/09/18.
//  Copyright © 2018 NItin Jain . All rights reserved.
//

import XCTest

@testable import PhotoSearch

class PhotoSearchTests: XCTestCase {

    var testViewModel:PhotoViewModel!
    
    override func setUp() {
        super.setUp()
        testViewModel = PhotoViewModel()
    }

    override func tearDown() {
        self.testViewModel = nil
        super.tearDown()
    }

    //View Model Test
    func testGetSeachData()
    {
        let promise = expectation(description: "Fetch Search Data")
        
        testViewModel.errorListener = {
            XCTFail("Fetching Search Data Fail")
        }
        
        testViewModel.listener = {
             promise.fulfill()
        }
        testViewModel.getSearchData("Hello")
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //Image Download manager test
    func testImageDownload()
    {
        if let url = URL(string: "http://farm1.static.flickr.com/578/23451156376_8983a8ebc7.jpg")
        {
            let promise = expectation(description: "Download Image Data")
            ImageDownloadManager.downloadImage(url: url) { (image, error, url) in
                
                if let error = error
                {
                    XCTFail("Image Download Fail: \(error.localizedDescription)")
                }
                else
                {
                    promise.fulfill()
                }
            }
            waitForExpectations(timeout: 5, handler: nil)
        }
    }
    
    //Test Network Service
    func testNetworkService()
    {
        if let url = SearchUrlBuilder(searchText: "Hello", pageCount: 1).getUrl()
        {
             let promise = expectation(description: "Network Service")
            NetworkService().performRequest(requestUrl: url) { (error, data) in
                
                if let error = error
                {
                    XCTFail("Network Fail: \(error.localizedDescription)")
                }
                else
                {
                    promise.fulfill()
                }
            }
            waitForExpectations(timeout: 5, handler: nil)
        }
       
    }
}
