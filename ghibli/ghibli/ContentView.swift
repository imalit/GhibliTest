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
        urlString: "https://ghibliapi.herokuapp.com/films",
        service: Service()
    )
    
    init() {
        viewModel.getData()
    }
    
    var body: some View {
        List {
            Text("Title Here")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
            ForEach(self.viewModel.movies, id: \.id) { movie in
                VStack {
                    HStack {
                        Text("\(movie.title)")
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
