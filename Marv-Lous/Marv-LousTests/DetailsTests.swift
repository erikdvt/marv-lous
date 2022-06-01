//
//  DetailsTests.swift
//  Marv-LousTests
//
//  Created by Erik Egers on 2022/06/01.
//

import XCTest
@testable import Marv_Lous

class DetailsTests: XCTestCase {
    
    private var viewModel: DetailsViewModel!
    private var delegate: MockDelegate!
    
    override func setUp() {
        super.setUp()
        delegate = MockDelegate()
        viewModel = DetailsViewModel(delegate: delegate)
    }
    
    func testLikeComicCalled() {
        
    }

    class MockDelegate: DetailsViewModelDelegate {
        var showErrorCalled = false
        var likeComicCalled = false
        
        func showError(_ error: String) {
            showErrorCalled = true
        }
        
        func likeComic() {
            likeComicCalled = true
        }
    }
}
