//
//  UIView+Autolayout.swift
//  LayoutHelper
//
//  Created by Alexander Kolov on 8.8.2017.
//  Copyright © 2017 Alexander Kolov. All rights reserved.
//

import UIKit

extension UIView {

  public var autolayout: Autolayout {
    return Autolayout(view: self)
  }

}
