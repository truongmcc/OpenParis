//
//  CreatorFactoryMethod.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 26/06/2021.
//

protocol CreatorFactoryMethod {
    func create(service: Service) -> DetailBaseViewProtocol
}

protocol DetailBaseViewProtocol {
    var service: Service? { get set }
}
