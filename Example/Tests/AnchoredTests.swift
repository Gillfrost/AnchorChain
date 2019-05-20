//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class AnchoredTests: XCTestCase {

    // MARK: - Default parameters

    func testTargetDefaultsToSuperview() {
        viewAndSuperview { view, superview in
            expect(view.anchored(), toMatch: superview)
        }
    }

    // MARK: - Separate anchors

    func testSeparateAnchors() {
        UIView.Anchor.allCases.forEach { anchor in
            let other = UIView()
            let view = UIView().anchored(anchor, to: other)

            expect(anchor.layoutAttribute, of: view, toMatch: other)
        }
    }

    // MARK: - Edge anchoring insets

    func testAnchoredToImplicitSuperviewWithInsets() {
        viewAndSuperview { view, superview in
            let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)

            expect(view.anchored(with: insets), toMatch: superview, withInsets: insets)
        }
    }

    func testAnchoredToLayoutGuideOfImplicitSuperviewWithInsets() {
        viewAndSuperview { view, superview in
            let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)

            expect(view.anchored(to: .safeArea, with: insets),
                   toMatch: superview.safeAreaLayoutGuide,
                   withInsets: insets)
        }
    }

    func testAnchoredToOtherWithInsets() {
        let view = UIView()
        let other = UIView()
        let insets = UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44)

        expect(view.anchored(to: other, with: insets), toMatch: other, withInsets: insets)
    }

    func testAnchoredToLayoutGuideOfOtherWithInsets() {
        let view = UIView()
        let other = UIView()
        let insets = UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44)

        expect(view.anchored(to: .layoutMargins, of: other, with: insets),
               toMatch: other.layoutMarginsGuide,
               withInsets: insets)
    }
}
