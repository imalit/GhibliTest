//
//  GhibliViewModel.swift
//  ghibli
//
//  Created by Isiah Marie Ramos Malit on 2022-09-12.
//

import Foundation
import Combine
import SwiftUI

enum MovieState {
    case watched, toWatch, none
}

enum ViewState {
    case all, toWatch, watched
}

class GhibliListViewModel: ObservableObject {
    @Published var scrollableMovies = [PersonalizedMovie]()
    var viewState: ViewState? {
        didSet {
            min = 0
            currentPage = 1
            scrollableMovies = []
            fetchMore()
        }
    }
    
    var hasMoreItems : Bool {
        if !self.scrollableMovies.isEmpty {
            self.currentPage += 1
        }
        return min < filteredMovies.count
    }
    
    var personalizedMovies = [PersonalizedMovie]()
    let movieLimitPerPage = 3
    private var currentPage = 1
    private var min = 0
    private var ghibliCancellable: AnyCancellable?
    private var service: ServiceProtocol?
    private var filteredMovies = [PersonalizedMovie]()
    
    init(service: ServiceProtocol, state: ViewState) {
        self.service = service
        self.viewState = state
    }
    
    func getData(urlString: String) {
        self.ghibliCancellable = service?.fetchMovies(
            urlString: urlString
        ).sink(
            receiveCompletion: { _ in }, receiveValue: { (ghibliMovies: Ghibli) in
                self.setPersonalizedData(movies: ghibliMovies)
                self.fetchMore()
            }
        )
    }
    
    func fetchMore() {
        if !personalizedMovies.isEmpty {
            let max = currentPage * movieLimitPerPage
            filteredMovies = filterMovies()
            
            if filteredMovies.count <= movieLimitPerPage || (max > filteredMovies.count && min < max) {
                for index in min..<filteredMovies.count {
                    scrollableMovies.append(filteredMovies[index])
                }
            } else {
                for index in min..<max where max <= filteredMovies.count {
                    scrollableMovies.append(filteredMovies[index])
                }
            }
            min = max
        }
    }
    
    func filterMovies() -> [PersonalizedMovie] {
        switch viewState {
        case .all:
            return personalizedMovies
        case .toWatch:
            return personalizedMovies.filter{ $0.state == .toWatch }
        case .watched:
            return personalizedMovies.filter{ $0.state == .watched }
        case .none:
            return [PersonalizedMovie]()
        }
    }
}

private extension GhibliListViewModel {
    private func setPersonalizedData(movies: Ghibli) {
        for movie in movies {
            let personalizedMovie = PersonalizedMovie(
                ghibliMovie: movie,
                state: .none
            )
            personalizedMovies.append(personalizedMovie)
        }
    }
}
