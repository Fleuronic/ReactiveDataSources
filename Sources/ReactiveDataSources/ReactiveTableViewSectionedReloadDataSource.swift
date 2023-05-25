//
//  ReactiveTableViewSectionedReloadDataSource.swift
//  ReactiveDataSources
//
//  Created by Daniel Ostashev on 9/24/19.
//  Copyright © 2019 Cruxlab. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation
import UIKit

open class ReactiveTableViewSectionedReloadDataSource<Section: SectionModelType>
    : TableViewSectionedDataSource<Section>
    , ReactiveTableViewDataSourceType {
    public typealias Element = [Section]

    open func tableView(_ tableView: UITableView, observedElementChangedTo element: Element) {
        #if DEBUG
        _dataSourceBound = true
        #endif
        setSections(element)
        tableView.reloadData()
    }
}
#endif
