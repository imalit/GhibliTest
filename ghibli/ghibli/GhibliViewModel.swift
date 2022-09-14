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
    @Published var movies = [GhibliViewModel]()
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
        ).map { (movies: [GhibliElement]) in
            movies.map {
                GhibliViewModel(ghibliMovie: $0)
            }
        }.sink(receiveCompletion: { _ in }, receiveValue: { ghibliViewModels in
            print(ghibliViewModels)
            self.movies = ghibliViewModels
        })
    }
}

struct GhibliViewModel {
    let ghibliMovie: GhibliElement
    
    var id: String {
        return self.ghibliMovie.id
    }
    
    var title: String {
        return self.ghibliMovie.title
    }
    
    var description: String {
        return self.ghibliMovie.ghibliDescription
    }
    
    var image: URL? {
        return URL(string: self.ghibliMovie.image)
    }
}
