//
//  ContentView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 23/07/2020.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var showingDetails = false
    @State var velibSelected: Velib?
    @State private var showingErrorAlert = false
    @State var alertError: Alert?
    @State var map: MKMapView?

    var body: some View {
        ZStack {
            MapView(showingDetails: $showingDetails,
                    showingErrorAlert: $showingErrorAlert,
                    velibSelected: $velibSelected
                    )
            if showingDetails == true {
                DetailVelibView(velibSelected: velibSelected)
            }
        }

        .onTapGesture {
            showingDetails = false
        }
        
        .alert(isPresented: $showingErrorAlert) {
            return (alertError ?? Alert(title: Text("Erreur")))
        }
        
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification,
                                                   object: nil,
                                                   queue: .main) { (notification) in
                //annotations.removeAll()
            }
        }

    }
    
//    fileprivate func loadMap() {
//        MapServices.shared.loadData(url: UrlDataLocationEnum.allVelibs.rawValue, decodable: ResponseData.self, completion: { decodedResponse, error in
//            if let dataResults = decodedResponse?.velibs {
//                results = dataResults
//                print("results \(results.count)")
//                createAnnotations(results: results)
//            }
//            else {
//                showingErrorAlert = true
//                if let error = error?.localizedDescription {
//                    alertError = Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("OK")) {
//                        self.showingErrorAlert = false
//                    })
//                }
//            }
//        })
//    }
    
//    fileprivate func createAnnotations(results: [GenericData]) {
//        annotations.removeAll()
//        for annotation in results {
//            DispatchQueue.main.async {
//                annotations.append(Annotation(data: annotation))
//            }
//        }
//    }
    
    //    func createAnnotations(results: [Velib]) {
    //        for annotation in results {
    //            DispatchQueue.main.async {
    //                annotations.append(Annotation(velib: annotation))
    //            }
    //        }
    //    }
}

/// GESTION PAR LISTE
//struct ContentView: View {
//    @State private var results = [Velib]()
//
//    var body: some View {
//        List(results, id: \.velibId) { item in
//            VStack(alignment: .leading) {
//                if let id = item.detailVelib.name {
//                Text(id)
//                    .font(.headline)
//                }
//            }
//        }.onAppear {
//            getData("https://opendata.paris.fr/api/records/1.0/search/?dataset=velib-disponibilite-en-temps-reel&q=&facet=name&facet=is_installed&facet=is_renting&facet=is_returning&facet=nom_arrondissement_communes")
//        }
//    }

//    
//    func createUrl(url: String) -> URLRequest? {
//        guard let url = URL(string: url) else {
//            print("Invalid URL")
//            return nil
//        }
//        return URLRequest(url: url)
//
//    }
//    
//    // NON GENERIC VERSION (SANS CODABLE)
//    func loadData() {
//        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
//            print("Invalid URL")
//            return
//        }
//        let request = URLRequest(url: url)
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            
//            if let data = data {
//                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                    // we have good data – go back to the main thread
//                    DispatchQueue.main.async {
//                        // update our UI
//                        if let datas = decodedResponse.velibs {
//                            self.results = datas
//                        }
//                    }
//                    
//                    // everything is good, so we can exit
//                    return
//                }
//            }
//            
//            // if we're still here it means there was a problem
//            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
//            
//        }.resume()
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
