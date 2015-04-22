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

    var windowController: WindowController!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.windowController = WindowController(windowNibName: "Window")
        let app = NSApplication.sharedApplication()
        app.activateIgnoringOtherApps(true)
        self.windowController.window?.makeKeyAndOrderFront(nil)
    }

}


