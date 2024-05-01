//
//  ViewModelDetail.swift
//  Test
//
//  Created by Felipe Martinez on 30/04/24.
//

import UIKit

class DetailViewModel {
    var countries: [CountryDetail] = []
    var errorMessage: String?
    
    func fetchMovies(country:String, completion: @escaping () -> Void) {
        guard let url = URL(string: "https://restcountries.com/v3.1/name/\(country)") else {
            self.errorMessage = "Invalid URL"
            completion()
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion()
                return
            }
            
            guard let data = data else {
                self.errorMessage = "No data received"
                completion()
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self.countries = try decoder.decode([CountryDetail].self, from: data)
            } catch {
                self.errorMessage = "Failed to decode data: \(error.localizedDescription)"
            }
            
            completion()
        }
        
        dataTask.resume()
    }
    
    func fetchCountryInfo(url: URL, completion: @escaping (Result<[CountryDetail], Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let countryInfo = try JSONDecoder().decode([CountryDetail].self, from: data)
                completion(.success(countryInfo))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
