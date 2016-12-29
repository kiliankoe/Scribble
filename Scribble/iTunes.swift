//
//  iTunes.swift
//  Scribble
//
//  Created by Kilian Költzsch on 29/12/2016.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import Foundation

class iTunes {
    enum PlayerState: String {
        case playing = "Playing"
        case paused = "Paused"
        case stopped = "Stopped"
    }

    private static let playerInfoNotification = NSNotification.Name(rawValue: "com.apple.iTunes.playerInfo")



    var currentState: PlayerState = .stopped
    var currentPlayCount = 0
    var currentTrack: Track? = nil

    var onNewTrack: ((Track) -> Void)? = nil



    static let shared = iTunes()

    private init() {
        DistributedNotificationCenter.default().addObserver(self, selector: #selector(receive), name: iTunes.playerInfoNotification, object: nil)
    }

    deinit {
        DistributedNotificationCenter.default().removeObserver(self, name: iTunes.playerInfoNotification, object: nil)
    }

    @objc private func receive(notification: NSNotification) {
        guard let playerState = notification.userInfo?["Player State"] as? String else { return }
        guard let playCount = notification.userInfo?["Play Count"] as? Int else { return }
        guard let track = Track(fromUserinfo: notification.userInfo) else { return }

        print("State: \(playerState), Count: \(playCount)")

        self.currentTrack = track
        onNewTrack?(track)
    }
}

struct Track {
    let title: String
    let album: String
    let artist: String

    init?(fromUserinfo userInfo: [AnyHashable: Any]?) {
        guard let userInfo = userInfo else { return nil }
        self.title = (userInfo["Name"] as? String) ?? ""
        self.album = (userInfo["Album"] as? String) ?? ""
        self.artist = (userInfo["Artist"] as? String) ?? ""
    }
}
