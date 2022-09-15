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
        service: Service()
    )
    
    init() {
        viewModel.getData(urlString: "https://ghibliapi.herokuapp.com/films")
    }
    
    var body: some View {
        List {
            Text("Title Here")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
            ForEach(0..<self.viewModel.scrollableMovies.count, id: \.self) { index in
                let movie = self.viewModel.scrollableMovies[index]
                
                VStack {
                    HStack {
                        
                        Text("\(index+1) \(movie.title)")
                            .padding()
                        
                        AsyncImage(
                            url: URL(string: movie.image),
                            content: { image in
                                image.resizable()
                            }, placeholder: {
                                Color.red
                            }
                        )
                            .scaledToFit()
                            .frame(width: 150, height: 150, alignment: .trailing)
                    }

                    Text("\(movie.ghibliDescription)")
                        .lineLimit(nil)
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            }
            
            Text("Fetching more...")
                .onAppear(perform: {
                    if self.viewModel.hasMoreItems() {
                        self.viewModel.fetchMore()
                    }
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
