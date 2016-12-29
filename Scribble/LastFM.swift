//
//  LastFM.swift
//  Scribble
//
//  Created by Kilian Költzsch on 30/12/2016.
//  Copyright © 2016 Kilian Koeltzsch. All rights reserved.
//

import Foundation
import LastFm

struct LastFM {
    let lfm = LastFm.sharedInstance()

//    static let shared = LastFM()

    init(username: String, password: String) {
        lfm?.apiKey = Secrets.apiKey
        lfm?.apiSecret = Secrets.apiSecret

        lfm?.getSessionForUser(username, password: password, successHandler: { result in
            guard let result = result else { return }
            print(result)
            UserDefaults.standard.set(result["name"], forKey: "username")
            UserDefaults.standard.set(result["key"], forKey: "session")
        }, failureHandler: { error in
            print(error)
        })
    }
}
