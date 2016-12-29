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

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var usernameField: NSTextField!
    @IBOutlet weak var passwordField: NSSecureTextField!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        iTunes.shared.onNewTrack = { track in

        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func loginPressed(_ sender: NSButton) {
        let lastFM = LastFM(username: usernameField.stringValue, password: passwordField.stringValue)
    }

}
