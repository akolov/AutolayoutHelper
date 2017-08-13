//
//  Autolayout+Center.swift
//  LayoutHelper
//
//  Created by Alexander Kolov on 8.8.2017.
//  Copyright © 2017 Alexander Kolov. All rights reserved.
//

import UIKit

// MARK: Center in superview

extension Autolayout {

  @discardableResult
  public func center(offset: UIOffset = .zero, identifier: String? = nil) -> AxialConstraintSet {
    precondition(view.superview != nil, "Superview must not be nil")
    return center(parent: view.superview!, offset: offset)
  }

  @discardableResult
  public func centerHorizontally(offset: CGFloat = 0) -> NSLayoutConstraint {
    precondition(view.superview != nil, "Superview must not be nil")
    return centerHorizontally(parent: view.superview!, offset: offset)
  }

  @discardableResult
  public func centerVertically(offset: CGFloat = 0) -> NSLayoutConstraint {
    precondition(view.superview != nil, "Superview must not be nil")
    return centerVertically(parent: view.superview!, offset: offset)
  }

}

// MARK: Center in specified view

extension Autolayout {

  @discardableResult
  public func center(parent: UIView, offset: UIOffset = .zero, identifier: String? = nil) -> AxialConstraintSet {
    let _identifier = identifier.map { "(\($0))" } ?? ""
    let centerSet = AxialConstraintSet(
      horizontal: centerHorizontally(parent: parent, offset: offset.horizontal),
      vertical: centerVertically(parent: parent, offset: offset.vertical)
    )

    centerSet.horizontal.identifier = "center.x\(_identifier)"
    centerSet.vertical.identifier = "center.y\(_identifier)"

    return centerSet
  }

  @discardableResult
  public func centerHorizontally(parent: UIView, offset: CGFloat = 0, identifier: String? = nil) -> NSLayoutConstraint {
    let _identifier = identifier.map { "(\($0))" } ?? ""
    let constraint = view.centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: offset)
    constraint.identifier = "centerHorizontally\(_identifier)"
    constraint.isActive = true
    return constraint
  }

  @discardableResult
  public func centerVertically(parent: UIView, offset: CGFloat = 0, identifier: String? = nil) -> NSLayoutConstraint {
    let _identifier = identifier.map { "(\($0))" } ?? ""
    let constraint = view.centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: offset)
    constraint.identifier = "centerVertically\(_identifier)"
    constraint.isActive = true
    return constraint
  }

}
