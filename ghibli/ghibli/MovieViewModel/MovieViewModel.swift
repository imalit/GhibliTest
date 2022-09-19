//
//  MovieViewModel.swift
//  ghibli
//
//  Created by Isiah Marie Ramos Malit on 2022-09-12.
//

import Foundation
import Combine
import SwiftUI

class MovieViewModel: ObservableObject {
    @Published var toWatch: Bool
    @Published var watched: Bool
    
    var movie: PersonalizedMovie

    init(movie: PersonalizedMovie) {
        self.movie = movie
        self.toWatch = movie.state == .toWatch
        self.watched = movie.state == .watched
    }
    
    func toggle(state: MovieState) {
        switch state {
        case .watched:
            watched = !watched
            movie.state = watched ? .watched : .none
        case .toWatch:
            toWatch = !toWatch
            movie.state = toWatch ? .toWatch : .none
        default:
            break
        }
    }
}

