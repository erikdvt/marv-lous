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
    
    func testFormatComicCorrectlyFormatsCommic() {
        let mockData = mockData()
        let formattedMockData = formattedMockData()
        
        viewModel.setComicInfo(mockData, "© 2022 MARVEL")
        let formattedData = viewModel.formatComicData()
        XCTAssertEqual(formattedMockData.thumbnailLink, formattedData.thumbnailLink)
        XCTAssertEqual(formattedMockData.copyright, formattedData.copyright)
        XCTAssertEqual(formattedMockData.releaseDate, formattedData.releaseDate)
        XCTAssertEqual(formattedMockData.title, formattedData.title)
        XCTAssertEqual(formattedMockData.description, formattedData.description)
        XCTAssertEqual(formattedMockData.issue, formattedData.issue)
        XCTAssertEqual(formattedMockData.pages, formattedData.pages)
        XCTAssertEqual(formattedMockData.price, formattedData.price)
        XCTAssertEqual(formattedMockData.variant, formattedData.variant)
    }
    
    func testPurchaseLinkReturnsCorrectLink() {
        let mockData = mockData()
        viewModel.setComicInfo(mockData, "© 2022 MARVEL")
        let link = viewModel.purchaseLink()
        XCTAssertEqual(link, "http://marvel.com/comics/collection/1003/sentry_the_trade_paperback?utm_campaign=apiRef&utm_source=2a9ac5901f9444c283e85fbd2849e3f6")
    }
    
    func mockData() -> Comic {
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
        return mockData
    }
    
    func formattedMockData() -> FormattedComic {
        let formattedMockData = FormattedComic(title: "Sentry, the (Trade Paperback)",
                                               issue: "Issue 0",
                                               pages: "240 pages",
                                               variant: "", price: "$9.99",
                                               description: "On the edge of alcoholism and a failed marriage, Bob Reynolds wakes up to discover his true nature. A forgotten hero, he must unravel the conspiracy to erase his memory from mankind before an evil entity returns.",
                                               releaseDate: "Released: 2029-12-31",
                                               copyright: "© 2022 MARVEL",
                                               thumbnailLink: "https://i.annihil.us/u/prod/marvel/i/mg/f/c0/4bc66d78f1bee/detail.jpg")
        return formattedMockData
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
