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
                .font(.largeTitle)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 10,
                        bottom: 10,
                        trailing: 10
                    )
                )
            
            Picker("state:",
                   selection: $movie.state) {
                    Text("None").tag(MovieState.none)
                    Text("To Watch").tag(MovieState.toWatch)
                    Text("Watched").tag(MovieState.watched)
            }
                   .pickerStyle(.automatic)
            
            AsyncImage(
                url: URL(string: movie.ghibliMovie.image),
                content: { image in
                    image.resizable()
                }, placeholder: {
                    Color.red
                }
            )
                .scaledToFit()
                .cornerRadius(10)
            
            Text("\(movie.ghibliMovie.ghibliDescription)")
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
        }.padding(
            EdgeInsets(
                top: 10,
                leading: 10,
                bottom: 20,
                trailing: 10
            )
        )
            .navigationBarTitle("", displayMode: .inline)
    }
}
