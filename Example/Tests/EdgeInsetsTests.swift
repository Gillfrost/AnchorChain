//  Copyright (c) 2019 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class EdgeInsetsTests: XCTestCase {

    // MARK: - Anchor API

    func test_AnchorApi_AnchoringWithInsets() {
        viewAndSuperview { view, superview in
            let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)

            view.anchor(with: insets)

            expect(view, toMatch: superview, withInsets: insets)
        }
    }

    func test_AnchorApi_AnchoringToLayoutGuideWithInsets() {
        viewAndSuperview { view, superview in
            let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)

            view.anchor(to: .safeArea, with: insets)

            expect(view, toMatch: superview.safeAreaLayoutGuide, withInsets: insets)
        }
    }

    func test_AnchorApi_AnchoringToOtherWithInsets() {
        let view = UIView()
        let other = UIView()
        let insets = UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44)

        view.anchor(to: other, with: insets)

        expect(view, toMatch: other, withInsets: insets)
    }

    func test_AnchorApi_AnchoringToLayoutGuideOfOtherWithInsets() {
        let view = UIView()
        let other = UIView()
        let insets = UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44)

        view.anchor(to: .layoutMargins, of: other, with: insets)

        expect(view, toMatch: other.layoutMarginsGuide, withInsets: insets)
    }

    // MARK: - Anchored API

    func test_AnchoredApi_AnchoringWithInsets() {
        viewAndSuperview { view, superview in
            let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)

            expect(view.anchored(with: insets), toMatch: superview, withInsets: insets)
        }
    }

    func test_AnchoredApi_AnchoringToLayoutGuideWithInsets() {
        viewAndSuperview { view, superview in
            let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)

            expect(view.anchored(to: .safeArea, with: insets),
                   toMatch: superview.safeAreaLayoutGuide,
                   withInsets: insets)
        }
    }

    func test_AnchoredApi_AnchoringToOtherWithInsets() {
        let view = UIView()
        let other = UIView()
        let insets = UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44)

        expect(view.anchored(to: other, with: insets), toMatch: other, withInsets: insets)
    }

    func test_AnchoredApi_AnchoringToLayoutGuideOfOtherWithInsets() {
        let view = UIView()
        let other = UIView()
        let insets = UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44)

        expect(view.anchored(to: .layoutMargins, of: other, with: insets),
               toMatch: other.layoutMarginsGuide,
               withInsets: insets)
    }


    // MARK: - Anchoring API

    func test_AnchoringApi_AnchoringOtherWithInsets() {
        let other = UIView()
        let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)

        expect(other, toMatch: UIView().anchoring(other, with: insets), withInsets: insets)
    }

    func test_AnchoringApi_AnchoringOtherToLayoutGuideWithInsets() {
        let other = UIView()
        let insets = UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44)

        expect(other,
               toMatch: UIView().anchoring(other, to: .safeArea, with: insets).safeAreaLayoutGuide,
               withInsets: insets)
    }
}
