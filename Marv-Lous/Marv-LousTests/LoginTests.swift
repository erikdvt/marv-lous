//
//  LoginTests.swift
//  Marv-LousTests
//
//  Created by Erik Egers on 2022/06/01.
//

import XCTest
@testable import Marv_Lous

class LoginTests: XCTestCase {
    
    private var viewModel: LoginViewModel!
    private var delegate: MockDelegate!
    
    override func setUp() {
        super.setUp()
        delegate = MockDelegate()
        viewModel = LoginViewModel(delegate: delegate)
    }
    
    func testCorrectErrorCalledWhenNoLoginDetailsProvided() {
        viewModel.attemptLogin("", "")
        XCTAssertFalse(delegate.navigateToLandingPageCalled)
        XCTAssertTrue(delegate.showErrorCalled)
        XCTAssertEqual(delegate.error, "Please enter username and password.")
    }
    
    func testCorrectErrorCalledWhenNoUsernameProvided() {
        viewModel.attemptLogin("", "Password")
        XCTAssertFalse(delegate.navigateToLandingPageCalled)
        XCTAssertTrue(delegate.showErrorCalled)
        XCTAssertEqual(delegate.error, "Username field is empty.")
    }
    
    func testCorrectErrorCalledWhenNoPasswordProvided() {
        viewModel.attemptLogin("Username", "")
        XCTAssertFalse(delegate.navigateToLandingPageCalled)
        XCTAssertTrue(delegate.showErrorCalled)
        XCTAssertEqual(delegate.error, "Password field is empty.")
    }
    
    func testCorrectErrorCalledWhenIncorrectLoginDetailProvided() {
        viewModel.attemptLogin("Username", "Password")
        XCTAssertFalse(delegate.navigateToLandingPageCalled)
        XCTAssertTrue(delegate.showErrorCalled)
        XCTAssertEqual(delegate.error, "Invalid username and/or password.")
    }
    
    func testSegueCalledWhenCorrectLoginDetailsProvided() {
        viewModel.attemptLogin("Admin", "TestPass123")
        XCTAssertTrue(delegate.navigateToLandingPageCalled)
        XCTAssertFalse(delegate.showErrorCalled)
    }
    
    class MockDelegate: LoginViewModelDelegate {
        var showErrorCalled = false
        var error = ""
        var navigateToLandingPageCalled = false
        
        func showError(_ error: String) {
            showErrorCalled = true
            self.error = error
        }
        
        func navigateToLandingPage() {
            navigateToLandingPageCalled = true
        }
    }
}
