//
//  LastFM.swift
//  Scribble
//
//  Created by Kilian Költzsch on 30/12/2016.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import Foundation
import LastFm

class LastFM {
    let lfm = LastFm.sharedInstance()

    init() {
        lfm?.apiKey = Secrets.apiKey
        lfm?.apiSecret = Secrets.apiSecret
    }

    convenience init(username: String, password: String) {
        self.init()

        let _ = lfm?.getSessionForUser(username, password: password, successHandler: { [weak self] result in
            guard let result = result else { return }
            print(result)

            guard let username = result["name"] as? String else { return }
            guard let session = result["session"] as? String else { return }

            UserDefaults.standard.set(username, forKey: "username")
            UserDefaults.standard.set(session, forKey: "session")

            self?.lfm?.username = username
            self?.lfm?.session = session
        }, failureHandler: { error in
            guard let error = error else { return }
            print(error)
        })
    }

    static func loadFromDefaults() -> LastFM? {
        guard let username = UserDefaults.standard.string(forKey: "username") else { return nil }
        guard let session = UserDefaults.standard.string(forKey: "session") else { return nil }

        let lastFM = LastFM()

        lastFM.lfm?.username = username
        lastFM.lfm?.session = session

        return lastFM
    }
}
