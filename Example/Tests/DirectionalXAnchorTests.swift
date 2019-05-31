//  Copyright (c) 2019 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class DirectionalXAnchorTests: XCTestCase {

    // MARK: - Anchor API

    func test_AnchorApi_AllCombinationsOfDirectionalXAnchors() {
        UIView.DirectionalXAnchor
            .allCombinations { anchor, otherAnchor in

                siblings { view, otherView in

                    view.anchor(anchor, to: otherAnchor, of: otherView)

                    expect(anchor.layoutAttribute, of: view, toMatch: otherAnchor.layoutAttribute, of: otherView)
                }
        }
    }

    // MARK: - Anchoring API

    func test_AnchoringApi_AllCombinationsOfDirectionalXAnchors() {
        UIView.DirectionalXAnchor
            .allCombinations { anchor, otherAnchor in

                siblings { view, otherView in

                    expect(anchor.layoutAttribute,
                           of: view.anchoring(anchor, to: otherAnchor, of: otherView),
                           toMatch: otherAnchor.layoutAttribute,
                           of: otherView)
                }
        }
    }
}
