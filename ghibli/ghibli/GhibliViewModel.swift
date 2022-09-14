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
    @Published var movies = [GhibliElement]()
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
            receiveCompletion: { _ in }, receiveValue: { (ghibliMovies: [GhibliElement]) in
                self.movies = ghibliMovies
            }
        )
    }
}
