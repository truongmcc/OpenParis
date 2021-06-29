//
//  ParametersView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 28/10/2020.
//

import SwiftUI
import MapKit

struct ParametersView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userSettings: UserSettings
    
    var onDismiss: () -> Void
    
    var body: some View {
        NavigationView {
            VStack() {
                addTypeService()
                NavigationLink(destination: PointsOfInterestsView().environmentObject(userSettings)) {
                    Text("Filtrer les points d'intérêts")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.secondary)
                .cornerRadius(6.0)
                Spacer()
                Text("Affichage")
                addTypeMapPicker()
                Spacer()
                Text("Rayon de recherche")
                addRayDistancePicker()
                Button("OK", action: {
                    self.presentationMode.wrappedValue.dismiss()
                })
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .font(.title)
                .padding()
                .onDisappear() {
                    onDismiss()
                }
            }
            .navigationTitle("Paramètres")
        }
        .accentColor(.white)
    }
    
    fileprivate func addRayDistancePicker() -> some View {
        return Picker(selection: self.$userSettings.rayOfDistance, label: Text("Rayons de recherche")) {
            Text("300 M").tag(300)
            Text("700 M").tag(700)
            Text("5 KM").tag(5000)
            Text("10 KM").tag(10000)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(10)
    }
    
    fileprivate func addTypeMapPicker() -> some View {
        return Picker(selection: self.$userSettings.mapType, label: Text("Type de plans")) {
            Text("Carte").tag(0)
            Text("Satellite").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(10)
    }
    
    fileprivate func addTypeService() -> some View {
        Picker("Services", selection: $userSettings.typeService) {
            ForEach(ServicesEnum.allCases) {
                Text($0.title()).tag($0)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .padding(10)
    }
}

struct MenuView_Previews: PreviewProvider {
    @State static var service = ServicesEnum.velib
    static var previews: some View {
        ParametersView( onDismiss: {} )
    }
}
