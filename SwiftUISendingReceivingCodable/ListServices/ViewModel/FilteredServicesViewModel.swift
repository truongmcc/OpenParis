//
//  FilteredServicesViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 30/03/2021.
//

import SwiftUI
import Combine

class FilteredServicesViewModel: ObservableObject {
    var mapViewModel: MapViewModel
    @Published var searchText = ""
    var publisher: AnyCancellable?
    var filteredData: [ServiceAnnotation] = [ServiceAnnotation]()
    
    init(mapViewModel: MapViewModel, searchText: String) {
        self.mapViewModel = mapViewModel
        self.searchText = searchText
        self.publisher = self.$searchText
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
                    self.filteredData = self.mapViewModel.sortAnnotationFromUser() ?? []
                }
            })
    }
}


