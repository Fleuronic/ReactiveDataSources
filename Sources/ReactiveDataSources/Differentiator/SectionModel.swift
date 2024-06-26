//
//  SectionModel.swift
//  RxDataSources
//
//  Created by Krunoslav Zaher on 6/16/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation

public struct SectionModel<Section, ItemType> {
    public var model: Section
    public var items: [Item]

    public init(model: Section, items: [Item]) {
        self.model = model
        self.items = items
    }
}

extension SectionModel
    : SectionModelType {
    public typealias ID = Section
    public typealias Item = ItemType
    
    public var id: Section {
        return model
    }
}

extension SectionModel
    : CustomStringConvertible {

    public var description: String {
        return "\(self.model) > \(items)"
    }
}

extension SectionModel {
    public init(original: SectionModel<Section, Item>, items: [Item]) {
        self.model = original.model
        self.items = items
    }
}

extension SectionModel
    : Equatable where Section: Equatable, ItemType: Equatable {
    
    public static func == (lhs: SectionModel, rhs: SectionModel) -> Bool {
        return lhs.model == rhs.model
            && lhs.items == rhs.items
    }
}
