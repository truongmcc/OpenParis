//
//  MenuView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 28/10/2020.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var mapType: Int
    
    var body: some View {
        VStack() {
            HStack {
                addMenuText()
                
                Spacer()
                
                addButtonOk()
                .foregroundColor(.white)
                .font(.title)
                .padding()
            }
            
            addTypeMap()
            
        }
    }
    
    fileprivate func addMenuText() -> some View {
        return Text("MENU")
            .font(.title)
            .padding()
    }
    
    fileprivate func addButtonOk() -> Button<Text> {
        return Button("OK", action: {
            self.presentationMode.wrappedValue.dismiss()
        })
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
    static var previews: some View {
        MenuView(mapType: $mapType)
    }
}
