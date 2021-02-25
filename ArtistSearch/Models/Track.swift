//
//  Track.swift
//  ArtistSearch
//
//  Created by Oscar Santos on 2/24/21.
//

import Foundation

struct Track: Decodable{
    let artistName: String
    let trackName: String
    let releaseDate: String
    let primaryGenreName: String
    let trackPrice: Float
}
