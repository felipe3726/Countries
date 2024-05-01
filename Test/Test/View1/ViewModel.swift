//
//  ViewModel.swift
//  Test
//
//  Created by Felipe Martinez on 30/04/24.
//

import Foundation

class MoviesViewModel {
    var countries: [CountryInfo] = []
    var errorMessage: String?
    
    func fetchMovies(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://restcountries.com/v3.1/all?fields=name,flags") else {
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
                self.countries = try decoder.decode([CountryInfo].self, from: data)
            } catch {
                self.errorMessage = "Failed to decode data: \(error.localizedDescription)"
            }
            
            completion()
        }
        
        dataTask.resume()
    }
}

