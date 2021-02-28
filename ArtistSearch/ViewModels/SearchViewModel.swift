//
//  SearchViewModel.swift
//  ArtistSearch
//
//  Created by Oscar Santos on 2/27/21.
//

import UIKit
import Combine

class SearchViewModel: ObservableObject{
    
    @Published var isLoading:Bool = false
    var tracksResponse = PassthroughSubject<[Track], Never>()
    var errorAlert = PassthroughSubject<UIAlertController, Never>()
    
    func onEvent(event: Event){
        switch event{
        case .onSearch(let name):
            onSearch(artistName: name)
        }
    }
    
    private func onSearch(artistName: String?){
        guard let name = artistName else {return}
        let fixName = name.replacingOccurrences(of: " ", with: "+")
        
        isLoading = true
        NetworkManager.shared.getTracksByArtist(fixName) { [self] (result) in
            DispatchQueue.main.async{
                isLoading = false
                switch result{
                case .success(let tracks):
                    self.tracksResponse.send(tracks)
                case .failure(let error):
                    let alert = UIAlertController(title: "Something went wrong", message: error.rawValue, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(okAction)
                    self.errorAlert.send(alert)
                }
            }
        }
        
    }
    
    enum Event{
        case onSearch(artistName: String?)
    }
    
}
