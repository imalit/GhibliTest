//
//  GhibliViewModel.swift
//  ghibli
//
//  Created by Isiah Marie Ramos Malit on 2022-09-12.
//

import Foundation
import Combine
import SwiftUI

class GhibliListViewModel: ObservableObject {
    @Published var scrollableMovies = Ghibli()
    var movies = Ghibli()
    var movieLimitPerPage = 3
    private var currentPage = 1
    private var min = 0
    private var ghibliCancellable: AnyCancellable?
    private var service: ServiceProtocol?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func getData(urlString: String) {
        self.ghibliCancellable = service?.fetchMovies(
            urlString: urlString
        ).sink(
            receiveCompletion: { _ in }, receiveValue: { (ghibliMovies: Ghibli) in
                self.movies = ghibliMovies
                self.fetchMore()
            }
        )
    }
    
    func fetchMore() {
        if !movies.isEmpty {
            let max = currentPage * movieLimitPerPage
            if movies.count <= movieLimitPerPage || (max > movies.count && min < max) {
                for index in min..<movies.count {
                    scrollableMovies.append(self.movies[index])
                }
            } else {
                for index in min..<max where max <= movies.count {
                    scrollableMovies.append(self.movies[index])
                }
            }
            min = max
        }
    }
    
    func hasMoreItems() -> Bool {
        if !self.scrollableMovies.isEmpty {
            self.currentPage += 1
        }
        return min <= movies.count
    }
}
