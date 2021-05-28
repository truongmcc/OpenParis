//
//  ServicesListView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 25/03/2021.
//  https://www.swiftcompiled.com/building-a-search-bar-with-swiftui-and-combine/

import SwiftUI
import Combine

struct ServicesListView: View {
    @ObservedObject var mapViewModel: MapViewModel
    @ObservedObject var listServiceViewModel: ListServiceViewModel
    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
        self.listServiceViewModel = ListServiceViewModel(mapViewModel: mapViewModel)
    }
    
    var body: some View {
        return VStack {
            HStack(spacing: 8) {
                TextField("Search...", text: $listServiceViewModel.searchText)
            }
            .padding(.top, 10)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            List {
                ForEach(
                    listServiceViewModel.filteredData, id: \.self) { annotation in
                    if let annot = annotation as ServiceAnnotation {
                        if let name = annot.name {
                            NavigationLink(name, destination: ServiceCellView(keySearch: name))
                        
                        } else if let adresse = annot.adresse {
                            NavigationLink(adresse, destination: ServiceCellView(keySearch: adresse))
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Services")
    }
}


struct ServicesListView_Previews: PreviewProvider {
    var list: ListServiceViewModel
    static var previews: some View {
        ServicesListView(mapViewModel: MapViewModel())
    }
}
