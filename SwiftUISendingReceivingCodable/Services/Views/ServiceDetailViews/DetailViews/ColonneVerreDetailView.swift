//
//  ColonneVerreDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 26/05/2021.
//

import SwiftUI

struct ConcreteColonneVerreDetailView: CreatorFactoryMethod {
    func create(service: Service?) -> DetailBaseViewProtocol? {
        return ColonneVerreDetailView(service: service as! ColonneVerre)
    }
}

struct ColonneVerreDetailView: View, DetailBaseViewProtocol {
    
    var service: Service?
    var colonneVerre: ColonneVerre {
        return service as! ColonneVerre
    }
    
    var body: some View {
        VStack(alignment: .center) {
            TitleTextView(title: colonneVerre.fields?.adresse)
        }
    }
}

struct ColonneVerreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ColonneVerreDetailView()
    }
}
