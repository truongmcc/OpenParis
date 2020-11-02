//
//  MenuView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 28/10/2020.
//

import SwiftUI

struct OptionsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var mapType: Int
    @Binding var service: ServicesEnum
    
    fileprivate func addMobiliteService(name: String) -> some View {
        return Button(name, action: {
            if name == "Velibs" {
                service = .velib
            } else {
                service = .trotinettes
            }
            self.presentationMode.wrappedValue.dismiss()
        })
        .foregroundColor(.white)
        .padding()
    }
    
    var body: some View {
        VStack() {
            HStack {
                addMenuText()
                Spacer()
                addButtonOk()
            }
            
            addTypeMap()
            
            HStack {
                addMobiliteService(name: "Velibs")
                Spacer()
                addMobiliteService(name: "Trotinettes")
            }
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    
    fileprivate func addMenuText() -> some View {
        return Text("MENU")
            .font(.title)
            .padding()
    }
    
    fileprivate func addButtonOk() -> some View {
        return Button("OK", action: {
            self.presentationMode.wrappedValue.dismiss()
        })
        .foregroundColor(.white)
        .font(.title)
        .padding()
    }
    
    fileprivate func addTypeMap() -> some View {
        return Picker(selection: $mapType, label: Text("Type de plans")) {
            Text("Carte").tag(0)
            Text("Satellite").tag(1)
        }.pickerStyle(SegmentedPickerStyle())
        .padding(10)
    }
}

struct MenuView_Previews: PreviewProvider {
    @State static var mapType = 0
    @State static var showMenuView = false
    @State static var service = ServicesEnum.velib
    static var previews: some View {
        OptionsView(mapType: $mapType, service: $service)
    }
}
