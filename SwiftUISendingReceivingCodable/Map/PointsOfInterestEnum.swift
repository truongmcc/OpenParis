//
//  PointsOfInterestEnum.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 10/12/2020.
//

import Foundation
import MapKit

enum PointsOfInterestEnum: String, CaseIterable {
    case amusementPark = "Parcs de jeux"
    case atm = "Distributeurs automatiques"
    case bakery = "Boulangeries"
    case bank = "Banques"
    case brewery = "Brasseries"
    case cafe = "Cafés"
    case carRental = "Locations de voitures"
    case evCharger = "Chargeurs de véhicules"
    case fireStation = "Casernes de pompiers"
    case fitnessCenter = "Centre de fitness"
    case foodMarket = "Supermarchés"
    case gasStation = "Stations Essence"
    case hospital = "Hopitaux"
    case hotel = "Hotels"
    case laundry = "Laveries"
    case library = "Librairies"
    case movieTheater = "Cinémas"
    case museum = "Musés"
    case nightlife = "Vies nocturnes"
    case park = "Parcs"
    case parking = "Parkings"
    case pharmacy = "Pharmacies"
    case police = "Police"
    case postOffice = "Bureaux de poste"
    case publicTransport = "Transports publics"
    case restaurant = "Restaurants"
    case school = "Ecoles"
    case store = "Magasins"
    case theater = "Théâtres"
    case university = "Universités"
    case winery = "Cavistes"
    case aquarium = "Aquarium"
    case zoo = "Zoo"
    
    static func convert(enumList: [PointsOfInterestEnum]) -> [MKPointOfInterestCategory]? {
        var result = [MKPointOfInterestCategory]()
        for i in enumList {
            switch i {
            case .amusementPark:
                result.append(MKPointOfInterestCategory.amusementPark)
            case .atm:
                result.append(MKPointOfInterestCategory.atm)
            case .bakery:
                result.append(MKPointOfInterestCategory.bakery)
            case .bank:
                result.append(MKPointOfInterestCategory.bank)
            case .brewery:
                result.append(MKPointOfInterestCategory.brewery)
            case .cafe:
                result.append(MKPointOfInterestCategory.cafe)
            case .carRental:
                result.append(MKPointOfInterestCategory.carRental)
            case .evCharger:
                result.append(MKPointOfInterestCategory.evCharger)
            case .fireStation:
                result.append(MKPointOfInterestCategory.fireStation)
            case .fitnessCenter:
                result.append(MKPointOfInterestCategory.fitnessCenter)
            case .foodMarket:
                result.append(MKPointOfInterestCategory.foodMarket)
            case .gasStation:
                result.append(MKPointOfInterestCategory.gasStation)
            case .hospital:
                result.append(MKPointOfInterestCategory.hospital)
            case .hotel:
                result.append(MKPointOfInterestCategory.hotel)
            case .laundry:
                result.append(MKPointOfInterestCategory.laundry)
            case .library:
                result.append(MKPointOfInterestCategory.library)
            case .movieTheater:
                result.append(MKPointOfInterestCategory.movieTheater)
            case .museum:
                result.append(MKPointOfInterestCategory.museum)
            case .nightlife:
                result.append(MKPointOfInterestCategory.nightlife)
            case .park:
                result.append(MKPointOfInterestCategory.park)
            case .parking:
                result.append(MKPointOfInterestCategory.parking)
            case .pharmacy:
                result.append(MKPointOfInterestCategory.pharmacy)
            case .police:
                result.append(MKPointOfInterestCategory.police)
            case .postOffice:
                result.append(MKPointOfInterestCategory.postOffice)
            case .publicTransport:
                result.append(MKPointOfInterestCategory.publicTransport)
            case .restaurant:
                result.append(MKPointOfInterestCategory.restaurant)
            case .school:
                result.append(MKPointOfInterestCategory.school)
            case .store:
                result.append(MKPointOfInterestCategory.store)
            case .theater:
                result.append(MKPointOfInterestCategory.theater)
            case .university:
                result.append(MKPointOfInterestCategory.university)
            case .winery:
                result.append(MKPointOfInterestCategory.winery)
            case .aquarium:
                result.append(MKPointOfInterestCategory.aquarium)
            case .zoo:
                result.append(MKPointOfInterestCategory.zoo)
            }
        }
        return result
    }
    
    static func convert(pointsOfInterestList: [MKPointOfInterestCategory]) -> [PointsOfInterestEnum] {
        var result = [PointsOfInterestEnum]()
        for i in pointsOfInterestList {
            switch i {
            case MKPointOfInterestCategory.amusementPark:
                result.append(.amusementPark)
            case MKPointOfInterestCategory.atm:
                result.append(.atm)
            case MKPointOfInterestCategory.bakery:
                result.append(.bakery)
            case MKPointOfInterestCategory.bank:
                result.append(.bank)
            case MKPointOfInterestCategory.brewery:
                result.append(.brewery)
            case MKPointOfInterestCategory.cafe:
                result.append(.cafe)
            case MKPointOfInterestCategory.carRental:
                result.append(.carRental)
            case MKPointOfInterestCategory.evCharger:
                result.append(.evCharger)
            case MKPointOfInterestCategory.fireStation:
                result.append(.fireStation)
            case MKPointOfInterestCategory.fitnessCenter:
                result.append(.fitnessCenter)
            case MKPointOfInterestCategory.foodMarket:
                result.append(.foodMarket)
            case MKPointOfInterestCategory.gasStation:
                result.append(.gasStation)
            case MKPointOfInterestCategory.hospital:
                result.append(.hospital)
            case MKPointOfInterestCategory.hotel:
                result.append(.hotel)
            case MKPointOfInterestCategory.laundry:
                result.append(.laundry)
            case MKPointOfInterestCategory.library:
                result.append(.library)
            case MKPointOfInterestCategory.movieTheater:
                result.append(.movieTheater)
            case MKPointOfInterestCategory.museum:
                result.append(.museum)
            case MKPointOfInterestCategory.nightlife:
                result.append(.nightlife)
            case MKPointOfInterestCategory.park:
                result.append(.park)
            case MKPointOfInterestCategory.parking:
                result.append(.parking)
            case MKPointOfInterestCategory.pharmacy:
                result.append(.pharmacy)
            case MKPointOfInterestCategory.police:
                result.append(.police)
            case MKPointOfInterestCategory.postOffice:
                result.append(.postOffice)
            case MKPointOfInterestCategory.publicTransport:
                result.append(.publicTransport)
            case MKPointOfInterestCategory.restaurant:
                result.append(.restaurant)
            case MKPointOfInterestCategory.school:
                result.append(.school)
            case MKPointOfInterestCategory.store:
                result.append(.store)
            case MKPointOfInterestCategory.theater:
                result.append(.theater)
            case MKPointOfInterestCategory.university:
                result.append(.university)
            case MKPointOfInterestCategory.winery:
                result.append(.winery)
            case MKPointOfInterestCategory.aquarium:
                result.append(.aquarium)
            case MKPointOfInterestCategory.zoo:
                result.append(.zoo)
            default:
                break
            }
        }
        return result
    }
}
