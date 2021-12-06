//
//  ConvertDate.swift
//  Core
//
//  Created by Budi Darmawan on 05/12/21.
//

import Foundation

public final class ConvertDate {
  public static func formatDate(
    date: String,
    fromDateFormat: String = "yyyy-mm-dd",
    resultFormat: String = "DD MMM YYYY"
  ) -> String {
    let fromFormatter = DateFormatter()
    fromFormatter.dateFormat = fromDateFormat
    
    let resultFormatter = DateFormatter()
    resultFormatter.dateFormat = resultFormat
    
    let newDate = fromFormatter.date(from: date)
    
    return newDate != nil ? resultFormatter.string(from: newDate!) : date
  }
}
