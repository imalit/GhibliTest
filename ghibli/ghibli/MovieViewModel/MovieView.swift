//
//  SwiftUIView.swift
//  ghibli
//
//  Created by Isiah Marie Ramos Malit on 2022-09-16.
//

import SwiftUI

struct MovieView: View {
//    @ObservedObject private var viewModel: MovieViewModel
//    var movie: PersonalizedMovie
    @Binding var toWatch: Bool
    @Binding var watched: Bool

    var body: some View {
        VStack {
//            Text("\(movie.ghibliMovie.title)")
            Toggle("to watch", isOn: $toWatch)
            Toggle("watched", isOn: $watched)
        }
    }
}

//struct MovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieView()
//    }
//}
