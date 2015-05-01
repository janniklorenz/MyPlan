//
//  MPCalenderLayout.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 27.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

protocol MPCalenderLayoutDelegate {
    func dateForRowAtIndexPath(indexPath: NSIndexPath) -> MPDate
    func canMoveRowAtIndexPath(indexPath: NSIndexPath) -> Bool
    func didMoveRowAtIndexPath(indexPath: NSIndexPath, toDate: MPDate)
    func didDropRowAtIndexPath(indexPath: NSIndexPath, toDate: MPDate)
}

class MPCalenderLayout: UICollectionViewFlowLayout {
    
    var delegate: MPCalenderLayoutDelegate?
    
    let houreHeight: CGFloat = 60
    
    
    var movingIndexPath: NSIndexPath?
    
    
    override func prepareLayout() {
        super.prepareLayout()
        
//        self.collectionView?.backgroundColor = UIColor.redColor()
        
        var longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongPressGesture:")
        self.collectionView?.addGestureRecognizer(longPressGesture)
        
        
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: 320, height: houreHeight*24)
    }
    
    
    
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        
        var elements = [UICollectionViewLayoutAttributes]()
        
        for (var i = 0; i < self.collectionView?.numberOfSections(); i++) {
            for (var j = 0; j < self.collectionView?.numberOfItemsInSection(i); j++) {
                
                var indexPath = NSIndexPath(forRow: j, inSection: i)
                var attr = self.layoutAttributesForItemAtIndexPath(indexPath);
                
                elements.append(attr);
            }
        }
        
        return elements
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        var attribute = super.layoutAttributesForItemAtIndexPath(indexPath)
        
        var cellDate = delegate?.dateForRowAtIndexPath(indexPath)
        println(cellDate?.description)
        
        if let date = cellDate {
            var x: CGFloat = 10
            var y: CGFloat = houreHeight*CGFloat(date.seconds)/CGFloat(3600)
            var rect = CGRectMake(x, y, 320, houreHeight)
            attribute.frame = rect;
        }
        
        return attribute
    }
    
    
    
    
    
    // MARK: - UILongPressGestureRecognizer
    var moveingStartPointInCell: CGPoint?
    
    func handleLongPressGesture(longPress: UILongPressGestureRecognizer) {
        if let collectionView = self.collectionView {
            switch (longPress.state) {
            case .Began:
                if let indexPath = collectionView.indexPathForItemAtPoint(longPress.locationInView(collectionView)) {
                    if self.delegate?.canMoveRowAtIndexPath(indexPath) != false {
                        movingIndexPath = indexPath
                        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
                            moveingStartPointInCell = longPress.locationInView(cell)
                            UIView.animateWithDuration(0.3) {
                                cell.transform = CGAffineTransformMakeScale(1.03, 1.03)
                            }
                        }
                    }
                }
                
            case .Changed:
                if let indexPath = movingIndexPath {
                    if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
                        
                        if let moveingStartPointInCell = moveingStartPointInCell {
                            println("\(moveingStartPointInCell.y) \(longPress.locationInView(collectionView).y)")
                            var y = longPress.locationInView(collectionView).y - moveingStartPointInCell.y
                            if y >= 0 {
                                cell.frame.origin.y = y
                                
                                var point = longPress.locationInView(collectionView)
                                var date = MPDate(seconds: Int( Double(point.y) / Double(houreHeight) * 3600 ))
                                self.delegate?.didMoveRowAtIndexPath(indexPath, toDate: date)
                                
                                
//                                if let collectionView = self.collectionView {
//                                    
//                                    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
//                                        
//                                        while (
//                                            (y < 10 /*|| Int(collectionView.frame.size.height - y) < 10*/) &&
//                                            (collectionView.contentOffset.y <= 0 /*|| Int(collectionView.contentSize.height - collectionView.contentOffset.y) <= 0*/)) {
//                                            
//                                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                                                //if y < 10 {
//                                                    println("up \(collectionView.contentOffset.y)")
//                                                    collectionView.contentOffset.y--
//                                                //}
//                                                //else if Int(collectionView.frame.size.height - y) < 10 {
//                                                //    println("down \(collectionView.contentOffset.y)")
//                                                //    collectionView.contentOffset.y++
//                                                //}
//                                            })
//                                        }
//                                        
//                                    })
//                                    
//                                }
                                
                            }
                            else {
                                cell.frame.origin.y = 0
                            }
                        }
                    
                        
                    }
                }
                
                
            case .Ended, .Cancelled, .Failed:
                if let indexPath = movingIndexPath {
                    if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
                        UIView.animateWithDuration(0.3) {
                            cell.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        }
                    }
                    
                    if longPress.state == .Ended {
                        if let moveingStartPointInCell = moveingStartPointInCell {
                            var y = longPress.locationInView(collectionView).y - moveingStartPointInCell.y
                            
                            var date = MPDate(seconds: Int( Double(y) / Double(houreHeight) * 3600 ))
                            self.delegate?.didDropRowAtIndexPath(indexPath, toDate: date)
                        }
                    }
                }
                movingIndexPath = nil
                moveingStartPointInCell = nil
                
                
            case .Possible:
                print()
                break
                
            }
        }
    }
    
    
    
}
