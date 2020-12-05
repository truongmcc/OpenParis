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
        VStack() {
            HStack {
                Text("OPTIONS")
                    .font(.title)
                    .padding()
            }
            
            Text("Affichage")
            addTypeMapPicker()
            
            addTypeService()
            
            Text("Rayon de recherche")
            addRayDistancePicker()
            
            Spacer()
            
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
    }
    
    fileprivate func addRayDistancePicker() -> some View {
        return Picker(selection: $rayOfDistance, label: Text("Rayons de recherche")) {
            Text("100 M").tag(100)
            Text("500 m").tag(500)
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
    
    fileprivate func addTypeService()  -> some View {
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
    @State static var rayOfDistance = 50
    static var previews: some View {
        OptionsView(mapType: $mapType, typeService: $service, rayOfDistance: $rayOfDistance, onDismiss: {} )
    }
}
