//
//  i.swift
//  RxDataSources
//
//  Created by Krunoslav Zaher on 11/26/16.
//  Copyright © 2016 kzaher. All rights reserved.
//

import Foundation
import ReactiveDataSources

struct i {
    let id: Int
    let value: String

    init(_ id: Int, _ value: String) {
        self.id = id
        self.value = value
    }
}

extension i: Identifiable, Equatable {
}

func == (lhs: i, rhs: i) -> Bool {
    return lhs.id == rhs.id && lhs.value == rhs.value
}

extension i: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "i(\(id), \(value))"
    }
}
