//
//  CommonCrypto.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/24.
//

import Foundation
import CommonCrypto

extension String {
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
    var convertToHttps: String {
        var url = self
        let zerothIndex = url.startIndex
        let fourthIndex = url.index(zerothIndex, offsetBy: 4)
        
        if (url[zerothIndex...fourthIndex] == "http:") {
            url.insert("s", at: fourthIndex)
            return url
        } else {
            return url
        }
        
    }
    
    func buildImageURL(quality: String, imageExtension: String) -> String {
        let imagePath = self
        let comicThumbnailURL = "\(imagePath)/\(quality).\(imageExtension)"
        
        return comicThumbnailURL
    }
}


extension String? {
    var hasValue: Bool {
        return !(self == nil || self == "")
    }
}
