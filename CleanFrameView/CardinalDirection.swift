//
//  CardinalDirection.swift
//  CleanFrameView
//
//  Created by Дмитрий Николаев on 20.04.15.
//  Copyright (c) 2015 Dmitry Nikolaev. All rights reserved.
//

import Foundation

enum CardinalDirection {
    case North, NorthEast, East, SouthEast, South, SouthWest, West, NorthWest
    static let AllValues = [North, NorthEast, East, SouthEast, South, SouthWest, West, NorthWest]
}


class CardinalDirectionHelper {
    
    let rect: NSRect
    let cornerInset: CGFloat
    let sideInset: CGFloat
    
    init(rect: NSRect, cornerInset: CGFloat, sideInset: CGFloat) {
        self.rect = rect
        self.cornerInset = cornerInset
        self.sideInset = sideInset
    }
    
    func directionForPoint(point: NSPoint) -> CardinalDirection? {
        
        for direction in CardinalDirection.AllValues {
            if (NSPointInRect(point, rectForDirection(direction))) {
                return direction
            }
        }
        
        return nil
    }
    
    func rectForDirection(direction: CardinalDirection) -> NSRect {
        let southTopCorner = rect.origin.y + cornerInset
        let southTopSide = rect.origin.y + sideInset
        let southBottom = rect.origin.y
        
        let northTop = NSMaxY(rect)
        let northBottomCorner = northTop - cornerInset
        let northBottomSide = northTop - sideInset
        
        let westLeft = rect.origin.x
        let westRightCorner = westLeft + cornerInset
        let westRightSide = westLeft + sideInset
        
        let eastRight = NSMaxX(rect)
        let eastLeftCorner = eastRight - cornerInset
        let eastLeftSide = eastRight - sideInset
        
        let northRect = NSRect(x: westRightCorner, y: northBottomSide, width: eastLeftCorner - westRightCorner, height: sideInset)
        let northEastRect = NSRect(x: eastLeftCorner, y: northBottomCorner, width: cornerInset, height: cornerInset)
        let eastRect = NSRect(x: eastLeftSide, y: southTopCorner, width: sideInset, height: northBottomCorner - southTopCorner)
        let southEastRect = NSRect(x: eastLeftCorner, y: southBottom, width: cornerInset, height: cornerInset)
        
        let southRect = NSRect(x: westRightCorner, y: southBottom, width: eastLeftCorner - westRightCorner, height: sideInset)
        let southWestRect = NSRect(x: westLeft, y: southBottom, width: cornerInset, height: cornerInset)
        let westRect = NSRect(x: westLeft, y: southTopCorner, width: sideInset, height: northBottomCorner - southTopCorner)
        let northWestRect = NSRect(x: westLeft, y: northBottomCorner, width: cornerInset, height: cornerInset)
        
        switch direction {
        case .North: return northRect
        case .NorthEast: return northEastRect
        case .East: return eastRect
        case .SouthEast: return southEastRect
        case .South: return southRect
        case .SouthWest: return southWestRect
        case .West: return westRect
        case .NorthWest: return northWestRect
        }
        
    }
    
}

