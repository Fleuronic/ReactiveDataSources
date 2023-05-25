//
//  s.swift
//  RxDataSources
//
//  Created by Krunoslav Zaher on 11/26/16.
//  Copyright © 2016 kzaher. All rights reserved.
//

import Foundation
import ReactiveDataSources

/**
 Test section. Name is so short for readability sake.
 */
struct s {
    let id: Int
    let items: [i]
}

extension s {
    init(_ id: Int, _ items: [i]) {
        self.id = id
        self.items = items
    }
}

extension s: AnimatableSectionModelType {
    typealias Item = i

    init(original: s, items: [Item]) {
        self.id = original.id
        self.items = items
    }
}

extension s: Equatable {
    
}

func == (lhs: s, rhs: s) -> Bool {
    return lhs.id == rhs.id && lhs.items == rhs.items
}

extension s: CustomDebugStringConvertible {
    var debugDescription: String {
        let itemDescriptions = items.map { "\n    \($0)," }.joined(separator: "")
        return "s(\(id),\(itemDescriptions)\n)"
    }
}

struct sInvalidInitializerImplementation1 {
    let id: Int
    let items: [i]

    init(_ id: Int, _ items: [i]) {
        self.id = id
        self.items = items
    }
}

func == (lhs: sInvalidInitializerImplementation1, rhs: sInvalidInitializerImplementation1) -> Bool {
    return lhs.id == rhs.id && lhs.items == rhs.items
}

extension sInvalidInitializerImplementation1: AnimatableSectionModelType, Equatable {
    typealias Item = i

    init(original: sInvalidInitializerImplementation1, items: [Item]) {
        self.id = original.id
        self.items = items + items
    }
}

struct sInvalidInitializerImplementation2 {
    let id: Int
    let items: [i]

    init(_ id: Int, _ items: [i]) {
        self.id = id
        self.items = items
    }
}

extension sInvalidInitializerImplementation2: AnimatableSectionModelType, Equatable {
    typealias Item = i

    init(original: sInvalidInitializerImplementation2, items: [Item]) {
        self.id = -1
        self.items = items
    }
}

func == (lhs: sInvalidInitializerImplementation2, rhs: sInvalidInitializerImplementation2) -> Bool {
    return lhs.id == rhs.id && lhs.items == rhs.items
}
