//
//  Url.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 18/06/2021.
//

import Foundation

class UrlCreator {
    let urlString: String
    init(urlString: String) {
        self.urlString = urlString
    }
    func createUrlRequest() -> URLRequest? {
        guard let url = URL(string: self.urlString) else {
            return nil
        }
        return URLRequest(url: url)
    }
}
