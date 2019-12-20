//
//  TRPSearcAreaButtonTest.swift
//  TRPUIKitTests
//
//  Created by EvrenYasar on 13.11.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import XCTest
@testable import TRPUIKit
class TRPSearcAreaButtonTest: XCTestCase  {

    
    func testIsHidden() {
        let button = TRPSearchAreaButton(frame: CGRect.zero, title: "")
        let status = button.isHidden
        XCTAssert(status)
    }
    
    func testButtonName() {
        let title = "tempTitle"
        let button = TRPSearchAreaButton(frame: CGRect.zero, title: title)
        XCTAssertNotNil(button.title)
        XCTAssertEqual(title, button.title)
    }
    
    func testTrashHold() {
        let button = TRPSearchAreaButton(frame: CGRect.zero, title: "")
        let zoomLevelTH = 12.0
        button.setZoomLevelTreshold(zoomLevelTH)
        XCTAssertEqual(button.zoomLevelTrashHold, zoomLevelTH)
    }
    
    func testMapZoomLevelLowThanTH() {
        let button = TRPSearchAreaButton(frame: CGRect.zero, title: "")
        let zoomLevelTH = 12.0
        button.setZoomLevelTreshold(zoomLevelTH)
        button.zoomLevel(11)
        XCTAssert(button.isHidden)
    }
    
    func testMapZoomLevelHighThanTH() {
        let button = TRPSearchAreaButton(frame: CGRect.zero, title: "")
        let zoomLevelTH = 12.0
        button.setZoomLevelTreshold(zoomLevelTH)
        button.zoomLevel(13)
        XCTAssertEqual(button.isHidden, false)
    }
    
}
