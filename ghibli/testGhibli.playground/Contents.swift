import UIKit
import Combine

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

guard let url = URL(string: "https://ghibliapi.herokuapp.com/films") else {
    fatalError("Invalid URL")
}

let publisher = URLSession.shared.dataTaskPublisher(for: url)
    .print()
    .map(\.data)
    .decode(type: [GhibliElement].self, decoder: JSONDecoder())
    .sink(receiveCompletion: { _ in }, receiveValue: {
        print($0)
    })
