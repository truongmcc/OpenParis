//
//  ListServiceViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 30/03/2021.
//

import SwiftUI
import Combine

struct DetailService: Hashable  {
    var id: Int
    var name: String
}

class ListServiceViewModel: ObservableObject {
    @ObservedObject var mapViewModel: MapViewModel
    @Published var searchText = ""
    var publisher: AnyCancellable?
    var filteredData: [ServiceAnnotation] = [ServiceAnnotation]()
    
    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
        self.publisher = $searchText
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (annotation) in
                if !self.searchText.isEmpty {
                    self.filteredData = self.mapViewModel.annotations.filter {
                        if let name = $0.name {
                            return name.contains(annotation)
                        } else { return false }
                    }
                } else {
                    self.filteredData = self.mapViewModel.annotations
                }
            })
    }
}

