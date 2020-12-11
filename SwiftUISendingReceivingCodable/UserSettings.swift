//
//  UserSettings.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 11/12/2020.
//

import Foundation
import MapKit

class UserSettings: ObservableObject {
    @Published var pointsOfInterests: [MKPointOfInterestCategory]? {
        didSet {
            UserDefaults.standard.set(pointsOfInterests, forKey: "pointsOfInterests")
        }
    }
    
    init() {
        self.pointsOfInterests = UserDefaults.standard.object(forKey: "pointsOfInterests") as? [MKPointOfInterestCategory]
    }
}
