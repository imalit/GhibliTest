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
    @Published var scrollableMovies: Ghibli = []
    private var movies = Ghibli()
    private var movieLimitPerPage = 3
    private var currentPage = 1
    private var min = 0
    private var ghibliCancellable: AnyCancellable?
    private var service: ServiceProtocol?
    private var urlString = ""
    
    init(urlString: String, service: ServiceProtocol) {
        self.urlString = urlString
        self.service = service
    }
    
    func getData() {
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
            let max = self.currentPage * self.movieLimitPerPage
            for index in self.min...max where max < movies.count {
                self.scrollableMovies.insert(self.movies[index], at: index)
            }
            self.min = max + 1
        }
    }
    
    func hasMoreItems() -> Bool {
        if !self.scrollableMovies.isEmpty {
            self.currentPage += 1
        }
        return min <= movies.count
    }
}
