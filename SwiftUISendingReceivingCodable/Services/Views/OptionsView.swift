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
    
    var onDismiss: () -> Void

    var body: some View {
        VStack() {
            HStack {
                Text("OPTIONS")
                    .font(.title)
                    .padding()
            }
            
            Spacer()
            addTypeMap()
            Spacer()
            addTypeService()
            Spacer()
                
            Button("OK", action: {
                onDismiss()
                self.presentationMode.wrappedValue.dismiss()
            })
            .foregroundColor(.white)
            .font(.title)
            .padding()
            
            Spacer()
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
        Picker(selection: $typeService, label: Text("Services"), content: {
            Text("Velibs").tag(ServicesEnum.velib)
            Text("Trotinettes").tag(ServicesEnum.trotinette)
            Text("Sanisettes").tag(ServicesEnum.sanisette)
            Text("Fontaines").tag(ServicesEnum.fontaine)
            Text("Tri mobile").tag(ServicesEnum.triMobile)
            Text("Arbres remarquables").tag(ServicesEnum.arbreRemarquable)
        })
        .pickerStyle(DefaultPickerStyle())
        .padding(10)
    }
}

struct MenuView_Previews: PreviewProvider {
    @State static var mapType = MKMapType.standard
    @State static var service = ServicesEnum.velib
    static var previews: some View {
        OptionsView(mapType: $mapType, typeService: $service, onDismiss: {} )
    }
}
