//
//  SwiftUISendingReceivingCodableApp.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 23/07/2020.
//

import SwiftUI
import MapKit

@main
struct SwiftUISendingReceivingCodableApp: App {
    var userSettings = UserSettings()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userSettings)
        }
    }
}
