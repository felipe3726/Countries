//
//  DetailModel.swift
//  Test
//
//  Created by Felipe Martinez on 30/04/24.
//

import Foundation

struct CountryDetail: Codable {
    let name: Name
    let tld: [String]
    let cca2: String
    let ccn3: String
    let cca3: String
    let cioc: String
    let independent: Bool
    let status: String
    let unMember: Bool
    let currencies: [String: Currency]
    let idd: IDD
    let capital: [String]
    let altSpellings: [String]
    let region: String
    let subregion: String
    let languages: [String: String]
    let translations: [String: Translation]
    let latlng: [Double]
    let landlocked: Bool
    let borders: [String]
    let area: Int
    let demonyms: [String: Demonym]
    let flag: String
    let maps: Maps
    let population: Int
    let gini: [String: Double]
    let fifa: String
    let car: Car
    let timezones: [String]
    let continents: [String]
    let flags: Flag
    let coatOfArms: CoatOfArms
    let startOfWeek: String
    let capitalInfo: CapitalInfo
    let postalCode: PostalCode
    
    struct Name: Codable{
        let common: String
        let official: String
        let nativeName: NativeName
        
        struct NativeName: Codable {
            let ron: RON
            
            struct RON: Codable {
                let official: String
                let common: String
            }
        }
    }
    
    struct Currency: Codable {
        let name: String
        let symbol: String
    }
    
    struct IDD: Codable {
        let root: String
        let suffixes: [String]
    }
    
    struct Translation: Codable {
        let official: String
        let common: String
    }
    
    struct Demonym: Codable {
        let f: String
        let m: String
    }
    
    struct Maps: Codable {
        let googleMaps: String
        let openStreetMaps: String
    }
    
    struct Car: Codable {
        let signs: [String]
        let side: String
    }
    
    struct Flag: Codable {
        let png: URL
        let svg: URL
        let alt: String
    }
    
    struct CoatOfArms: Codable {
        let png: URL
        let svg: URL
    }
    
    struct CapitalInfo: Codable {
        let latlng: [Double]
    }
    
    struct PostalCode: Codable {
        let format: String
        let regex: String
    }
}
