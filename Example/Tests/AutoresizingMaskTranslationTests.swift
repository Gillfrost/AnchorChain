//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class AutoresizingMaskTranslationTests: XCTestCase {

    // MARK: - Anchor API

    func testAnchorApi_AnchoringDisablesAutoresizingMaskTranslationInReceiver() {
        let view = UIView()
        let superview = UIView()

        view.anchor(to: superview)

        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(superview.translatesAutoresizingMaskIntoConstraints)
    }

    // MARK: - Anchored API

    func testAnchoredApi_AnchoringDisablesAutoresizingMaskTranslationInReceiver() {
        let superview = UIView()

        XCTAssertFalse(UIView().anchored(to: superview).translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(superview.translatesAutoresizingMaskIntoConstraints)
    }

    // MARK: - Anchoring API

    func testAnchoringApi_AnchoringDisablesAutoresizingMaskTranslationInOther() {
        let other = UIView()
        let view = UIView().anchoring(other)

        XCTAssertTrue(view.translatesAutoresizingMaskIntoConstraints)
        XCTAssertFalse(other.translatesAutoresizingMaskIntoConstraints)
    }

}
