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


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        iTunes.shared.onNewTrack = { track in
            print(track)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}
