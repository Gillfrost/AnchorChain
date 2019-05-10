//  Copyright (c) 2019 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class RelationTests: XCTestCase {

    // MARK: - Anhor API

    func testAnchorApi_XAnchoringWithRelation() {
        NSLayoutConstraint.Relation.all.forEach { relation in
            siblings { one, two in

                let constraint = one.anchor(.left, relation, to: .right, of: two)

                XCTAssertEqual(constraint.relation, relation)
            }
        }
    }

    func testAnchorApi_YAnchoringWithRelation() {
        NSLayoutConstraint.Relation.all.forEach { relation in
            siblings { one, two in

                let constraint = one.anchor(.top, relation, to: .bottom, of: two)

                XCTAssertEqual(constraint.relation, relation)
            }
        }
    }

    func testAnchorApi_DimensionalAnchoringWithRelation() {
        NSLayoutConstraint.Relation.all.forEach { relation in

            let constraint = UIView().anchor(.height, relation, to: 123)

            XCTAssertEqual(constraint.relation, relation)
        }
    }

    func testAnchorApi_DimensionalAnchoringToOtherWithRelation() {
        NSLayoutConstraint.Relation.all.forEach { relation in
            siblings { one, two in

                let constraint = one.anchor(.width, relation, to: .height, of: two)

                XCTAssertEqual(constraint.relation, relation)
            }
        }
    }

    // MARK: - Anchoring API

    func testAnchoringApi_XAnchoringWithRelation() throws {
        try NSLayoutConstraint.Relation.all.forEach { relation in
            try siblings { one, two in

                let constraint = try one.anchoring(.left, relation, to: .right, of: two)
                    .superview?
                    .constraints
                    .onlyElement()

                XCTAssertEqual(constraint?.relation, relation)
            }
        }
    }

    func testAnchoringApi_YAnchoringWithRelation() throws {
        try NSLayoutConstraint.Relation.all.forEach { relation in
            try siblings { one, two in

                let constraint = try one.anchoring(.top, relation, to: .bottom, of: two)
                    .superview?
                    .constraints
                    .onlyElement()

                XCTAssertEqual(constraint?.relation, relation)
            }
        }
    }

    func testAnchoringApi_DimensionalAnchoringWithRelation() throws {
        try NSLayoutConstraint.Relation.all.forEach { relation in

            let constraint = try UIView().anchoring(.height, relation, to: 123)
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint.relation, relation)
        }
    }
}
