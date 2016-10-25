//
//  LayoutHelperTests.swift
//  LayoutHelperTests
//
//  Created by Alexander Kolov on 2/6/16.
//  Copyright © 2016 Alexander Kolov. All rights reserved.
//

import XCTest
@testable import LayoutHelper

class LayoutHelperTests: XCTestCase {

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testSizeConstraints() {
    let view = UIView()
    let size = CGSize(width: 10, height: 20)
    let priority: UILayoutPriority = 788
    let constraints = view.autolayout.constrained(to: size, priority: 788)

    let _width = view.widthAnchor.constraint(equalToConstant: size.width)
    let _height = view.heightAnchor.constraint(equalToConstant: size.height)
    let _constraints = [_width, _height]
    _constraints.forEach { $0.priority = priority }

    NSLayoutConstraint.activate(_constraints)

    XCTAssertTrue(compareConstraint(constraints[.width]!, _width))
    XCTAssertTrue(compareConstraint(constraints[.height]!, _height))
  }

  func testFillConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let priority: UILayoutPriority = 445
    let edges = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
    let constraints = view.autolayout.fill(to: edges, priority: priority)

    let _top = view.topAnchor.constraint(equalTo: superview.topAnchor, constant: edges.top)
    let _leading = view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: edges.left)
    let _bottom = superview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: edges.bottom)
    let _trailing = superview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: edges.right)
    let _constraints = [_top, _leading, _bottom, _trailing]
    _constraints.forEach { $0.priority = priority }

    NSLayoutConstraint.activate(_constraints)

    XCTAssertTrue(compareConstraint(constraints[.top]!, _top))
    XCTAssertTrue(compareConstraint(constraints[.leading]!, _leading))
    XCTAssertTrue(compareConstraint(constraints[.bottom]!, _bottom))
    XCTAssertTrue(compareConstraint(constraints[.trailing]!, _trailing))
  }

  func testFillMarginsConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let priority: UILayoutPriority = 389
    let insets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
    let constraints = view.autolayout.fill(to: insets, margins: true, priority: priority)
    let margins = superview.layoutMarginsGuide

    let _top = view.topAnchor.constraint(equalTo: margins.topAnchor, constant: insets.top)
    let _leading = view.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: insets.left)
    let _bottom = margins.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)
    let _trailing = margins.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right)
    let _constraints = [_top, _leading, _bottom, _trailing]
    _constraints.forEach { $0.priority = priority }

    NSLayoutConstraint.activate(_constraints)

    XCTAssertTrue(compareConstraint(constraints[.top]!, _top))
    XCTAssertTrue(compareConstraint(constraints[.leading]!, _leading))
    XCTAssertTrue(compareConstraint(constraints[.bottom]!, _bottom))
    XCTAssertTrue(compareConstraint(constraints[.trailing]!, _trailing))
  }

  func testFillHorizontallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let priority: UILayoutPriority = 999
    let leading: CGFloat = 5
    let trailing: CGFloat = 10
    let constraints = view.autolayout.fillHorizontally(leading: leading, trailing: trailing, priority: priority)

    let _leading = view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading)
    let _trailing = superview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing)
    let _constraints = [_leading, _trailing]
    _constraints.forEach { $0.priority = priority }

    NSLayoutConstraint.activate(_constraints)

    XCTAssertTrue(compareConstraint(constraints[.leading]!, _leading))
    XCTAssertTrue(compareConstraint(constraints[.trailing]!, _trailing))
  }

  func testFillMarginsHorizontallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let priority = UILayoutPriorityDefaultLow
    let leading: CGFloat = 5
    let trailing: CGFloat = 10
    let constraints = view.autolayout.fillHorizontally(leading: leading, trailing: trailing, margins: true, priority: priority)
    let margins = superview.layoutMarginsGuide

    let _leading = view.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: leading)
    let _trailing = margins.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing)
    let _constraints = [_leading, _trailing]
    _constraints.forEach { $0.priority = priority }

    NSLayoutConstraint.activate(_constraints)

    XCTAssertTrue(compareConstraint(constraints[.leading]!, _leading))
    XCTAssertTrue(compareConstraint(constraints[.trailing]!, _trailing))
  }

  func testFillVerticallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let priority = UILayoutPriorityDefaultHigh
    let top: CGFloat = 15
    let bottom: CGFloat = 20
    let constraints = view.autolayout.fillVertically(top: top, bottom: bottom, priority: priority)

    let _top = view.topAnchor.constraint(equalTo: superview.topAnchor, constant: top)
    let _bottom = superview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
    let _constraints = [_top, _bottom]
    _constraints.forEach { $0.priority = priority }

    NSLayoutConstraint.activate(_constraints)

    XCTAssertTrue(compareConstraint(constraints[.top]!, _top))
    XCTAssertTrue(compareConstraint(constraints[.bottom]!, _bottom))
  }

  func testFillMarginsVerticallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let priority = UILayoutPriorityRequired
    let top: CGFloat = 15
    let bottom: CGFloat = 20
    let constraints = view.autolayout.fillVertically(top: top, bottom: bottom, margins: true, priority: priority)
    let margins = superview.layoutMarginsGuide

    let _top = view.topAnchor.constraint(equalTo: margins.topAnchor, constant: top)
    let _bottom = margins.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
    let _constraints = [_top, _bottom]
    _constraints.forEach { $0.priority = priority }

    NSLayoutConstraint.activate(_constraints)

    XCTAssertTrue(compareConstraint(constraints[.top]!, _top))
    XCTAssertTrue(compareConstraint(constraints[.bottom]!, _bottom))
  }

  // MARK: Limit constraints

  func testLimitConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let priority = UILayoutPriorityFittingSizeLevel
    let insets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
    let constraints = view.autolayout.limit(to: insets, priority: priority)

    let _top = view.topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor, constant: insets.top)
    let _leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: insets.left)
    let _bottom = superview.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: insets.bottom)
    let _trailing = superview.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: insets.right)
    let _constraints = [_top, _leading, _bottom, _trailing]
    _constraints.forEach { $0.priority = priority }

    NSLayoutConstraint.activate(_constraints)

    XCTAssertTrue(compareConstraint(constraints[.top]!, _top))
    XCTAssertTrue(compareConstraint(constraints[.leading]!, _leading))
    XCTAssertTrue(compareConstraint(constraints[.bottom]!, _bottom))
    XCTAssertTrue(compareConstraint(constraints[.trailing]!, _trailing))
  }

  func testLimitMarginsConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let priority: UILayoutPriority = 100
    let insets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
    let constraints = view.autolayout.limit(to: insets, margins: true, priority: priority)
    let margins = superview.layoutMarginsGuide

    let _top = view.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor, constant: insets.top)
    let _leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: margins.leadingAnchor, constant: insets.left)
    let _bottom = margins.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: insets.bottom)
    let _trailing = margins.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: insets.right)
    let _constraints = [_top, _leading, _bottom, _trailing]
    _constraints.forEach { $0.priority = priority }

    NSLayoutConstraint.activate(_constraints)

    XCTAssertTrue(compareConstraint(constraints[.top]!, _top))
    XCTAssertTrue(compareConstraint(constraints[.leading]!, _leading))
    XCTAssertTrue(compareConstraint(constraints[.bottom]!, _bottom))
    XCTAssertTrue(compareConstraint(constraints[.trailing]!, _trailing))
  }

  func testLimitHorizontallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let priority = UILayoutPriorityRequired
    let left: CGFloat = 5
    let right: CGFloat = 10
    let constraints = view.autolayout.limitHorizontally(leading: left, trailing: right)

    let _leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: left)
    let _trailing = superview.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: right)
    let _constraints = [_leading, _trailing]
    _constraints.forEach { $0.priority = priority }

    NSLayoutConstraint.activate(_constraints)

    XCTAssertTrue(compareConstraint(constraints[.leading]!, _leading))
    XCTAssertTrue(compareConstraint(constraints[.trailing]!, _trailing))
  }

  func testLimitMarginsHorizontallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let left: CGFloat = 5
    let right: CGFloat = 10
    let constraints = view.autolayout.limitHorizontally(leading: left, trailing: right, margins: true)
    let margins = superview.layoutMarginsGuide

    let _leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: margins.leadingAnchor, constant: left)
    let _trailing = margins.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: right)
    NSLayoutConstraint.activate([_leading, _trailing])

    XCTAssertTrue(compareConstraint(constraints[.leading]!, _leading))
    XCTAssertTrue(compareConstraint(constraints[.trailing]!, _trailing))
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

    XCTAssertTrue(compareConstraint(constraints[.top]!, _top))
    XCTAssertTrue(compareConstraint(constraints[.bottom]!, _bottom))
  }

  func testLimitMarginsVerticallyConstraints() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let top: CGFloat = 15
    let bottom: CGFloat = 20
    let constraints = view.autolayout.limitVertically(top: top, bottom: bottom, margins: true)
    let margins = superview.layoutMarginsGuide

    let _top = view.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor, constant: top)
    let _bottom = margins.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: bottom)
    NSLayoutConstraint.activate([_top, _bottom])

    XCTAssertTrue(compareConstraint(constraints[.top]!, _top))
    XCTAssertTrue(compareConstraint(constraints[.bottom]!, _bottom))
  }

  // MARK: Centering

  func testCentering() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let offset = CGPoint(x: 5, y: 10)
    let constraints = view.autolayout.center(with: offset)

    let _centerX = view.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offset.x)
    let _centerY = view.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offset.y)
    NSLayoutConstraint.activate([_centerX, _centerY])

    XCTAssertTrue(compareConstraint(constraints[.centerX]!, _centerX))
    XCTAssertTrue(compareConstraint(constraints[.centerY]!, _centerY))
  }

  func testCenteringHorizontally() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let constant: CGFloat = 5
    let constraints = view.autolayout.centerHorizontally(with: constant)

    let _centerX = view.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant)
    _centerX.isActive = true

    XCTAssertTrue(compareConstraint(constraints[.centerX]!, _centerX))
  }

  func testCenteringVertically() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let constant: CGFloat = 10
    let constraints = view.autolayout.centerVertically(with: constant)

    let _centerY = view.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant)
    _centerY.isActive = true

    XCTAssertTrue(compareConstraint(constraints[.centerY]!, _centerY))
  }

  // MARK: Deactivation

  func testConstraintDeactivation() {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)

    let constraints = view.autolayout.centerHorizontally().deactivate()
    let _centerX = view.centerXAnchor.constraint(equalTo: superview.centerXAnchor)

    XCTAssertTrue(compareConstraint(constraints[.centerX]!, _centerX))
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
    && lhs.identifier == rhs.identifier
    && lhs.shouldBeArchived == rhs.shouldBeArchived
  }

}
