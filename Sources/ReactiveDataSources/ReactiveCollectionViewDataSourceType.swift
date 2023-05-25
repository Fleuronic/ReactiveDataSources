//
//  ReactiveCollectionViewDataSourceType.swift
//  ReactiveDataSources
//
//  Created by Daniel Ostashev on 9/24/19.
//  Copyright © 2019 Cruxlab. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit
import ReactiveSwift
import ReactiveCocoa

/// Marks data source as `UICollectionView` reactive data source enabling it to be used with one of the `bindTo` methods.
public protocol ReactiveCollectionViewDataSourceType: AnyObject /*: UICollectionViewDataSource*/ {

    /// Type of elements that can be bound to collection view.
    associatedtype Element

    /// New observable sequence event observed.
    ///
    /// - parameter collectionView: Bound collection view.
    /// - parameter observedElementChangedTo: New value of observed element.
    func collectionView(_ collectionView: UICollectionView, observedElementChangedTo: Element)
}

extension ReactiveCollectionViewDataSourceType where Self: ReactiveExtensionsProvider {}

extension Reactive where Base: ReactiveCollectionViewDataSourceType {
    var observedElement: BindingTarget<(UICollectionView, Base.Element)> {
        return makeBindingTarget { base, arg in
            let (collectionView, element) = arg
            base.collectionView(collectionView, observedElementChangedTo: element)
        }
    }
}

#endif
