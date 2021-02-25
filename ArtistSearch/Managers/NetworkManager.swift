//
//  NetworkManager.swift
//  ArtistSearch
//
//  Created by Oscar Santos on 2/24/21.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init(){}
    
    let baseURL = "https://itunes.apple.com/search?term="
    let musicParameter = "&media=music"
    
    func getTracksByArtist(_ artist:String, closure: @escaping (Result<[Track],ITError>)->()){
        let endpoint = baseURL + artist + musicParameter
        guard let url = URL(string: endpoint) else {
            closure(.failure(.invalidName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                closure(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                closure(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                closure(.failure(.invalidData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do{
                let itunesResponse = try decoder.decode(ItunesResponse.self, from: data)
                if itunesResponse.resultCount == 0{
                    closure(.failure(.artistNotFound))
                }else{
                    closure(.success(itunesResponse.results))
                }
            }catch{
                closure(.failure(.unableToComplete))
            }
            
        }
        
        task.resume()
        
    }
}
