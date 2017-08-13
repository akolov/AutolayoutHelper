//
//  Autolayout+Fill.swift
//  LayoutHelper
//
//  Created by Alexander Kolov on 8.8.2017.
//  Copyright © 2017 Alexander Kolov. All rights reserved.
//

import UIKit

public extension Autolayout {

  @discardableResult
  public func fill(
    inside guides: Autolayout.Guides = .bounds,
    insets: UIEdgeInsets = .zero,
    priority: UILayoutPriority = UILayoutPriorityRequired,
    identifier: String? = nil
  ) -> FillConstraintSet {
    let _identifier = identifier.map { "(\($0))" } ?? ""

    let horizontalSet = fillHorizontally(
      inside: guides,
      leading: insets.left,
      trailing: insets.right,
      priority: priority
    )

    horizontalSet.leading.identifier = "fill.leading\(_identifier)"
    horizontalSet.trailing.identifier = "fill.trailing\(_identifier)"

    let verticalSet = fillVertically(inside: guides, top: insets.top, bottom: insets.bottom, priority: priority)
    verticalSet.top.identifier = "fill.top\(_identifier)"
    verticalSet.bottom.identifier = "fill.bottom\(_identifier)"

    return FillConstraintSet(horizontal: horizontalSet, vertical: verticalSet)
  }

  @discardableResult
  public func fillHorizontally(
    inside guides: Autolayout.Guides = .bounds,
    leading: CGFloat = 0,
    trailing: CGFloat = 0,
    priority: UILayoutPriority = UILayoutPriorityRequired,
    identifier: String? = nil
  ) -> HorizontalFillConstraintSet {
    let leadingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>
    let trailingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>

    switch guides {
    case .bounds:
      precondition(view.superview != nil, "Superview must not be nil")
      leadingAnchor = view.superview!.leadingAnchor
      trailingAnchor = view.superview!.trailingAnchor
    case .boundsOf(let parentView):
      leadingAnchor = parentView.leadingAnchor
      trailingAnchor = parentView.trailingAnchor
    case .margins:
      precondition(view.superview != nil, "Superview must not be nil")
      leadingAnchor = view.superview!.layoutMarginsGuide.leadingAnchor
      trailingAnchor = view.superview!.layoutMarginsGuide.trailingAnchor
    case .marginsOf(let parentView):
      leadingAnchor = parentView.layoutMarginsGuide.leadingAnchor
      trailingAnchor = parentView.layoutMarginsGuide.trailingAnchor
    }

    let _identifier = identifier.map { "(\($0))" } ?? ""

    let leadingConstraint = view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading)
    leadingConstraint.priority = priority
    leadingConstraint.identifier = "fillHorizontally.leading\(_identifier)"

    let trailingConstraint = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing)
    trailingConstraint.priority = priority
    trailingConstraint.identifier = "fillHorizontally.trailing\(_identifier)"

    return HorizontalFillConstraintSet(leading: leadingConstraint, trailing: trailingConstraint).activate()
  }

  @discardableResult
  public func fillVertically(
    inside guides: Autolayout.Guides = .bounds,
    top: CGFloat = 0,
    bottom: CGFloat = 0,
    priority: UILayoutPriority = UILayoutPriorityRequired,
    identifier: String? = nil
  ) -> VerticalFillConstraintSet {
    let topAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>
    let bottomAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>

    switch guides {
    case .bounds:
      precondition(view.superview != nil, "Superview must not be nil")
      topAnchor = view.superview!.topAnchor
      bottomAnchor = view.superview!.bottomAnchor
    case .boundsOf(let parentView):
      topAnchor = parentView.topAnchor
      bottomAnchor = parentView.bottomAnchor
    case .margins:
      precondition(view.superview != nil, "Superview must not be nil")
      topAnchor = view.superview!.layoutMarginsGuide.topAnchor
      bottomAnchor = view.superview!.layoutMarginsGuide.bottomAnchor
    case .marginsOf(let parentView):
      topAnchor = parentView.layoutMarginsGuide.topAnchor
      bottomAnchor = parentView.layoutMarginsGuide.bottomAnchor
    }

    let _identifier = identifier.map { "(\($0))" } ?? ""

    let topConstraint = view.topAnchor.constraint(equalTo: topAnchor, constant: top)
    topConstraint.priority = priority
    topConstraint.identifier = "fillVertically.top\(_identifier)"

    let bottomConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
    bottomConstraint.priority = priority
    bottomConstraint.identifier = "fillVertically.bottom\(_identifier)"

    return VerticalFillConstraintSet(top: topConstraint, bottom: bottomConstraint).activate()
  }

}
