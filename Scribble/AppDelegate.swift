//
//  AppDelegate.swift
//  Scribble
//
//  Created by Kilian Költzsch on 29/12/2016.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var usernameField: NSTextField!
    @IBOutlet weak var passwordField: NSSecureTextField!

    var lastFM: LastFM?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true
        statusItem.image = icon

        if let lastFM = LastFM.loadFromDefaults() {
            self.lastFM = lastFM
        } else {
            window.makeKeyAndOrderFront(self)
            NSApp.activate(ignoringOtherApps: true)
        }

        iTunes.shared.onNewTrack = { track in

        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func loginPressed(_ sender: NSButton) {
        self.lastFM = LastFM(username: usernameField.stringValue, password: passwordField.stringValue)
    }

}
