//
//  AppDelegate.swift
//  CleanFrameViewSample
//
//  Created by Дмитрий Николаев on 21.03.15.
//  Copyright (c) 2015 Dmitry Nikolaev. All rights reserved.
//

import Cocoa
import CleanFrameView

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: CleanWindow!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.window = CleanWindow(contentRect: NSRect(x: 500, y: 500, width: 200, height: 200))
        self.window.minSize = NSSize(width: 200, height: 200)
        let app = NSApplication.sharedApplication()
        app.activateIgnoringOtherApps(true)
        self.window.makeKeyAndOrderFront(nil)
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