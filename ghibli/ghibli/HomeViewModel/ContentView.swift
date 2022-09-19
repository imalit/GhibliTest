//
//  ContentView.swift
//  ghibli
//
//  Created by Isiah Marie Ramos Malit on 2022-09-12.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject private var viewModel = GhibliListViewModel(
        service: Service(), state: .all
    )
    
    @State var toWatch = false
    @State var watched = false
    
    init() {
        viewModel.getData(urlString: "https://ghibliapi.herokuapp.com/films")
    }
    
    var body: some View {
        NavigationView {
            List {
                Text("Title Here")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                HStack {
                    Text("All").onTapGesture {
                        viewModel.viewState = .all
                    }
                     Text("To Watch").onTapGesture {
                         viewModel.viewState = .toWatch
                     }
                     Text("Watched").onTapGesture {
                         print("action 3 tapped")
                     }
                }
                
                ForEach(0..<self.viewModel.scrollableMovies.count, id: \.self) { index in
                    var movie = self.viewModel.scrollableMovies[index]
//                    GhibliCellContent(index: index, movie: $movie)
//                    GhibliCellContent(movie: $movie)
                    GhibliCellContent(movie: movie, toWatch: $toWatch, watched: $watched)
//                    if toWatch {
//                        movie.state = .toWatch
//                    } else if watched {
//                        movie.state = .watched
//                    }
                }
                
                if self.viewModel.hasMoreItems {
                    Text("Fetching more...")
                        .onAppear(perform: {
                            self.viewModel.fetchMore()
                        }
                    )
                }
            }
        }
    }
}

struct GhibliCellContent: View {
    var movie: PersonalizedMovie
//    var index: Int = 0
    @Binding var toWatch: Bool
    @Binding var watched: Bool
    
//    init(index: Int) {
//        self.movie = movie
//        self.index = index
//    }
    
    var body: some View {
//        if var movie = movie {
            let ghibliMovie = movie.ghibliMovie
            
            let movieView = MovieView(
                toWatch: $toWatch,
                watched: $watched
            )
                
            NavigationLink(destination: movieView) {
                VStack {
                    HStack {
                        Text("\(ghibliMovie.title)")
                            .font(.title3)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity)
                            
                        AsyncImage(
                            url: URL(string: ghibliMovie.image),
                            content: { image in
                                image.resizable()
                            }, placeholder: {
                                Color.red
                            }
                        )
                            .scaledToFit()
                            .cornerRadius(10)
                            .frame(
                                width: 150,
                                height: 150,
                                alignment: .trailing
                            )
                    }
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 20, trailing: 5))
                    
                    Text("\(ghibliMovie.ghibliDescription)")
                        .lineLimit(nil)
                        .font(.body)
                }
                    .padding(
                        EdgeInsets(
                            top: 10,
                            leading: 10,
                            bottom: 10,
                            trailing: 10
                        )
                    )
            }
        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
