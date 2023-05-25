//
//  String+Identifiable.swift
//  RxDataSources
//
//  Created by Krunoslav Zaher on 7/4/16.
//  Copyright © 2016 Krunoslav Zaher. All rights reserved.
//

import Foundation

extension String : Identifiable {
    public typealias ID = String

    public var id: String {
        return self
    }
}
