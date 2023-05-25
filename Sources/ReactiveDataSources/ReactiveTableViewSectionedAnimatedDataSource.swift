//
//  ReactiveTableViewSectionedAnimatedswift
//  ReactiveDataSources
//
//  Created by Daniel Ostashev on 9/24/19.
//  Copyright © 2019 Cruxlab. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation
import UIKit

open class ReactiveTableViewSectionedAnimatedDataSource<Section: AnimatableSectionModelType>
    : TableViewSectionedDataSource<Section>
    , ReactiveTableViewDataSourceType {
    public typealias Element = [Section]
    public typealias DecideViewTransition = (TableViewSectionedDataSource<Section>, UITableView, [Changeset<Section>]) -> ViewTransition

    /// Animation configuration for data source
    public var animationConfiguration: AnimationConfiguration

    /// Calculates view transition depending on type of changes
    public var decideViewTransition: DecideViewTransition

    #if os(iOS)
        public init(
                animationConfiguration: AnimationConfiguration = AnimationConfiguration(),
                decideViewTransition: @escaping DecideViewTransition = { _, _, _ in .animated },
                configureCell: @escaping ConfigureCell,
                titleForHeaderInSection: @escaping  TitleForHeaderInSection = { _, _ in nil },
                titleForFooterInSection: @escaping TitleForFooterInSection = { _, _ in nil },
                canEditRowAtIndexPath: @escaping CanEditRowAtIndexPath = { _, _ in false },
                canMoveRowAtIndexPath: @escaping CanMoveRowAtIndexPath = { _, _ in false },
                sectionIndexTitles: @escaping SectionIndexTitles = { _ in nil },
                sectionForSectionIndexTitle: @escaping SectionForSectionIndexTitle = { _, _, index in index }
            ) {
            self.animationConfiguration = animationConfiguration
            self.decideViewTransition = decideViewTransition
            super.init(
                configureCell: configureCell,
               titleForHeaderInSection: titleForHeaderInSection,
               titleForFooterInSection: titleForFooterInSection,
               canEditRowAtIndexPath: canEditRowAtIndexPath,
               canMoveRowAtIndexPath: canMoveRowAtIndexPath,
               sectionIndexTitles: sectionIndexTitles,
               sectionForSectionIndexTitle: sectionForSectionIndexTitle
            )
        }
    #else
        public init(
                animationConfiguration: AnimationConfiguration = AnimationConfiguration(),
                decideViewTransition: @escaping DecideViewTransition = { _, _, _ in .animated },
                configureCell: @escaping ConfigureCell,
                titleForHeaderInSection: @escaping  TitleForHeaderInSection = { _, _ in nil },
                titleForFooterInSection: @escaping TitleForFooterInSection = { _, _ in nil },
                canEditRowAtIndexPath: @escaping CanEditRowAtIndexPath = { _, _ in false },
                canMoveRowAtIndexPath: @escaping CanMoveRowAtIndexPath = { _, _ in false }
            ) {
            self.animationConfiguration = animationConfiguration
            self.decideViewTransition = decideViewTransition
            super.init(
                configureCell: configureCell,
               titleForHeaderInSection: titleForHeaderInSection,
               titleForFooterInSection: titleForFooterInSection,
               canEditRowAtIndexPath: canEditRowAtIndexPath,
               canMoveRowAtIndexPath: canMoveRowAtIndexPath
            )
        }
    #endif

    var dataSet = false

    open func tableView(_ tableView: UITableView, observedElementChangedTo newSections: [Section]) {
        #if DEBUG
            _dataSourceBound = true
        #endif
        if !dataSet {
            dataSet = true
            setSections(newSections)
            tableView.reloadData()
        }
        else {
            // if view is not in view hierarchy, performing batch updates will crash the app
            if tableView.window == nil {
                setSections(newSections)
                tableView.reloadData()
                return
            }
            let oldSections = sectionModels
            do {
                let differences = try Diff.differencesForSectionedView(initialSections: oldSections, finalSections: newSections)

                switch decideViewTransition(self, tableView, differences) {
                case .animated:
                    // each difference must be run in a separate 'performBatchUpdates', otherwise it crashes.
                    // this is a limitation of Diff tool
                    for difference in differences {
                        let updateBlock = { [unowned self] in
                            // sections must be set within updateBlock in 'performBatchUpdates'
                            self.setSections(difference.finalSections)
                            tableView.batchUpdates(difference, animationConfiguration: self.animationConfiguration)
                        }
                        if #available(iOS 11, tvOS 11, *) {
                            tableView.performBatchUpdates(updateBlock, completion: nil)
                        } else {
                            tableView.beginUpdates()
                            updateBlock()
                            tableView.endUpdates()
                        }
                    }

                case .reload:
                    setSections(newSections)
                    tableView.reloadData()
                    return
                }
            }
            catch _ {
                setSections(newSections)
                tableView.reloadData()
            }
        }
    }
}
#endif
