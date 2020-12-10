//
//  OptionsView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 28/10/2020.
//

import SwiftUI
import MapKit

struct OptionsView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @Binding var mapType: MKMapType
    @Binding var typeService: ServicesEnum
    @Binding var rayOfDistance: Int
    
    var onDismiss: () -> Void
    
    var body: some View {
        NavigationView {
        VStack() {
            Text("Affichage")
            addTypeMapPicker()
            
            addTypeService()
            
            Text("Rayon de recherche")
            addRayDistancePicker()
            
            NavigationLink(destination: PointsOfInterestsView()) {
                Text("Filtrer les points d'intérêts")
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.secondary)
            .cornerRadius(6.0)
            
            
            Button("OK", action: {
                self.presentationMode.wrappedValue.dismiss()
            })
            .foregroundColor(.white)
            .font(.title)
            .padding()
            
            .onDisappear() {
                onDismiss()
            }
        }
            .navigationTitle("PREFERENCES")
        
        }
    }
    
    fileprivate func addRayDistancePicker() -> some View {
        return Picker(selection: $rayOfDistance, label: Text("Rayons de recherche")) {
            Text("300 M").tag(300)
            Text("700 M").tag(700)
            Text("5 KM").tag(5000)
            Text("10 KM").tag(10000)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(10)
    }
    
    fileprivate func addTypeMapPicker() -> some View {
        return Picker(selection: $mapType, label: Text("Type de plans")) {
            Text("Carte").tag(MKMapType.standard)
            Text("Satellite").tag(MKMapType.satellite)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(10)
    }
    
    fileprivate func addTypeService() -> some View {
        Picker(selection: $typeService, label: Text("Services"), content: {
            Text("Velibs").tag(ServicesEnum.velib)
            Text("Trotinettes").tag(ServicesEnum.trotinette)
            Text("Sanisettes").tag(ServicesEnum.sanisette)
            Text("Fontaines").tag(ServicesEnum.fontaine)
            Text("Tri mobile").tag(ServicesEnum.triMobile)
            Text("Arbres remarquables").tag(ServicesEnum.arbreRemarquable)
            Text("Hotspots wifi").tag(ServicesEnum.wifiHotspot)
        })
        .pickerStyle(DefaultPickerStyle())
        .padding(10)
    }
}

struct MenuView_Previews: PreviewProvider {
    @State static var mapType = MKMapType.standard
    @State static var service = ServicesEnum.velib
    @State static var rayOfDistance = 10000
    static var previews: some View {
        OptionsView(mapType: $mapType, typeService: $service, rayOfDistance: $rayOfDistance, onDismiss: {} )
    }
}
