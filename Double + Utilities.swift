//
//  Double + Utilities.swift
//  wongyhelpers
//
//  Created by Samuel Wong on 28/6/21.
//

extension Double {
    static func selfOrNA(double: Double?) -> String {
        if double == nil { return "N/A" }
        if double == 0 { return "N/A" }
        return "\(double!)"
    }
}
