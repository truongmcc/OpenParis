//
//  ContentView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 23/07/2020.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var map: MKMapView?
    @State var velibSelected: Velib?
    @State var showingErrorAlert = false
    @State var alertError: Alert?
    
    @State private var mapType = 0
    @State var showMenuView = false
    
    fileprivate func addMenuButton() -> some View {
        return
            GeometryReader { geometryReader in
                Button("Options", action: {
                    showMenuView.toggle()
                })
                .foregroundColor(.primary)
                .padding(20)
                .frame(width: geometryReader.size.width, height: geometryReader.size.height, alignment: .topTrailing)
            }
    }
    
    var body: some View {
        ZStack {
            
            MapView(showingErrorAlert: $showingErrorAlert,
                    velibSelected: $velibSelected, alertError: $alertError, mapType: $mapType)
            
            if velibSelected != nil {
                DetailVelibView(velibSelected: velibSelected)
            }
        
            addMenuButton()
   
        }
        .onTapGesture {
            velibSelected = nil
        }
        
        .alert(isPresented: $showingErrorAlert) {
            return (alertError ?? Alert(title: Text("Erreur")))
        }
        
        .sheet(isPresented: $showMenuView) {
            MenuView(mapType: $mapType)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
