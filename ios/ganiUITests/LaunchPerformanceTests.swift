//
//  LaunchPerformanceTests.swift
//  gani
//
//  Created by Abhinav Gangula on 10/28/26.
//

import XCTest

final class LaunchPerformanceTests: XCTestCase {
    @MainActor
    func testLaunchPerformance() {
        let app = XCUIApplication()

        measure(metrics: [XCTApplicationLaunchMetric()], block: {
            app.terminate()
            app.launch()
        })
    }
}
