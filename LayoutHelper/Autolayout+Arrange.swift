//
//  Autolayout+Arrange.swift
//  AutolayoutHelper
//
//  Created by Alexander Kolov on 13.8.2017.
//  Copyright © 2017 Alexander Kolov. All rights reserved.
//

import UIKit

public extension Autolayout {

  public func addArrangedSubviews(
    _ subviews: [UIView],
    axis: UILayoutConstraintAxis,
    guides: SuperviewGuides = .bounds,
    spacing: CGFloat = 0,
    insets: UIEdgeInsets = .zero,
    priority: UILayoutPriority = .required
  ) -> ArrangedConstraintSet {
    switch axis {
    case .horizontal:
      return addHorizontallyArrangedSubviews(subviews, guides: guides, spacing: spacing, insets: insets)
    case .vertical:
      return addHorizontallyArrangedSubviews(subviews, guides: guides, spacing: spacing, insets: insets)
    }
  }

  private func addHorizontallyArrangedSubviews(
    _ subviews: [UIView],
    guides: SuperviewGuides,
    spacing: CGFloat = 0,
    insets: UIEdgeInsets = .zero,
    priority: UILayoutPriority = .required
  ) -> ArrangedConstraintSet {
    var leadingConstraints = [NSLayoutConstraint]()
    if let first = subviews.first {
      view.addSubview(first)

      let leadingAnchor: NSLayoutXAxisAnchor
      switch guides {
      case .bounds:
        leadingAnchor = view.leadingAnchor
      case .margins:
        leadingAnchor = view.layoutMarginsGuide.leadingAnchor
      }

      let constraint = first.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left)
      constraint.identifier = "arrangedSubviews.leading"
      constraint.priority = priority
      constraint.isActive = true
      leadingConstraints.append(constraint)
    }

    var trailingConstraints = [NSLayoutConstraint]()
    if let last = subviews.last {
      view.addSubview(last)

      let trailingAnchor: NSLayoutXAxisAnchor
      switch guides {
      case .bounds:
        trailingAnchor = view.trailingAnchor
      case .margins:
        trailingAnchor = view.layoutMarginsGuide.trailingAnchor
      }

      let constraint = trailingAnchor.constraint(equalTo: last.trailingAnchor, constant: insets.right)
      constraint.identifier = "arrangedSubviews.trailing"
      constraint.priority = priority
      constraint.isActive = true
      trailingConstraints.append(constraint)
    }

    var chainConstraints = [NSLayoutConstraint]()
    if subviews.count > 1 {
      for i in 1..<subviews.count {
        let leading = subviews[i]
        let trailing = subviews[i - 1]
        view.addSubview(leading)
        let constraint = leading.leadingAnchor.constraint(equalTo: trailing.trailingAnchor, constant: spacing)
        constraint.identifier = "arrangedSubviews.chaining"
        constraint.priority = priority
        constraint.isActive = true
        chainConstraints.append(constraint)
      }
    }

    var topConstraints = [NSLayoutConstraint]()
    var bottomConstraints = [NSLayoutConstraint]()
    for view in subviews {
      let constraintSet = view.autolayout.fillVertically(
        inside: Guides(superviewGuides: guides),
        top: insets.top,
        bottom: insets.bottom,
        priority: priority
      )

      constraintSet.top.identifier = "arrangedSubviews.top"
      constraintSet.bottom.identifier = "arrangedSubviews.bottom"

      topConstraints.append(constraintSet.top)
      bottomConstraints.append(constraintSet.bottom)
    }

    return ArrangedConstraintSet(
      leading: leadingConstraints,
      trailing: trailingConstraints,
      top: topConstraints,
      bottom: bottomConstraints,
      chain: chainConstraints
    )
  }

  private func addVerticallyArrangedSubviews(
    _ subviews: [UIView],
    guides: SuperviewGuides,
    spacing: CGFloat = 0,
    insets: UIEdgeInsets = .zero,
    priority: UILayoutPriority = .required
  ) -> ArrangedConstraintSet {
    var topConstraints = [NSLayoutConstraint]()
    if let first = subviews.first {
      view.addSubview(first)

      let topAnchor: NSLayoutYAxisAnchor
      switch guides {
      case .bounds:
        topAnchor = view.topAnchor
      case .margins:
        topAnchor = view.layoutMarginsGuide.topAnchor
      }

      let constraint = first.topAnchor.constraint(equalTo: topAnchor, constant: insets.left)
      constraint.identifier = "arrangedSubviews.top"
      constraint.priority = priority
      constraint.isActive = true
      topConstraints.append(constraint)
    }

    var bottomConstraints = [NSLayoutConstraint]()
    if let last = subviews.last {
      view.addSubview(last)

      let bottomAnchor: NSLayoutYAxisAnchor
      switch guides {
      case .bounds:
        bottomAnchor = view.bottomAnchor
      case .margins:
        bottomAnchor = view.layoutMarginsGuide.bottomAnchor
      }

      let constraint = bottomAnchor.constraint(equalTo: last.bottomAnchor, constant: insets.right)
      constraint.identifier = "arrangedSubviews.bottom"
      constraint.priority = priority
      constraint.isActive = true
      bottomConstraints.append(constraint)
    }

    var chainConstraints = [NSLayoutConstraint]()
    if subviews.count > 1 {
      for i in 1..<subviews.count {
        let top = subviews[i]
        let bottom = subviews[i - 1]
        view.addSubview(top)
        let constraint = top.bottomAnchor.constraint(equalTo: bottom.topAnchor, constant: spacing)
        constraint.identifier = "arrangedSubviews.chaining"
        constraint.priority = priority
        constraint.isActive = true
        chainConstraints.append(constraint)
      }
    }

    var leadingConstraints = [NSLayoutConstraint]()
    var trailingConstraints = [NSLayoutConstraint]()
    for view in subviews {
      let constraintSet = view.autolayout.fillHorizontally(
        inside: Guides(superviewGuides: guides),
        leading: insets.top,
        trailing: insets.bottom,
        priority: priority
      )

      constraintSet.leading.identifier = "arrangedSubviews.leading"
      constraintSet.trailing.identifier = "arrangedSubviews.trailing"

      leadingConstraints.append(constraintSet.leading)
      trailingConstraints.append(constraintSet.trailing)
    }

    return ArrangedConstraintSet(
      leading: leadingConstraints,
      trailing: trailingConstraints,
      top: topConstraints,
      bottom: bottomConstraints,
      chain: chainConstraints
    )
  }

}
