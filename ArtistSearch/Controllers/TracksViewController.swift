//
//  TracksTableViewController.swift
//  ArtistSearch
//
//  Created by Oscar Santos on 2/24/21.
//

import UIKit

class TracksViewController: UIViewController {
    
    @IBOutlet weak var tracksTableView: UITableView!
    
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tracksTableView.dataSource = self
    }


}

// MARK: - Table view data source

extension TracksViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentTrack = tracks[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackViewCell.reusableID, for: indexPath) as! TrackViewCell
        cell.setup(with: currentTrack)
        return cell
    }
    
    
}
