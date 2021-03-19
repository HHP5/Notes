//
//  AlertActionExtension.swift
//  Notes
//
//  Created by Екатерина Григорьева on 18.03.2021.
//

import Foundation
import UIKit

extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
