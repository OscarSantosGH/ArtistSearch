//
//  TrackViewCell.swift
//  ArtistSearch
//
//  Created by Oscar Santos on 2/24/21.
//

import UIKit

class TrackViewCell: UITableViewCell {
    
    @IBOutlet weak var trackReleaseLabel: UILabel!
    @IBOutlet weak var artistGenreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let reusableID = "trackCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        priceLabel.layer.borderWidth = 2
        priceLabel.layer.borderColor = UIColor.systemBlue.cgColor
        priceLabel.layer.cornerRadius = 10
        
    }
    
    func setup(with track:Track){
        trackReleaseLabel.text = track.trackName + " - " + TrackDateFormatter.format(track.releaseDate)
        artistGenreLabel.text = track.artistName + " - " + track.primaryGenreName
        priceLabel.text = "$" + String(track.trackPrice)
    }

}
