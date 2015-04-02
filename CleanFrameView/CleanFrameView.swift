//
//  CleanFrameView.swift
//  CleanFrameView
//
//  Created by Дмитрий Николаев on 21.03.15.
//  Copyright (c) 2015 Dmitry Nikolaev. All rights reserved.
//


import Appkit


public class CleanFrameView : NSView {
    
    let northWestSouthEastCursor: NSCursor
    let northeastsouthwestCursor: NSCursor
    let eastWestCursor: NSCursor
    let northSouthCursor: NSCursor
    
    public var cornerRadius: CGFloat = 5 {
        didSet {
            self.cacheImage = nil
            self.needsDisplay = true
        }
    }
    
    public var shadowBlurRadius: CGFloat = 15 {
        didSet {
            self.cacheImage = nil
            self.needsDisplay = true
        }
    }
    
    public var shadowColor: NSColor = NSColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0.085) {
        didSet {
            self.cacheImage = nil
            self.needsDisplay = true
        }
    }
    
    public var backgroundColor: NSColor = NSColor.whiteColor() {
        didSet {
            self.cacheImage = nil
            self.needsDisplay = true
        }
    }
    
    public var strokeColor: NSColor = NSColor(calibratedRed: 220/255, green: 220/255, blue: 220/255, alpha: 1) {
        didSet {
            self.cacheImage = nil
            self.needsDisplay = true
        }
    }
    
    public var strokeLineWidth: CGFloat = 0.5 {
        didSet {
            self.cacheImage = nil
            self.needsDisplay = true
        }
    }
    
    let resizeInsetCornerWidth = CGFloat(10.0)
    let resizeInsetSideWidth = CGFloat(2.0)
    
    var cacheImageSize = NSSize()
    var cacheImage: NSImage?
    
    public override var alignmentRectInsets: NSEdgeInsets {
        return NSEdgeInsets(top: self.shadowBlurRadius, left: self.shadowBlurRadius, bottom: self.shadowBlurRadius, right: self.shadowBlurRadius)
    }
    
    public override init(frame frameRect: NSRect) {
        
        // \
        let northWestSouthEastPath = NSString(format: "%@/Contents/Frameworks/CleanFrameView.framework/Resources/resizenorthwestsoutheast.pdf", NSBundle.mainBundle().bundlePath)
        let northWestSouthEastImage = NSImage(contentsOfFile: northWestSouthEastPath)!
        self.northWestSouthEastCursor = NSCursor(image: northWestSouthEastImage, hotSpot: NSPoint(x: northWestSouthEastImage.size.width/2, y:northWestSouthEastImage.size.height/2))
        
        // /
        let northeastsouthwestPath = NSString(format: "%@/Contents/Frameworks/CleanFrameView.framework/Resources/resizenortheastsouthwest.pdf", NSBundle.mainBundle().bundlePath)
        let northeastsouthwestImage = NSImage(contentsOfFile: northeastsouthwestPath)!
        self.northeastsouthwestCursor = NSCursor(image: northeastsouthwestImage, hotSpot: NSPoint(x: northeastsouthwestImage.size.width/2, y:northeastsouthwestImage.size.height/2))
        
        // -
        let eastWestPath = NSString(format: "%@/Contents/Frameworks/CleanFrameView.framework/Resources/resizeeastwest.pdf", NSBundle.mainBundle().bundlePath)
        let eastWestImage = NSImage(contentsOfFile: eastWestPath)!
        self.eastWestCursor = NSCursor(image: eastWestImage, hotSpot: NSPoint(x: eastWestImage.size.width/2, y:eastWestImage.size.height/2))
        
        // |
        let northSouthPath = NSString(format: "%@/Contents/Frameworks/CleanFrameView.framework/Resources/resizenorthsouth.pdf", NSBundle.mainBundle().bundlePath)
        let northSouthImage = NSImage(contentsOfFile: northSouthPath)!
        self.northSouthCursor = NSCursor(image: northSouthImage, hotSpot: NSPoint(x: northSouthImage.size.width/2, y:northSouthImage.size.height/2))
        
        super.init(frame: frameRect)
        self.wantsLayer = false // YES will made text drawing a little thinner compared to textview
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func drawRect(dirtyRect: NSRect) {
        
        if (!NSEqualSizes(self.cacheImageSize, self.bounds.size) || self.cacheImage == nil) {
            self.cacheImageSize = self.bounds.size
            self.cacheImage = NSImage(size: self.bounds.size)
            self.cacheImage!.lockFocus()

            var rect = self.bounds
            rect.inset(dx: self.shadowBlurRadius, dy: self.shadowBlurRadius)
            
            NSGraphicsContext.saveGraphicsState()
            
            let shadow = NSShadow()
            shadow.shadowColor = self.shadowColor
            shadow.shadowBlurRadius = self.shadowBlurRadius
            shadow.set()
            
            let backgroundPath = NSBezierPath(roundedRect: rect, xRadius: self.cornerRadius, yRadius: self.cornerRadius)
            self.backgroundColor.setFill()
            backgroundPath.fill()
            
            NSGraphicsContext.restoreGraphicsState()
            
            rect.origin.x += 0.5
            rect.origin.y += 0.5
            let borderPath = NSBezierPath(roundedRect: rect, xRadius: self.cornerRadius, yRadius: self.cornerRadius)
            //        let borderPath = NSBezierPath(rect: rect)
            borderPath.lineWidth = self.strokeLineWidth
            
            self.strokeColor.setStroke()
            borderPath.stroke()
            
            // NSColor.redColor().setFill()
            // NSRectFill(self.resizeRect())

            self.cacheImage!.unlockFocus()
            // println("set cache");
        } else {
            // println("load cache");
        }
        
        self.cacheImage!.drawAtPoint(NSPoint(), fromRect: NSRect(), operation:  .CompositeCopy, fraction: 1)

        
    }

    // MARK:  Cursor
    
    override public func resetCursorRects() {
        
        let directionHelper = self.buildDirectionHelper()

        self.addCursorRect(directionHelper.rectForDirection(.North), cursor: northSouthCursor)
        self.addCursorRect(directionHelper.rectForDirection(.NorthEast), cursor: northeastsouthwestCursor)
        self.addCursorRect(directionHelper.rectForDirection(.East), cursor: eastWestCursor)
        self.addCursorRect(directionHelper.rectForDirection(.SouthEast), cursor: northWestSouthEastCursor)
        self.addCursorRect(directionHelper.rectForDirection(.South), cursor: northSouthCursor)
        self.addCursorRect(directionHelper.rectForDirection(.SouthWest), cursor: northeastsouthwestCursor)
        self.addCursorRect(directionHelper.rectForDirection(.West), cursor: eastWestCursor)
        self.addCursorRect(directionHelper.rectForDirection(.NorthWest), cursor: northWestSouthEastCursor)
    }
    
    private func buildDirectionHelper() -> CardinalDirectionHelper {
        var rect = self.bounds
        rect.inset(dx: self.shadowBlurRadius, dy: self.shadowBlurRadius)
        let directionHelper = CardinalDirectionHelper(rect: rect, cornerInset: resizeInsetCornerWidth, sideInset: resizeInsetSideWidth)
        return directionHelper
    }
    
    override public func mouseDown(theEvent: NSEvent) {
        let pointInView = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        var resize = false
        let window = self.window! as NSWindow
        
        let directionHelper = self.buildDirectionHelper()
        let direction = directionHelper.directionForPoint(pointInView)
        
        if direction != nil {
            resize = true
            window.movableByWindowBackground = false
            NSNotificationCenter.defaultCenter().postNotificationName(NSWindowWillStartLiveResizeNotification, object: self.window!)
        }
        
        var originalMouseLocationRect = window.convertRectToScreen(NSRect(origin: theEvent.locationInWindow, size: CGSize()))
        var originalMouseLocation = originalMouseLocationRect.origin
        let originalFrame = window.frame
        var windowFrame = window.frame
        var delta = NSPoint()
        
        while true {
            
            let newEvent = window.nextEventMatchingMask(Int(NSEventMask.LeftMouseDraggedMask.rawValue) | Int(NSEventMask.LeftMouseUpMask.rawValue))
            
            if newEvent!.type == .LeftMouseUp {
                NSNotificationCenter.defaultCenter().postNotificationName(NSWindowDidEndLiveResizeNotification, object: self.window!)
                break
            }
            
            let newMouseLocationRect = window.convertRectToScreen(NSRect(origin: newEvent!.locationInWindow, size: CGSize()))
            let newMouseLocation = newMouseLocationRect.origin
            delta.x += newMouseLocation.x - originalMouseLocation.x
            delta.y += newMouseLocation.y - originalMouseLocation.y
            
            // println("delta: \(delta)")
            
            //var newFrame = originalFrame
            
            let treshold = 0
            let absdeltay = fabs(delta.y)
            let absdeltax = fabs(delta.x)
            //            println("x/y: \(absdeltax) \(absdeltay)")
            
            if resize && (fabs(delta.y) >= CGFloat(treshold) || fabs(delta.x) >= CGFloat(treshold)) {
                
                // resize
                
                switch direction! {
                case .North:
                    delta.y = (windowFrame.size.height + delta.y > self.window!.minSize.height ? delta.y : self.window!.minSize.height - windowFrame.size.height)
                    
                    windowFrame.size.height += delta.y
                    window.setFrame(windowFrame, display: true, animate: false)
                    
                case .NorthEast:
                    delta.x = (windowFrame.size.width + delta.x > self.window!.minSize.width ? delta.x : self.window!.minSize.width - windowFrame.size.width)
                    delta.y = (windowFrame.size.height + delta.y > self.window!.minSize.height ? delta.y : self.window!.minSize.height - windowFrame.size.height)
                    
                    windowFrame.size.height += delta.y
                    windowFrame.size.width += delta.x
                    window.setFrame(windowFrame, display: true, animate: false)
                    
                case .East:
                    delta.x = (windowFrame.size.width + delta.x > self.window!.minSize.width ? delta.x : self.window!.minSize.width - windowFrame.size.width)
                    
                    windowFrame.size.width += delta.x
                    window.setFrame(windowFrame, display: true, animate: false)
                    
                case .SouthEast:
                    delta.x = (windowFrame.size.width + delta.x > self.window!.minSize.width ? delta.x : self.window!.minSize.width - windowFrame.size.width)
                    delta.y = (windowFrame.size.height - delta.y > self.window!.minSize.height ? delta.y : windowFrame.size.height - self.window!.minSize.height)
                    
                    windowFrame.size.width += delta.x
                    windowFrame.size.height -= delta.y
                    windowFrame.origin.y += delta.y
                    window.setFrame(windowFrame, display: true, animate: false)
                    
                case .South:
                    delta.y = (windowFrame.size.height - delta.y > self.window!.minSize.height ? delta.y : windowFrame.size.height - self.window!.minSize.height)
                    
                    windowFrame.size.height -= delta.y
                    windowFrame.origin.y += delta.y
                    window.setFrame(windowFrame, display: true, animate: false)
                    
                case .SouthWest:
                    delta.x = (windowFrame.size.width - delta.x > self.window!.minSize.width ? delta.x : windowFrame.size.width - self.window!.minSize.width)
                    delta.y = (windowFrame.size.height - delta.y > self.window!.minSize.height ? delta.y : windowFrame.size.height - self.window!.minSize.height)
                    
                    windowFrame.origin.x += delta.x
                    windowFrame.size.width -= delta.x
                    windowFrame.size.height -= delta.y
                    windowFrame.origin.y += delta.y
                    window.setFrame(windowFrame, display: true, animate: false)
                    
                case .West:
                    delta.x = (windowFrame.size.width - delta.x > self.window!.minSize.width ? delta.x : windowFrame.size.width - self.window!.minSize.width)
                    
                    windowFrame.origin.x += delta.x
                    windowFrame.size.width -= delta.x
                    window.setFrame(windowFrame, display: true, animate: false)
                    
                case .NorthWest:
                    delta.x = (windowFrame.size.width - delta.x > self.window!.minSize.width ? delta.x : windowFrame.size.width - self.window!.minSize.width)
                    delta.y = (windowFrame.size.height + delta.y > self.window!.minSize.height ? delta.y : self.window!.minSize.height - windowFrame.size.height)
                    
                    windowFrame.origin.x += delta.x
                    windowFrame.size.width -= delta.x
                    windowFrame.size.height += delta.y
                    window.setFrame(windowFrame, display: true, animate: false)
                }
                
                delta.x = 0
                delta.y = 0
                
            }
            
            if (!resize) {
                windowFrame.origin.x += delta.x
                windowFrame.origin.y += delta.y
                window.setFrame(windowFrame, display: true, animate: false)
                delta.x = 0
                delta.y = 0
            }
            
            originalMouseLocation = newMouseLocation
        }
        
    }
    
}


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

