//
//  Task2_VitalyZubenko_Junior_iOSUITestsLaunchTests.swift
//  Task2_VitalyZubenko_Junior_iOSUITests
//
//  Created by Vitaly Zubenko on 11.09.2023.
//

import XCTest

class Task2_VitalyZubenko_Junior_iOSUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
