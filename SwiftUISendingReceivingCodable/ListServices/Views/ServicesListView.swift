//
//  ServicesListView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 25/03/2021.
//  https://www.swiftcompiled.com/building-a-search-bar-with-swiftui-and-combine/

import SwiftUI
import Combine

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0
}

struct ServicesListView<Content: View>: View {
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    var mapView: MapView
    var filteredServices: FilteredServicesViewModel?
    @State var searchText = ""
    @Binding var isOpen: Bool
    @ObservedObject var serviceViewModel: ServiceViewModel
    @GestureState private var translation: CGFloat = 0
    
    init(isOpen: Binding<Bool>, mapView: MapView, serviceViewModel: ServiceViewModel, maxHeight: CGFloat,
         @ViewBuilder content: () -> Content) {
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
        
        self.mapView = mapView
        self.serviceViewModel = serviceViewModel
        self.filteredServices = FilteredServicesViewModel(mapViewModel: self.mapView.mapViewModel, searchText: self.searchText)
    }
    
    func update() {
        
    }
   
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator.padding()
                self.content
                HStack(spacing: 8) {
                    TextField("Search...", text: $searchText)
                }
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                List {
                    ForEach(
                        filteredServices?.filteredData ?? self.mapView.mapViewModel.annotations, id: \.self) { annotation in
                        if let annot = annotation as ServiceAnnotation {
                            addServiceCellView(annotation: annot)
                                .onTapGesture {
                                self.isOpen = false
                                    mapView.showAnnotationDetail(recordId: annot.id!)
                                    mapView.mapViewModel.centerCoordinate = annot.coordinate
                                    mapView.mapViewModel.centerOnAnnotation.toggle()
                            }
                        }
                    }
                }
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(Constants.radius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * Constants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
    
    fileprivate func addServiceCellView(annotation: ServiceAnnotation) -> ServiceCellView {
        var ref: String?
        if let name = annotation.name {
            ref = name
        } else if let adresse = annotation.adresse {
            ref = adresse
        }
        return ServiceCellView(keySearch: ref!)
    }
    
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }
    
    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color.secondary)
            .frame(
                width: Constants.indicatorWidth,
                height: Constants.indicatorHeight
            )
    }
}


