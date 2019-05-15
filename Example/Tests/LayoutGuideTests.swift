//  Copyright (c) 2019 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class LayoutGuideTests: XCTestCase {

    // MARK: - Anchor API

    func testAnchorApi_AnchoringToSafeArea() {
        viewAndSuperview { view, superview in

            view.anchor(to: .safeArea)

            expect(view, toMatch: superview.safeAreaLayoutGuide)
        }
    }

    func testAnchorApi_AnchoringToLayoutMargins() {
        viewAndSuperview { view, superview in

            view.anchor(to: .layoutMargins)

            expect(view, toMatch: superview.layoutMarginsGuide)
        }
    }

    func testAnchorApi_AnchoringToReadableContentGuide() {
        viewAndSuperview { view, superview in

            view.anchor(to: .readableContent)

            expect(view, toMatch: superview.readableContentGuide)
        }
    }

    func testAnchorApi_AnchoringToLayoutGuideOfOther() {
        let view = UIView()
        let other = UIView()

        view.anchor(to: .safeArea, of: other)

        expect(view, toMatch: other.safeAreaLayoutGuide)
    }

    func testAnchorApi_AnchoringOneAnchorToLayoutGuide() {
        viewAndSuperview { view, superview in

            view.anchor(.top, to: .layoutMargins)

            expect(.top, of: view, toMatch: superview.layoutMarginsGuide)
        }
    }

    func testAnchorApi_AnchoringOneAnchorToLayoutGuideOfOther() {
        let view = UIView()
        let other = UIView()

        view.anchor(.left, to: .readableContent, of: other)

        expect(.left, of: view, toMatch: other.readableContentGuide)
    }

    func testAnchorApi_AnchoringMultipleAnchorsToLayoutGuide() {
        viewAndSuperview { view, superview in

            view.anchor(.leading, .bottom, to: .safeArea)

            expect(.leading, .bottom, of: view, toMatch: superview.safeAreaLayoutGuide)
        }
    }

    func testAnchorApi_AnchoringMultipleAnchorsToLayoutGuideOfOther() {
        let view = UIView()
        let other = UIView()

        view.anchor(.trailing, .centerY, to: .layoutMargins, of: other)

        expect(.trailing, .centerY, of: view, toMatch: other.layoutMarginsGuide)
    }

    // MARK: - Anchored API

    func testAnchoredApi_AnchoringToLayoutGuide() {
        viewAndSuperview { view, superview in
            expect(view.anchored(to: .safeArea), toMatch: superview.safeAreaLayoutGuide)
        }
    }

    func testAnchoredApi_AnchoringToLayoutGuideOfOther() {
        let other = UIView()
        let view = UIView().anchored(to: .layoutMargins, of: other)

        expect(view, toMatch: other.layoutMarginsGuide)
    }

    // MARK: - Anchoring API

    func testAnchoringApi_AnchoringOtherToLayoutGuide() {
        let other = UIView()

        expect(other, toMatch: UIView().anchoring(other, to: .safeArea).safeAreaLayoutGuide)
    }

    func testAnchoringApi_AnchoringSpecificAnchorsOfOtherToLayoutGuide() {
        let other = UIView()

        expect(.top, .centerX,
               of: other,
               toMatch: UIView().anchoring(.top, .centerX, of: other, to: .layoutMargins).layoutMarginsGuide)
    }
}
