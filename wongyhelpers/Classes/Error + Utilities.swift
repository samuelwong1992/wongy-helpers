//
//  Error + Utilities.swift
//  wongyhelpers
//
//  Created by Samuel Wong on 28/6/21.
//

import Foundation

extension NSError {
    static func standardErrorWithString(errorString: String) -> NSError {
        return NSError(domain: Bundle.main.bundleIdentifier!, code: 0, userInfo: [NSLocalizedDescriptionKey : errorString])
    }
    
    static func standardNoDataError() -> Error {
        return NSError.standardErrorWithString(errorString: "No data was returned for this request.")
    }
}
