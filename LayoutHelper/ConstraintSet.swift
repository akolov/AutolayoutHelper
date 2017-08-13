//
//  Autolayout+ConstraintSet.swift
//  LayoutHelper
//
//  Created by Alexander Kolov on 8.8.2017.
//  Copyright © 2017 Alexander Kolov. All rights reserved.
//

import UIKit

public protocol ConstraintSet {

  @discardableResult
  func activate() -> Self

  @discardableResult
  func deactivate() -> Self

}

public struct ArrangedConstraintSet: ConstraintSet {

  @discardableResult
  public func activate() -> ArrangedConstraintSet {
    leading.forEach { $0.isActive = true }
    trailing.forEach { $0.isActive = true }
    top.forEach { $0.isActive = true }
    bottom.forEach { $0.isActive = true }
    chain.forEach { $0.isActive = true }
    return self
  }

  @discardableResult
  public func deactivate() -> ArrangedConstraintSet {
    leading.forEach { $0.isActive = false }
    trailing.forEach { $0.isActive = false }
    top.forEach { $0.isActive = false }
    bottom.forEach { $0.isActive = false }
    chain.forEach { $0.isActive = false }
    return self
  }

  public let leading: [NSLayoutConstraint]
  public let trailing: [NSLayoutConstraint]
  public let top: [NSLayoutConstraint]
  public let bottom: [NSLayoutConstraint]
  public let chain: [NSLayoutConstraint]

}

public struct AxialConstraintSet: ConstraintSet {

  @discardableResult
  public func activate() -> AxialConstraintSet {
    horizontal.isActive = true
    vertical.isActive = true
    return self
  }

  @discardableResult
  public func deactivate() -> AxialConstraintSet {
    horizontal.isActive = false
    vertical.isActive = false
    return self
  }

  public let horizontal: NSLayoutConstraint
  public let vertical: NSLayoutConstraint

}

public struct HorizontalFillConstraintSet: ConstraintSet {

  @discardableResult
  public func activate() -> HorizontalFillConstraintSet {
    leading.isActive = true
    trailing.isActive = true
    return self
  }

  @discardableResult
  public func deactivate() -> HorizontalFillConstraintSet {
    leading.isActive = false
    trailing.isActive = false
    return self
  }

  public let leading: NSLayoutConstraint
  public let trailing: NSLayoutConstraint
}

public struct VerticalFillConstraintSet {

  @discardableResult
  public func activate() -> VerticalFillConstraintSet {
    top.isActive = true
    bottom.isActive = true
    return self
  }

  @discardableResult
  public func deactivate() -> VerticalFillConstraintSet {
    top.isActive = false
    bottom.isActive = false
    return self
  }

  public let top: NSLayoutConstraint
  public let bottom: NSLayoutConstraint
}

public struct FillConstraintSet {

  @discardableResult
  public func activate() -> FillConstraintSet {
    horizontal.activate()
    vertical.activate()
    return self
  }

  @discardableResult
  public func deactivate() -> FillConstraintSet {
    horizontal.deactivate()
    vertical.deactivate()
    return self
  }

  public let horizontal: HorizontalFillConstraintSet
  public let vertical: VerticalFillConstraintSet

  public var top: NSLayoutConstraint {
    return vertical.top
  }

  public var leading: NSLayoutConstraint {
    return horizontal.leading
  }

  public var bottom: NSLayoutConstraint {
    return vertical.bottom
  }

  public var trailing: NSLayoutConstraint {
    return horizontal.trailing
  }

}
