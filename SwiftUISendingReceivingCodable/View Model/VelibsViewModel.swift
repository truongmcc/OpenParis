//
//  VelibsViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 19/10/2020.
//

import Combine
import SwiftUI

class VelibsViewModel: ObservableObject {
    
    private var task: AnyCancellable?
    @Published var velibAnnotations = [GenericData]()
    @Published var velibSelected = [Velib]()
    @Published var annotations = [Annotation]()
    @Published var showingErrorAlert = false
    
    @Published var alertError: Alert?

    //    Version COMBINE
//    func fetchVelibs() {
        //        task = URLSession.shared.dataTaskPublisher(for: URL(string: UrlDataLocationEnum.allVelibs.rawValue)!)
        //            .map { $0.data }
        //            .decode(type: [Velib].self, decoder: JSONDecoder())
        //            .replaceError(with: [])
        //            .eraseToAnyPublisher()
        //            .receive(on: RunLoop.main)
        //            .assign(to: \VelibsViewModel.velibDatas, on: self)
        //    }
    
    func fetchVelibs() {
        MapServices.shared.loadData(url: UrlDataLocationEnum.allVelibs.rawValue, decodable: ResponseData.self, completion: { decodedResponse, error in
            if let dataResults = decodedResponse?.records {
                DispatchQueue.main.async {
                    self.velibAnnotations = dataResults
                    print("annotationDatas \(dataResults.count)")
                    self.createAnnotations(results: self.velibAnnotations)
                }
            }
            else {
                self.showingErrorAlert = true
                if let error = error?.localizedDescription {
                    self.alertError = Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("OK")) {
                        self.showingErrorAlert = false
                    })
                }
            }
        })
    }
    
    fileprivate func createAnnotations(results: [GenericData]) {
        annotations.removeAll()
        for annotation in results {
            DispatchQueue.main.async {
                self.annotations.append(Annotation(data: annotation))
            }
        }
    }
    

}
