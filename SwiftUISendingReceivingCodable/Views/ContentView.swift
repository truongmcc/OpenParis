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
    
    var body: some View {
        ZStack {
            MapView(showingErrorAlert: $showingErrorAlert,
                    velibSelected: $velibSelected, alertError: $alertError
                    )
            if velibSelected != nil {
                DetailVelibView(velibSelected: velibSelected)
            }
        }

        .onTapGesture {
            velibSelected = nil
        }
        
        .alert(isPresented: $showingErrorAlert) {
            return (alertError ?? Alert(title: Text("Erreur")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
