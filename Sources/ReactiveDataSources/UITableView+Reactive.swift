//
//  UITableView+Reactive.swift
//  ReactiveDataSources
//
//  Created by Daniel Ostashev on 9/25/19.
//  Copyright © 2019 Cruxlab. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

extension Reactive where Base: UITableView {
    public func items<DataSource: ReactiveTableViewDataSourceType & UITableViewDataSource>
        (dataSource: DataSource)
        -> BindingTarget<DataSource.Element> {
        return makeBindingTarget { base, element in
            dataSource.tableView(base, observedElementChangedTo: element)
        }
    }
}
