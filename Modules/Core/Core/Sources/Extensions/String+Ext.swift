//
//  String+Ext.swift
//  Core
//
//  Created by Budi Darmawan on 11/12/21.
//

extension String {
  public func localized() -> String {
    let bundle = Bundle(identifier: "com.bd-drmwan.Core")!
    return bundle.localizedString(forKey: self, value: nil, table: nil)
  }
}
