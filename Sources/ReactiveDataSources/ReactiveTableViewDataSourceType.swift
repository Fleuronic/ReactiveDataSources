//
//  ReactiveTableViewDataSourceType.swift
//  ReactiveDataSources
//
//  Created by Daniel Ostashev on 9/24/19.
//  Copyright © 2019 Cruxlab. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit
import ReactiveSwift
import ReactiveCocoa

/// Marks data source as `UITableView` reactive data source enabling it to be bound to.
public protocol ReactiveTableViewDataSourceType: AnyObject /*: UITableViewDataSource*/ {

    /// Type of elements that can be bound to table view.
    associatedtype Element

    /// New observable sequence event observed.
    ///
    /// - parameter tableView: Bound table view.
    /// - parameter observedElementChangedTo: New value of observed element.
    func tableView(_ tableView: UITableView, observedElementChangedTo: Element)
}

extension ReactiveTableViewDataSourceType where Self: ReactiveExtensionsProvider {}

extension Reactive where Base: ReactiveTableViewDataSourceType {
    var observedElement: BindingTarget<(UITableView, Base.Element)> {
        return makeBindingTarget { base, arg in
            let (tableView, element) = arg
            base.tableView(tableView, observedElementChangedTo: element)
        }
    }
}

#endif
