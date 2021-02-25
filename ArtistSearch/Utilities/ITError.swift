//
//  ITError.swift
//  ArtistSearch
//
//  Created by Oscar Santos on 2/25/21.
//

import Foundation

enum ITError: String, Error{
    case invalidName = "The name of the artist is invalid. Please try again with another artist."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case artistNotFound = "This artist doesn't appear in iTunes. Please try again with another artist."
}
