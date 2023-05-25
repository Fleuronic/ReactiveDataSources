//
//  ReactiveCollectionViewSectionedAnimatedswift
//  ReactiveDataSources
//
//  Created by Daniel Ostashev on 9/24/19.
//  Copyright © 2019 Cruxlab. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation
import UIKit

open class ReactiveCollectionViewSectionedAnimatedDataSource<Section: AnimatableSectionModelType>
    : CollectionViewSectionedDataSource<Section>
    , ReactiveCollectionViewDataSourceType {
    public typealias Element = [Section]
    public typealias DecideViewTransition = (CollectionViewSectionedDataSource<Section>, UICollectionView, [Changeset<Section>]) -> ViewTransition

    // animation configuration
    public var animationConfiguration: AnimationConfiguration

    /// Calculates view transition depending on type of changes
    public var decideViewTransition: DecideViewTransition

    public init(
        animationConfiguration: AnimationConfiguration = AnimationConfiguration(),
        decideViewTransition: @escaping DecideViewTransition = { _, _, _ in .animated },
        configureCell: @escaping ConfigureCell,
        configureSupplementaryView: ConfigureSupplementaryView? = nil,
        moveItem: @escaping MoveItem = { _, _, _ in () },
        canMoveItemAtIndexPath: @escaping CanMoveItemAtIndexPath = { _, _ in false }
        ) {
        self.animationConfiguration = animationConfiguration
        self.decideViewTransition = decideViewTransition
        super.init(
            configureCell: configureCell,
            configureSupplementaryView: configureSupplementaryView,
            moveItem: moveItem,
            canMoveItemAtIndexPath: canMoveItemAtIndexPath
        )
    }
    
    // there is no longer limitation to load initial sections with reloadData
    // but it is kept as a feature everyone got used to
    var dataSet = false

    open func collectionView(_ collectionView: UICollectionView, observedElementChangedTo newSections: Element) {
        #if DEBUG
            _dataSourceBound = true
        #endif
        if !dataSet {
            dataSet = true
            setSections(newSections)
            collectionView.reloadData()
        }
        else {
            // if view is not in view hierarchy, performing batch updates will crash the app
            if collectionView.window == nil {
                setSections(newSections)
                collectionView.reloadData()
                return
            }
            let oldSections = sectionModels
            do {
                let differences = try Diff.differencesForSectionedView(initialSections: oldSections, finalSections: newSections)

                switch decideViewTransition(self, collectionView, differences) {
                case .animated:
                    // each difference must be run in a separate 'performBatchUpdates', otherwise it crashes.
                    // this is a limitation of Diff tool
                    for difference in differences {
                        let updateBlock = { [unowned self] in
                            // sections must be set within updateBlock in 'performBatchUpdates'
                            self.setSections(difference.finalSections)
                            collectionView.batchUpdates(difference, animationConfiguration: self.animationConfiguration)
                        }
                        collectionView.performBatchUpdates(updateBlock, completion: nil)
                    }

                case .reload:
                    setSections(newSections)
                    collectionView.reloadData()
                    return
                }
            }
            catch _ {
                setSections(newSections)
                collectionView.reloadData()
            }
        }
    }
}
#endif
