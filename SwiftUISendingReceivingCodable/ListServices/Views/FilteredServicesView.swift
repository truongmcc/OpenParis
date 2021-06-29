//
//  FilteredServicesView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 25/03/2021.
//  https://www.swiftcompiled.com/building-a-search-bar-with-swiftui-and-combine/

import SwiftUI
import Combine

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 2
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0
}

protocol ServiceAnnotationProtocol {
    var serviceAnnotations: [ServiceAnnotation] { get set }
}

struct FilteredServicesView<Content: View>: View, ServiceAnnotationProtocol {
    var serviceAnnotations: [ServiceAnnotation]
    
    let content: Content
    let maxHeight: CGFloat
    let minHeight: CGFloat
    private var mapView: MapView
    
    //MARK: Computed Properties
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
    //MARK: Property Wrappers
    @State private var searchText = ""
    @Binding var isOpen: Bool
    @GestureState private var translation: CGFloat = 0
    
    init(isOpen: Binding<Bool>, mapView: MapView, maxHeight: CGFloat,
         @ViewBuilder content: () -> Content) {
        self._isOpen = isOpen
        self.content = content()
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.maxHeight = maxHeight
        self.mapView = mapView
        self.serviceAnnotations = mapView.mapViewModel.annotations
    }
    
    var body: some View {
        let bindingSearch = Binding<String>(
            get: {
                self.searchText.uppercased()
            }, set: {
                self.searchText = $0.uppercased()
            })
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator.padding()
                self.content
                HStack(spacing: 8) {
                    TextField("Search...", text: bindingSearch)
                        .padding(.bottom)
                }
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                List {
                    ForEach(
                        self.serviceAnnotations, id: \.self) { annotation in
                        if let annot = annotation as ServiceAnnotation {
                            if searchText == "" || annot.name?.contains(searchText) == true {
                                createAnnotationCell(annot)
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
    
    fileprivate func createAnnotationCell(_ annot: ServiceAnnotation) -> some View {
        return FilteredServiceCell(annotation: annot)
            .onTapGesture {
                self.isOpen = false
                mapView.showAnnotationDetail(recordId: annot.id!)
                mapView.mapViewModel.centerCoordinate = annot.coordinate
                mapView.mapViewModel.centerOnAnnotation.toggle()
            }
    }
}


