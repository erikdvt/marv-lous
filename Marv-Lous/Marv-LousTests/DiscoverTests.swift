//
//  DiscoverTests.swift
//  Marv-LousTests
//
//  Created by Erik Egers on 2022/06/01.
//

import XCTest
@testable import Marv_Lous

class DiscoverTests: XCTestCase {
    
    private var viewModel: DiscoverViewModel!
    private var delegate: MockDelegate!
    private var repository: MockRepository!
    
    override func setUp() {
        super.setUp()
        delegate = MockDelegate()
        repository = MockRepository()
        viewModel = DiscoverViewModel(delegate: delegate, repository: repository)
    }
    
    func testFetchComicListReturnsScuccess() {
        viewModel.fetchComicList()
        XCTAssertTrue(delegate.reloadViewCalled)
    }
    
    func testFetchComicListReturnsFailure() {
        repository.shouldFail = true
        viewModel.fetchComicList()
        XCTAssertTrue(delegate.showErrorCalled)
    }
    
    func testFetchComicReturnsCorrectResult() {
        viewModel.fetchComicList()
        let result = viewModel.comic(atIndex: 0)
        XCTAssertEqual(result?.title, "Sentry, the (Trade Paperback)")
    }
    
    func testComicCountReturnsCorrectValue() {
        viewModel.fetchComicList()
        let numberOfComics = viewModel.comicCount
        XCTAssertEqual(numberOfComics, 1)
    }
    
    func testCopyrightLabelReturnsCorrectResult() {
        viewModel.fetchComicList()
        let copyrightLabel = viewModel.copyrightLabel()
        XCTAssertEqual(copyrightLabel, "© 2022 MARVEL")
    }
    
    class MockDelegate: DiscoverViewModelDelegate {
        var reloadViewCalled = false
        var showErrorCalled = false
        
        func reloadView() {
            reloadViewCalled = true
        }
        
        func showError(_ error: String) {
            showErrorCalled = true
        }
    }
    
    class MockRepository: SearchComicRepositoryType {
        var shouldFail = false
        
        func fetchSearchResults(completion: @escaping (SearchComicResult)) {
            if shouldFail {
                completion(.failure(.internalError))
            } else {
                completion(.success(self.mockComicData()))
            }
        }
        
        private func mockComicData() -> ComicsModel {
            let mockData = Comic(id: nil,
                                 digitalId: nil,
                                 title: "Sentry, the (Trade Paperback)",
                                 issueNumber: 0.0,
                                 variantDescription: "",
                                 description: "On the edge of alcoholism and a failed marriage, Bob Reynolds wakes up to discover his true nature. A forgotten hero, he must unravel the conspiracy to erase his memory from mankind before an evil entity returns.",
                                 modified: nil,
                                 isbn: nil,
                                 upc: nil,
                                 diamondCode: nil,
                                 ean: nil,
                                 issn: nil,
                                 format: nil,
                                 pageCount: 240,
                                 textObjects: nil,
                                 resourceURI: nil,
                                 urls: [Url(type: "detail", url: "http://marvel.com/comics/collection/1003/sentry_the_trade_paperback?utm_campaign=apiRef&utm_source=2a9ac5901f9444c283e85fbd2849e3f6")],
                                 series: nil,
                                 variants: nil,
                                 collections: nil,
                                 collectedIssues: nil,
                                 dates: [ComicDate(type: "onsaleDate", date: "2029-12-31T00:00:00-0500")],
                                 prices: [ComicPrice(type: "printPrice", price: 9.99)],
                                 thumbnail: Image(path: "http://i.annihil.us/u/prod/marvel/i/mg/f/c0/4bc66d78f1bee", extension: "jpg"),
                                 images: nil,
                                 creators: nil,
                                 characters: nil,
                                 stories: nil,
                                 events: nil)
            
            let mockModel = ComicsModel(code: 200,
                                        status: "Ok",
                                        copyright: "© 2022 MARVEL",
                                        attributionText: "Data provided by Marvel. © 2022 MARVEL",
                                        attributionHTML: "<a href=\"http://marvel.com\">Data provided by Marvel. © 2022 MARVEL</a>",
                                        data: ComicDataContainer(offset: 0, limit: 20, total: 52247, count: 1, results: [mockData]),
                                        etag: "3d327b57a1c7ea2ea01ea50aa00ecc2587c62eba")
            
            return mockModel
        }
    }
}
