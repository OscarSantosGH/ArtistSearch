//
//  ViewController.swift
//  ArtistSearch
//
//  Created by Oscar Santos on 2/24/21.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchArtistButton: UIButton!
    
    var loadingView: LoadingView!
    
    var viewModel = SearchViewModel()
    private var cancelables: Set<AnyCancellable> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchArtistButton.layer.cornerRadius = 10
        loadingView = LoadingView(frame: self.view.bounds)
        
        bindViewModel()
    }
    
    private func bindViewModel(){
        viewModel.$isLoading.sink(receiveValue: { [self] (isLoading) in
            if isLoading {
                self.view.addSubview((self.loadingView)!)
            }else{
                if self.view.subviews.contains(self.loadingView) {
                    self.loadingView.removeFromSuperview()
                }
            }
        }).store(in: &cancelables)
        
        viewModel.tracksResponse.sink { [self] (tracks) in
            self.performSegue(withIdentifier: "toArtistTracks", sender: tracks)
        }.store(in: &cancelables)
        
        viewModel.errorAlert.sink { [self] (alert) in
            self.present(alert, animated: true)
        }.store(in: &cancelables)
    }

    @IBAction func searchAction(_ sender: Any) {
        viewModel.onEvent(event: .onSearch(artistName: searchTextField.text))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toArtistTracks"{
            let destination = segue.destination as! TracksViewController
            if sender is [Track]{
                destination.tracks = sender as! [Track]
                destination.title = searchTextField.text
            }
        }
    }
}

