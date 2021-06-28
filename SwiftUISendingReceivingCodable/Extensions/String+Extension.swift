//
//  String+Extension.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 28/11/2020.
//

import Foundation

extension String {
    
    func formatDateDMY(date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let convertedDate = dateFormatter.date(from:self)!
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: convertedDate)
    }
}
