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
    @Binding var service: Services
    var onDismiss: () -> Void

    var body: some View {
        VStack() {
            HStack {
                Text("MENU")
                    .font(.title)
                    .padding()
                Spacer()
            }
            
            addTypeMap()
            
            addTypeService()
            
            Button("OK", action: {
                onDismiss()
                self.presentationMode.wrappedValue.dismiss()
            })
            .foregroundColor(.white)
            .padding()
        }
    }
    
    fileprivate func addTypeMap() -> some View {
        return Picker(selection: $mapType, label: Text("Type de plans")) {
            Text("Carte").tag(MKMapType.standard)
            Text("Satellite").tag(MKMapType.satellite)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(10)
    }
    
    fileprivate func addTypeService()  -> some View {
        Picker(selection: $service, label: Text("Services"), content: {
            Text("Velibs").tag(Services.velib)
            Text("Trotinettes").tag(Services.trotinette)
            Text("Sanisettes").tag(Services.sanisette)
            Text("Fontaines").tag(Services.fontaine)
            Text("Tri mobile").tag(Services.triMobile)
        })
        .pickerStyle(SegmentedPickerStyle())
        .padding(10)
    }
}

struct MenuView_Previews: PreviewProvider {
    @State static var mapType = MKMapType.standard
    @State static var service = Services.velib
    static var previews: some View {
        OptionsView(mapType: $mapType, service: $service, onDismiss: {} )
    }
}
