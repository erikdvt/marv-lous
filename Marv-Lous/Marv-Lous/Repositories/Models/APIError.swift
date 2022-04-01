//
//  APIError.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/24.
//

import Foundation

struct APIError: Codable {
    let code: String?
    let message: String?
}
