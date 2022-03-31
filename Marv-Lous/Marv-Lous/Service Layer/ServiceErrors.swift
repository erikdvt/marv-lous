//
//  ServiceErrors.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/30.
//

import Foundation

enum CustomError: String, Error {
    case invalidResponse
    case invalidRequest
    case invalidUrl
    case invalidData
    case internalError
    case parsingError
}
