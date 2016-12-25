//
//  CustomCollectionViewLayout.swift
//  Make Your Mark
//
//  Created by Kento Okamoto on 12/6/16.
//  Copyright © 2016 Kento Okamoto. All rights reserved.
//

//The MIT License (MIT)
//Layout of Code below was created by
//Copyright (c) 2015 Kyle Andrews
//Link: https://github.com/kwandrews7/MultiDirectionCollectionView/tree/adding-sticky-headers
//Slight Modifications were done as well

import UIKit

class CustomCollectionViewLayout: UICollectionViewLayout {
    let CELL_WIDTH = 200.0
    let CELL_HEIGHT = 100.0
    let STATUS_BAR = UIApplication.shared.statusBarFrame.height
    var cellAttrDict = Dictionary<NSIndexPath, UICollectionViewLayoutAttributes >()
    var contentSize = CGSize.zero
    var dataSourceDidUpdate = true
    override var collectionViewContentSize: CGSize{
        return self.contentSize
    }
    override func prepare() {
        if dataSourceDidUpdate == false{
            // Determine current content offsets.
            let xOffset = collectionView!.contentOffset.x
            //let yOffset = collectionView!.contentOffset.y
            
            if (collectionView?.numberOfSections)! > 0 {
                for section in 0...collectionView!.numberOfSections-1 {
                    
                    // Confirm the section has items.
                    if (collectionView?.numberOfItems(inSection: section))! > 0 {
                        
                        // Update all items in the first row.
                        if section == 0 {
                            for item in 0...collectionView!.numberOfItems(inSection: section)-1 {
                                
                                // Build indexPath to get attributes from dictionary.
                                let indexPath = NSIndexPath(item: item, section: section)
                                
                                // Update y-position to follow user.
                                if let attrs = cellAttrDict[indexPath] {
                                    var frame = attrs.frame
                                    
                                    // Also update x-position for corner cell.
                                    if item == 0 {
                                        frame.origin.x = xOffset
                                    }
                                    
                                    frame.origin.y = 0.0
                                    attrs.frame = frame
                                }
                                
                            }
                            
                            // For all other sections, we only need to update
                            // the x-position for the fist item.
                        } else {
                            
                            // Build indexPath to get attributes from dictionary.
                            let indexPath = NSIndexPath(item: 0, section: section)
                            
                            // Update y-position to follow user.
                            if let attrs = cellAttrDict[indexPath] {
                                var frame = attrs.frame
                                frame.origin.x = xOffset
                                attrs.frame = frame
                            }
                            
                        }
                    }
                }
            }
            // Do not run attribute generation code
            // unless data source has been updated.
            return
        }
        
        // Acknowledge data source change, and disable for next time.
        dataSourceDidUpdate = false
        
        if (collectionView?.numberOfSections)! > 0{
            for section in 0...(collectionView?.numberOfSections)!-1{
                if (collectionView?.numberOfItems(inSection: section))! > 0{
                    for item in 0...(collectionView?.numberOfItems(inSection: section))!-1{
                        let cellIndex = NSIndexPath(item: item, section: section)
                        let xPos = Double(item) * CELL_WIDTH
                        let yPos = Double(section) * CELL_HEIGHT
                        
                        let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndex as IndexPath)
                        cellAttributes.frame = CGRect(x: xPos, y: yPos, width: CELL_WIDTH, height: CELL_HEIGHT)
                        
                        // Determine zIndex based on cell type.
                        if section == 0 && item == 0 {
                            cellAttributes.zIndex = 4
                        } else if section == 0 {
                            cellAttributes.zIndex = 3
                        } else if item == 0 {
                            cellAttributes.zIndex = 2
                        } else {
                            cellAttributes.zIndex = 1
                        }
                        
                        // Save the attributes.
                        cellAttrDict[cellIndex] = cellAttributes
                    }
                }
            }
        }
        
        // Update content size.
        let contentWidth = Double(collectionView!.numberOfItems(inSection: 0)) * CELL_WIDTH
        let contentHeight = Double(collectionView!.numberOfSections) * CELL_HEIGHT
        self.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // Create an array to hold all elements found in our current view.
        var attributesInRect = [UICollectionViewLayoutAttributes]()
        
        // Check each element to see if it should be returned.
        for cellAttributes in cellAttrDict.values{
            if rect.intersects(cellAttributes.frame) {
                attributesInRect.append(cellAttributes)
            }
        }
        
        // Return list of elements.
        return attributesInRect
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttrDict[indexPath as NSIndexPath]
    }
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
