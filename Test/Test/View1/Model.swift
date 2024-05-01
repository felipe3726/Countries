//
//  Model.swift
//  Test
//
//  Created by Felipe Martinez on 30/04/24.
//

import Foundation

struct Flag: Codable {
    let png: URL?
    let svg: URL?
    let alt: String?
}

struct CountryName: Codable{
    let common: String?
    let official: String?
    let nativeName: NativeName?
    
    struct NativeName: Codable {
        let ron: NativeNameDetail?
        
        struct NativeNameDetail: Codable {
            let official: String?
            let common: String?
        }
    }
}

struct CountryInfo: Codable {
    let flags: Flag?
    let name: CountryName?
}
