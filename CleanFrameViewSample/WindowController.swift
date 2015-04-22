//
//  Window.swift
//  CleanFrameView
//
//  Created by Дмитрий Николаев on 20.04.15.
//  Copyright (c) 2015 Dmitry Nikolaev. All rights reserved.
//

import AppKit
import CleanFrameView


class WindowController: NSWindowController {
    
    lazy var resizableWindow: CleanWindow = {
        var window = CleanWindow(contentRect: NSRect(x: 500, y: 500, width: 200, height: 200))
        window.minSize = NSSize(width: 200, height: 200)
        return window
    }()
    
    lazy var attachedWindow: AttachedWindow = {
        var window = AttachedWindow(contentRect: NSRect(x: 500, y: 500, width: 200, height: 200))
        window.minSize = NSSize(width: 200, height: 200)
        return window
    }()

    
    @IBAction func resizableWindowButtonClicked(sender: AnyObject) {
        if self.resizableWindow.visible {
            self.resizableWindow.close()
        } else {
            let app = NSApplication.sharedApplication()
            app.activateIgnoringOtherApps(true)
            self.resizableWindow.makeKeyAndOrderFront(nil)
        }
    }
    
    
    @IBAction func attachedWindowButtonClicked(sender: AnyObject) {
        if self.attachedWindow.visible {
            self.attachedWindow.close()
        } else {
            let app = NSApplication.sharedApplication()
            app.activateIgnoringOtherApps(true)
            self.attachedWindow.makeKeyAndOrderFront(nil)
        }
    }
}


public class CleanWindow: NSWindow {
    
    public init(contentRect: NSRect) {
        super.init(contentRect: contentRect, styleMask: NSBorderlessWindowMask, backing: .Buffered, defer: false)
        
        self.movableByWindowBackground = false;
        self.alphaValue = 1
        self.opaque = false
        self.backgroundColor = NSColor.clearColor()
        self.hasShadow = false
        self.contentView = CleanFrameView(frame: NSZeroRect)
        self.releasedWhenClosed = false
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public var canBecomeMainWindow: Bool {
        get {return true}
    }
    
    override public var canBecomeKeyWindow: Bool {
        get {return true}
    }
    
}

public class AttachedWindow: NSWindow {
    
    public init(contentRect: NSRect) {
        super.init(contentRect: contentRect, styleMask: NSBorderlessWindowMask, backing: .Buffered, defer: false)
        
        self.movableByWindowBackground = false;
        self.alphaValue = 1
        self.opaque = false
        self.backgroundColor = NSColor.clearColor()
        self.hasShadow = false
        self.contentView = AttachedCleanFrameView(frame: NSZeroRect)
        self.releasedWhenClosed = false
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public var canBecomeMainWindow: Bool {
        get {return true}
    }
    
    override public var canBecomeKeyWindow: Bool {
        get {return true}
    }
    
}