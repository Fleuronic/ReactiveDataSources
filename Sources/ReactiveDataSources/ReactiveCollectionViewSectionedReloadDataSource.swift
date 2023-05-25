//
//  ReactiveCollectionViewSectionedReloadDataSource.swift
//  ReactiveDataSources
//
//  Created by Daniel Ostashev on 9/24/19.
//  Copyright © 2019 Cruxlab. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation
import UIKit

open class ReactiveCollectionViewSectionedReloadDataSource<Section: SectionModelType>
    : CollectionViewSectionedDataSource<Section>
    , ReactiveCollectionViewDataSourceType {
    
    public typealias Element = [Section]

    open func collectionView(_ collectionView: UICollectionView, observedElementChangedTo element: Element) {
        #if DEBUG
            _dataSourceBound = true
        #endif
        setSections(element)
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
#endif
