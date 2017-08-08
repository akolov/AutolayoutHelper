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
  public func size(to size: CGSize) -> AxialConstraintSet {
    return AxialConstraintSet(
      horizontal: view.widthAnchor.constraint(equalToConstant: size.width),
      vertical: view.heightAnchor.constraint(equalToConstant: size.height)
    ).activate()
  }

}
