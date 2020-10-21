//
//  VelibsViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 19/10/2020.
//

//import Combine
import SwiftUI

class VelibsViewModel: ObservableObject {
    //private var task: AnyCancellable? // Combine
    @Published var velibAnnotations = [AnnotationDatas]()
    @Published var velibSelected = [Velib]()
    @Published var annotations = [Annotation]()
}
