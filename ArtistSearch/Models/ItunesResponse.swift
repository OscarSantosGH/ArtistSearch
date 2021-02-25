//
//  ItunesResponse.swift
//  ArtistSearch
//
//  Created by Oscar Santos on 2/24/21.
//

import Foundation

struct ItunesResponse: Decodable {
    let resultCount:Int
    let results: [Track]
}
