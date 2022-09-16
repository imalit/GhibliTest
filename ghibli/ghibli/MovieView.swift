//
//  SwiftUIView.swift
//  ghibli
//
//  Created by Isiah Marie Ramos Malit on 2022-09-16.
//

import SwiftUI

struct MovieView: View {
    let movie: PersonalizedMovie?
    
    init(movie: PersonalizedMovie) {
        self.movie = movie
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct MovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieView()
//    }
//}
