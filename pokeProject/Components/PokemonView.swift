//
//  PokemonView.swift
//  pokeProject
//
//  Created by Wesley Brito on 28/05/23.
//

import SwiftUI
import Kingfisher

struct PokemonView: View {
    var name: String
    var url: URL?
    
    var body: some View {
        VStack {
            Text(name)
                .font(.title)
                .padding(.bottom, 10)
                
            KFImage(url)
                .cacheOriginalImage()
                .diskCacheExpiration(.days(30))
                .resizable()
                .frame(width: 200, height: 200)
                .background(.thinMaterial)
                .clipShape(Circle())
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(name: "bulba", url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(1).png"))
    }
}
