//
//  VelibsViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 19/10/2020.
//

import Combine
import SwiftUI

class VelibsViewModel: ObservableObject {
    //private var task: AnyCancellable? // Combine
    @Published var velibAnnotations = [AnnotationDatas]()
    @Published var velibSelected = [Velib]()
    @Published var annotations = [Annotation]()
    //@Published var showingErrorAlert = false
    //@Published var alertError: Alert?
}

// MARK: WebServices methods
extension VelibsViewModel {
    
    func fetchVelibs(completion:  @escaping([AnnotationDatas]?, Error?) -> Void) {
        MapServices.shared.loadData(url: UrlDataLocationEnum.allVelibs.rawValue, decodable: ResponseAnnotationDatas.self, completion: { decodedResponse, error in
            if let dataResults = decodedResponse?.records {
                DispatchQueue.main.async {
                    self.velibAnnotations = dataResults
                    completion(self.velibAnnotations, nil)
                }
            }
            else {
                completion(nil, error)
            }
        })
    }
    
    func fetchVelibsWithTypeResult(completion: @escaping (Result<ResponseAnnotationDatas, NetworkError>) -> Void) {
        MapServices.shared.loadDataWithTypeResult(url: UrlDataLocationEnum.allVelibs.rawValue, decodable: ResponseAnnotationDatas.self) {
            result in
            completion(result)
        }
    }
    
    func getVelib(_ url: String, completion:  @escaping([Velib]?, Error?) -> Void) {
        MapServices.shared.loadData(url: url,
                                    decodable: VelibResponse.self) { decodedResponse, error in
            if let dataResults = decodedResponse?.records {
                completion(dataResults, nil)
            } else { // si échec, recharger la map au cas ou les recordId ont été raffraichis sur le serveur
                MapServices.shared.loadData(url: UrlDataLocationEnum.allVelibs.rawValue, decodable: ResponseAnnotationDatas.self, completion: { decodedResponse, error in
                    MapServices.shared.loadData(url: url,
                                                decodable: VelibResponse.self) { decodedResponse, error in
                        if let dataResults = decodedResponse?.records {
                            completion(dataResults, nil)
                        } else {
                            completion(nil, error)
                        }
                    }
                })
            }
        }
    }
    
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
    
}
