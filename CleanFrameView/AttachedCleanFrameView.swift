//
//  AttachedFrameView.swift
//  CleanFrameView
//
//  Created by Дмитрий Николаев on 20.04.15.
//  Copyright (c) 2015 Dmitry Nikolaev. All rights reserved.
//

import AppKit

public class AttachedCleanFrameView : NSView {
    
    var cacheImage: NSImage?
    let direction: CardinalDirection
    let pointOffset: CGFloat

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

    public override init(frame frameRect: NSRect, direction: CardinalDirection, pointOffset: CGFloat) {
        self.direction = direction
        self.pointOffset = pointOffset
        super.init(frame: frameRect)
        self.wantsLayer = true // YES will made text drawing a little thinner compared to textview
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func drawRect(dirtyRect: NSRect) {
        
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
        
    }

    
}
