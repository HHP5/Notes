//
//  RealmExtension.swift
//  Notes
//
//  Created by Екатерина Григорьева on 16.03.2021.
//

import Foundation
import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
