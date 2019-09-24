//
//  SectionedViewDataSourceType.swift
//  ReactiveDataSources
//
//  Created by Daniel Ostashev on 9/24/19.
//  Copyright © 2019 Cruxlab. All rights reserved.
//

import struct Foundation.IndexPath

/// Data source with access to underlying sectioned model.
public protocol SectionedViewDataSourceType {
    /// Returns model at index path.

    /// - parameter indexPath: Model index path
    /// - returns: Model at index path.
    func model(at indexPath: IndexPath) throws -> Any
}
