//  Copyright (c) 2019 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class DimensionalAnchoringTests: XCTestCase {

    // MARK: - Anchor API

    func test_AnchorApi_AnchoringWidthToConstant() {
        let constant: CGFloat = 123
        let view = UIView()

        view.anchor(.width, to: constant)

        expect(.width, of: view, toMatch: constant)
    }

    func test_AnchorApi_AnchoringHeightToConstant() {
        let constant: CGFloat = 312
        let view = UIView()

        view.anchor(.height, to: constant)

        expect(.height, of: view, toMatch: constant)
    }

    func test_AnchorApi_AnchoringSizeAnchorsWidthToHeight() {
        let constant: CGFloat = 231
        let view = UIView()

        view.anchor(.size, to: constant)

        expect(.width, of: view, toMatch: constant)
        expect(.width, toMatch: .height, of: view)
    }

    func test_AnchorApi_AnchoringDifferentDimensionalAnchors() {
        siblings { one, two in

            one.anchor(.width, to: .height, of: two)

            expect(.width, of: one, toMatch: .height, of: two)
        }
    }

    // MARK: - Anchoring API

    func test_AnchoringApi_AnchoringWidthToConstant() {
        let constant: CGFloat = 123

        expect(.width, of: UIView().anchoring(.width, to: constant), toMatch: constant)
    }

    func test_AnchoringApi_AnchoringHeightToConstant() {
        let constant: CGFloat = 312

        expect(.height, of: UIView().anchoring(.height, to: constant), toMatch: constant)
    }

    func test_AnchoringApi_AnchoringSizeAnchorsWidthToHeight() {
        let constant: CGFloat = 231
        let view = UIView().anchoring(.size, to: constant)

        expect(.width, of: view, toMatch: constant)
        expect(.width, toMatch: .height, of: view)
    }
}
