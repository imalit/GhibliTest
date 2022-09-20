//
//  GhibliModel.swift
//  ghibli
//
//  Created by Isiah Marie Ramos Malit on 2022-09-12.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ghibli = try? newJSONDecoder().decode(Ghibli.self, from: jsonData)

import Foundation

// MARK: - GhibliElement
struct GhibliElement: Codable {
    let id, title, originalTitle, originalTitleRomanised: String
    let image, movieBanner: String
    let ghibliDescription, director, producer, releaseDate: String
    let runningTime, rtScore: String
    let people, species, locations, vehicles: [String]
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case originalTitle = "original_title"
        case originalTitleRomanised = "original_title_romanised"
        case image
        case movieBanner = "movie_banner"
        case ghibliDescription = "description"
        case director, producer
        case releaseDate = "release_date"
        case runningTime = "running_time"
        case rtScore = "rt_score"
        case people, species, locations, vehicles, url
    }
}

typealias Ghibli = [GhibliElement]

class PersonalizedMovie {
    let ghibliMovie: GhibliElement
    var state: MovieState
    
    init(movie: GhibliElement, state: MovieState) {
        self.ghibliMovie = movie
        self.state = state
    }
}
