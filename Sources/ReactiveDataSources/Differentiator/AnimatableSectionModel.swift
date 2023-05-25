//
//  AnimatableSectionModel.swift
//  RxDataSources
//
//  Created by Krunoslav Zaher on 1/10/16.
//  Copyright © 2016 Krunoslav Zaher. All rights reserved.
//

import Foundation

public struct AnimatableSectionModel<Section: Identifiable, ItemType: Identifiable & Equatable> {
    public var model: Section
    public var items: [Item]

    public init(model: Section, items: [ItemType]) {
        self.model = model
        self.items = items
    }
}

extension AnimatableSectionModel
    : AnimatableSectionModelType {
    public typealias Item = ItemType
    public typealias ID = Section.ID

    public var id: Section.ID {
        return model.id
    }

    public init(original: AnimatableSectionModel, items: [Item]) {
        self.model = original.model
        self.items = items
    }
    
    public var hashValue: Int {
        return self.model.id.hashValue
    }
}


extension AnimatableSectionModel
    : CustomStringConvertible {

    public var description: String {
        return "HashableSectionModel(model: \"\(self.model)\", items: \(items))"
    }

}

extension AnimatableSectionModel
    : Equatable where Section: Equatable {
    
    public static func == (lhs: AnimatableSectionModel, rhs: AnimatableSectionModel) -> Bool {
        return lhs.model == rhs.model
            && lhs.items == rhs.items
    }
}
