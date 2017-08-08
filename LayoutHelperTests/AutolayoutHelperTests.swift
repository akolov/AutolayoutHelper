//
//  AutolayoutHelperTests.swift
//  AutolayoutHelperTests
//
//  Created by Alexander Kolov on 2/6/16.
//  Copyright © 2016 Alexander Kolov. All rights reserved.
//

import XCTest
@testable import AutolayoutHelper

class AutolayoutHelperTests: XCTestCase {

  func testSizeConstraints() {
    let view = UIView()
    let size = CGSize(width: 10, height: 20)
    let constraints = view.autolayout.size(to: size)

    let _horizontal = view.widthAnchor.constraint(equalToConstant: size.width)
    let _vertical = view.heightAnchor.constraint(equalToConstant: size.height)
    NSLayoutConstraint.activate([_horizontal, _vertical])

    XCTAssertEqual(view.constraints.count, 4)
    XCTAssertTrue(compareConstraint(constraints.horizontal, _horizontal))
    XCTAssertTrue(compareConstraint(constraints.vertical, _vertical))
  }

  func testFillConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let insets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
    let constraints = view.autolayout.fill(insets: insets)

    let _top = view.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top)
    let _leading = view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left)
    let _bottom = superview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)
    let _trailing = superview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right)
    NSLayoutConstraint.activate([_top, _leading, _bottom, _trailing])

    XCTAssertEqual(superview.constraints.count, 8)
    XCTAssertTrue(compareConstraint(constraints.top, _top))
    XCTAssertTrue(compareConstraint(constraints.leading, _leading))
    XCTAssertTrue(compareConstraint(constraints.bottom, _bottom))
    XCTAssertTrue(compareConstraint(constraints.trailing, _trailing))
  }

  func testFillMarginsConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let insets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
    let constraints = view.autolayout.fill(inside: .margins, insets: insets)
    let margins = superview.layoutMarginsGuide

    let _top = view.topAnchor.constraint(equalTo: margins.topAnchor, constant: insets.top)
    let _leading = view.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: insets.left)
    let _bottom = margins.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)
    let _trailing = margins.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right)
    NSLayoutConstraint.activate([_top, _leading, _bottom, _trailing])

    XCTAssertEqual(superview.constraints.count, 12)
    XCTAssertTrue(compareConstraint(constraints.top, _top))
    XCTAssertTrue(compareConstraint(constraints.leading, _leading))
    XCTAssertTrue(compareConstraint(constraints.bottom, _bottom))
    XCTAssertTrue(compareConstraint(constraints.trailing, _trailing))
  }

  func testFillHorizontallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let leading: CGFloat = 5
    let trailing: CGFloat = 10
    let constraints = view.autolayout.fillHorizontally(leading: leading, trailing: trailing)

    let _leading = view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading)
    let _trailing = superview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing)
    NSLayoutConstraint.activate([_leading, _trailing])

    XCTAssertEqual(superview.constraints.count, 4)
    XCTAssertTrue(compareConstraint(constraints.leading, _leading))
    XCTAssertTrue(compareConstraint(constraints.trailing, _trailing))
  }

  func testFillMarginsHorizontallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let leading: CGFloat = 5
    let trailing: CGFloat = 10
    let constraints = view.autolayout.fillHorizontally(inside: .margins, leading: leading, trailing: trailing)
    let margins = superview.layoutMarginsGuide

    let _leading = view.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: leading)
    let _trailing = margins.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing)
    NSLayoutConstraint.activate([_leading, _trailing])

    XCTAssertEqual(superview.constraints.count, 8)
    XCTAssertTrue(compareConstraint(constraints.leading, _leading))
    XCTAssertTrue(compareConstraint(constraints.trailing, _trailing))
  }

  func testFillVerticallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let top: CGFloat = 15
    let bottom: CGFloat = 20
    let constraints = view.autolayout.fillVertically(top: top, bottom: bottom)

    let _top = view.topAnchor.constraint(equalTo: superview.topAnchor, constant: top)
    let _bottom = superview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
    NSLayoutConstraint.activate([_top, _bottom])

    XCTAssertEqual(superview.constraints.count, 4)
    XCTAssertTrue(compareConstraint(constraints.top, _top))
    XCTAssertTrue(compareConstraint(constraints.bottom, _bottom))
  }

  func testFillMarginsVerticallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let top: CGFloat = 15
    let bottom: CGFloat = 20
    let constraints = view.autolayout.fillVertically(inside: .margins, top: top, bottom: bottom)
    let margins = superview.layoutMarginsGuide

    let _top = view.topAnchor.constraint(equalTo: margins.topAnchor, constant: top)
    let _bottom = margins.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
    NSLayoutConstraint.activate([_top, _bottom])

    XCTAssertEqual(superview.constraints.count, 8)
    XCTAssertTrue(compareConstraint(constraints.top, _top))
    XCTAssertTrue(compareConstraint(constraints.bottom, _bottom))
  }

  // MARK: Limit constraints

  func testLimitConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let insets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
    let constraints = view.autolayout.limit(insets: insets)

    let _top = view.topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor, constant: insets.top)
    let _leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: insets.left)
    let _bottom = superview.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: insets.bottom)
    let _trailing = superview.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: insets.right)
    NSLayoutConstraint.activate([_top, _leading, _bottom, _trailing])

    XCTAssertEqual(superview.constraints.count, 8)
    XCTAssertTrue(compareConstraint(constraints.top, _top))
    XCTAssertTrue(compareConstraint(constraints.leading, _leading))
    XCTAssertTrue(compareConstraint(constraints.bottom, _bottom))
    XCTAssertTrue(compareConstraint(constraints.trailing, _trailing))
  }

  func testLimitMarginsConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let insets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
    let constraints = view.autolayout.limit(inside: .margins, insets: insets)
    let margins = superview.layoutMarginsGuide

    let _top = view.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor, constant: insets.top)
    let _leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: margins.leadingAnchor, constant: insets.left)
    let _bottom = margins.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: insets.bottom)
    let _trailing = margins.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: insets.right)
    NSLayoutConstraint.activate([_top, _leading, _bottom, _trailing])

    XCTAssertEqual(superview.constraints.count, 12)
    XCTAssertTrue(compareConstraint(constraints.top, _top))
    XCTAssertTrue(compareConstraint(constraints.leading, _leading))
    XCTAssertTrue(compareConstraint(constraints.bottom, _bottom))
    XCTAssertTrue(compareConstraint(constraints.trailing, _trailing))
  }

  func testLimitHorizontallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let left: CGFloat = 5
    let right: CGFloat = 10
    let constraints = view.autolayout.limitHorizontally(leading: left, trailing: right)

    let _leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: left)
    let _trailing = superview.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: right)
    NSLayoutConstraint.activate([_leading, _trailing])

    XCTAssertEqual(superview.constraints.count, 4)
    XCTAssertTrue(compareConstraint(constraints.leading, _leading))
    XCTAssertTrue(compareConstraint(constraints.trailing, _trailing))
  }

  func testLimitMarginsHorizontallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let left: CGFloat = 5
    let right: CGFloat = 10
    let constraints = view.autolayout.limitHorizontally(inside: .margins, leading: left, trailing: right)
    let margins = superview.layoutMarginsGuide

    let _leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: margins.leadingAnchor, constant: left)
    let _trailing = margins.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: right)
    NSLayoutConstraint.activate([_leading, _trailing])

    XCTAssertEqual(superview.constraints.count, 8)
    XCTAssertTrue(compareConstraint(constraints.leading, _leading))
    XCTAssertTrue(compareConstraint(constraints.trailing, _trailing))
  }

  func testLimitVerticallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let top: CGFloat = 15
    let bottom: CGFloat = 20
    let constraints = view.autolayout.limitVertically(top: top, bottom: bottom)

    let _top = view.topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor, constant: top)
    let _bottom = superview.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: bottom)
    NSLayoutConstraint.activate([_top, _bottom])

    XCTAssertEqual(superview.constraints.count, 4)
    XCTAssertTrue(compareConstraint(constraints.top, _top))
    XCTAssertTrue(compareConstraint(constraints.bottom, _bottom))
  }

  func testLimitMarginsVerticallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let top: CGFloat = 15
    let bottom: CGFloat = 20
    let constraints = view.autolayout.limitVertically(inside: .margins, top: top, bottom: bottom)
    let margins = superview.layoutMarginsGuide

    let _top = view.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor, constant: top)
    let _bottom = margins.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: bottom)
    NSLayoutConstraint.activate([_top, _bottom])

    XCTAssertEqual(superview.constraints.count, 8)
    XCTAssertTrue(compareConstraint(constraints.top, _top))
    XCTAssertTrue(compareConstraint(constraints.bottom, _bottom))
  }

  // MARK: Centering

  func testCentering() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let offset = UIOffset(horizontal: 5, vertical: 10)
    let constraints = view.autolayout.center(offset: offset)

    let _centerX = view.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offset.horizontal)
    let _centerY = view.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offset.vertical)
    NSLayoutConstraint.activate([_centerX, _centerY])

    XCTAssertEqual(superview.constraints.count, 4)
    XCTAssertTrue(compareConstraint(constraints.horizontal, _centerX))
    XCTAssertTrue(compareConstraint(constraints.vertical, _centerY))
  }

  func testCenteringHorizontally() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let constant: CGFloat = 5
    let constraint = view.autolayout.centerHorizontally(offset: constant)

    let _centerX = view.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant)
    _centerX.isActive = true

    XCTAssertEqual(superview.constraints.count, 2)
    XCTAssertTrue(compareConstraint(constraint, _centerX))
  }

  func testCenteringVertically() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let constant: CGFloat = 10
    let constraint = view.autolayout.centerVertically(offset: constant)

    let _centerY = view.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant)
    _centerY.isActive = true

    XCTAssertEqual(superview.constraints.count, 2)
    XCTAssertTrue(compareConstraint(constraint, _centerY))
  }

  // MARK: Deactivation

  func testConstraintDeactivation() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let constraints = view.autolayout.center().deactivate()
    let _centerX = view.centerXAnchor.constraint(equalTo: superview.centerXAnchor)
    let _centerY = view.centerYAnchor.constraint(equalTo: superview.centerYAnchor)

    XCTAssertEqual(superview.constraints.count, 0)
    XCTAssertTrue(compareConstraint(constraints.horizontal, _centerX))
    XCTAssertTrue(compareConstraint(constraints.vertical, _centerY))
  }

  // MARK: Helpers

  fileprivate func compareConstraint(_ lhs: NSLayoutConstraint, _ rhs: NSLayoutConstraint) -> Bool {
    return lhs.priority == rhs.priority
    && lhs.isActive == rhs.isActive
    && lhs.firstItem === rhs.firstItem
    && lhs.firstAttribute == rhs.firstAttribute
    && lhs.relation == rhs.relation
    && lhs.secondItem === rhs.secondItem
    && lhs.secondAttribute == rhs.secondAttribute
    && lhs.multiplier == rhs.multiplier
    && lhs.constant == rhs.constant
    && lhs.shouldBeArchived == rhs.shouldBeArchived
  }

}
