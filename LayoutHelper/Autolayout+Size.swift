//
//  Autolayout+Size.swift
//  LayoutHelper
//
//  Created by Alexander Kolov on 8.8.2017.
//  Copyright © 2017 Alexander Kolov. All rights reserved.
//

import UIKit

public extension Autolayout {

  @discardableResult
  public func aspectRatio(
    ratio: CGFloat,
    priority: UILayoutPriority = UILayoutPriorityRequired,
    identifier: String? = nil
  ) -> NSLayoutConstraint {
    let _identifier = identifier.map { "(\($0))" } ?? ""
    let constraint = view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: ratio)
    constraint.priority = priority
    constraint.identifier = "aspectRatio\(_identifier)"
    constraint.isActive = true
    return constraint
  }

  @discardableResult
  public func size(
    to size: CGSize,
    priority: UILayoutPriority = UILayoutPriorityRequired,
    identifier: String? = nil
  ) -> AxialConstraintSet {
    let sizeSet = AxialConstraintSet(
      horizontal: width(to: size.width, priority: priority),
      vertical: height(to: size.height, priority: priority)
    )

    let _identifier = identifier.map { "(\($0))" } ?? ""
    sizeSet.horizontal.identifier = "size.width\(_identifier)"
    sizeSet.vertical.identifier = "size.height\(_identifier)"

    return sizeSet
  }

  @discardableResult
  public func width(
    to constant: CGFloat,
    priority: UILayoutPriority = UILayoutPriorityRequired,
    identifier: String? = nil
  ) -> NSLayoutConstraint {
    let _identifier = identifier.map { "(\($0))" } ?? ""
    let constraint = view.widthAnchor.constraint(equalToConstant: constant)
    constraint.priority = priority
    constraint.identifier = "width\(_identifier)"
    constraint.isActive = true
    return constraint
  }

  @discardableResult
  public func height(
    to constant: CGFloat,
    priority: UILayoutPriority = UILayoutPriorityRequired,
    identifier: String? = nil
  ) -> NSLayoutConstraint {
    let _identifier = identifier.map { "(\($0))" } ?? ""
    let constraint = view.heightAnchor.constraint(equalToConstant: constant)
    constraint.priority = priority
    constraint.identifier = "height\(_identifier)"
    constraint.isActive = true
    return constraint
  }

}
