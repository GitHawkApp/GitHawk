//
//  IssueCommentTableTests.swift
//  FreetimeTests
//
//  Created by B_Litwin on 6/6/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//
import XCTest
import StyledText
@testable import Freetime

class IssueCommentTableTests: XCTestCase {
    var textItem: StyledTextRenderer!
    var medTextItem: StyledTextRenderer!
    var longerTextItem: StyledTextRenderer!
    var tallerItem: StyledTextRenderer!
    let contentSizeCategory = UIApplication.shared.preferredContentSizeCategory
    
    override func setUp() {
        super.setUp()
        
        textItem = StyledTextRenderer(
            string: StyledTextString(
                styledTexts: [StyledText(
                    text: "item"
                )]
            ),
            contentSizeCategory: contentSizeCategory
        )
        
        medTextItem = StyledTextRenderer(
            string: StyledTextString(
                styledTexts: [StyledText(
                    text: "medium item"
                )]
            ),
            contentSizeCategory: contentSizeCategory
        )
        
        
        longerTextItem = StyledTextRenderer(
            string: StyledTextString(
                styledTexts: [StyledText(
                    text: "longer text length item"
                )]
            ),
            contentSizeCategory: contentSizeCategory
        )
        
        tallerItem = StyledTextRenderer(
            string: StyledTextString(
                styledTexts: [StyledText(
                    text: "T"
                )]
            ),
            contentSizeCategory: .accessibilityExtraExtraLarge
        )
    }
    
    func test_tableDimensions() {
        
        // create table rows with text elements of different sizes and test whether the
        // model recieves appropriate height and width dimensions
        let rowOne: [StyledTextRenderer] = [textItem, textItem, textItem]
        let rowTwo: [StyledTextRenderer] = [textItem, medTextItem, textItem]
        let rowThree: [StyledTextRenderer] = [textItem, textItem, longerTextItem]
        let rowFour: [StyledTextRenderer] = [tallerItem, textItem, textItem]
        
        let rows = [rowOne, rowTwo, rowThree, rowFour]
        var buckets = [TableBucket()]
        var rowHeights = [CGFloat]()
        
        rows.forEach {
            fillBuckets(
                rows: $0,
                buckets: &buckets,
                rowHeights: &rowHeights,
                fill: false
            )
        }
        
        let model = IssueCommentTableModel(
            buckets: buckets,
            rowHeights: rowHeights
        )
        
        let columns = model.columns
        
        //widths should reflect the width of widest cell in column
        XCTAssertEqual(columns[0].width, textItem.viewSize(in: 0).width)
        XCTAssertEqual(columns[1].width, medTextItem.viewSize(in: 0).width)
        XCTAssertEqual(columns[2].width, longerTextItem.viewSize(in: 0).width)
        
        //heights should reflect the height of the tallest cell across horizontal row
        XCTAssertEqual(rowHeights[0], textItem.viewSize(in: 0).height)
        XCTAssertEqual(rowHeights[3], tallerItem.viewSize(in: 0).height)
    }
}

