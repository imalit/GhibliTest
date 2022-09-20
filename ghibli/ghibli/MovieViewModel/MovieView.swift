//
//  SwiftUIView.swift
//  ghibli
//
//  Created by Isiah Marie Ramos Malit on 2022-09-16.
//

import SwiftUI

struct MovieView: View {
    @State var movie: PersonalizedMovie

    var body: some View {
        VStack {
            Text("\(movie.ghibliMovie.title)")
            Picker("state:",
                   selection: $movie.state) {
                    Text("None").tag(MovieState.none)
                    Text("To Watch").tag(MovieState.toWatch)
                    Text("Watched").tag(MovieState.watched)
            }
                   .pickerStyle(.automatic)
        }
    }
}

//struct MovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieView()
//    }
//}
