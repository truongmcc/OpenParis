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
    
    @Published var rayOfDistance: Int {
        didSet {
            UserDefaults.standard.set(rayOfDistance, forKey: "rayOfDistance")
        }
    }
    
    @Published var mapType: Int {
        didSet {
            UserDefaults.standard.set(mapType, forKey: "mapType")
        }
    }
    
    @Published var typeService: ServicesEnum {
        didSet {
            UserDefaults.standard.set(typeService.rawValue, forKey: "typeService")
        }
    }
       
    
    init() {
        self.pointsOfInterests = UserDefaults.standard.object(forKey: "pointsOfInterests") as? [MKPointOfInterestCategory]
        
        self.rayOfDistance = UserDefaults.standard.object(forKey: "rayOfDistance") as? Int ?? 700
        
        self.mapType = UserDefaults.standard.object(forKey: "mapType") as? Int ?? 0
        
        self.typeService = ServicesEnum(rawValue: UserDefaults.standard.object(forKey: "typeService") as? ServicesEnum.RawValue ?? ServicesEnum.velib.rawValue)!
        
    }
}
