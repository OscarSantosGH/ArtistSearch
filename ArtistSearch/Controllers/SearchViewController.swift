//
//  ViewController.swift
//  ArtistSearch
//
//  Created by Oscar Santos on 2/24/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchArtistButton: UIButton!
    
    var tracksResponse = [Track]()
    var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchArtistButton.layer.cornerRadius = 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadingView = LoadingView(frame: self.view.bounds)
    }

    @IBAction func searchAction(_ sender: Any) {
        if let text = searchTextField.text, !text.isEmpty{
            let name = text.replacingOccurrences(of: " ", with: "+")
            searchArtist(withName: name)
        }
    }
    
    func searchArtist(withName name:String){
        view.addSubview(loadingView)
        NetworkManager.shared.getTracksByArtist(name) { [self] (result) in
            DispatchQueue.main.async{
                self.loadingView.removeFromSuperview()
                switch result{
                case .success(let tracks):
                    self.showTracks(tracks: tracks)
                case .failure(let error):
                    self.showError(error: error)
                }
            }
        }
    }
    
    func showTracks(tracks:[Track]){
        self.tracksResponse = tracks
        self.performSegue(withIdentifier: "toArtistTracks", sender: nil)
    }
    
    func showError(error:ITError){
        let alert = UIAlertController(title: "Something went wrong", message: error.rawValue, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toArtistTracks"{
            let destination = segue.destination as! TracksViewController
            destination.tracks = tracksResponse
            destination.title = searchTextField.text
        }
    }
}

