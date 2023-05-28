//
//  FirstAppear.swift
//  pokeProject
//
//  Created by Wesley Brito on 27/05/23.
//

import SwiftUI

struct FirstAppear: ViewModifier {
    let perform: () -> Void
    @State private var firstTime: Bool = true
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if firstTime {
                    firstTime = false
                    perform()
                }
            }
    }
}

extension View {
    func onFirstAppear(perform: @escaping () -> Void) -> some View {
        modifier(FirstAppear(perform: perform))
    }
}
