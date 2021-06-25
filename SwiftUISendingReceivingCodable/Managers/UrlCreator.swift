//
//  Url.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 18/06/2021.
//

import Foundation

class UrlCreator {
    func createUrlRequest(urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        return URLRequest(url: url)
    }
}
