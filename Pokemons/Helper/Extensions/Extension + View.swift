//
//  Extension + View.swift
//  Pokemons
//
//  Created by Поляндий on 03.12.2022.
//

import Foundation
import SwiftUI

extension View {
    func withRoundedCornersAndFullWidthStyle(backgroundColor: Color) -> some View {
        self.frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(12)
    }
    
    func withRoundedCornersAndPadding(backgroundColor: Color) -> some View {
        self.padding()
            .background(backgroundColor)
            .cornerRadius(12)
    }
    
    func withGradientBackgroundStyle(startColor: String, endColor: String) -> some View {
        self.background(LinearGradient(gradient: Gradient(colors: [Color(startColor), Color(endColor)]), startPoint: .top, endPoint: .bottom))
    }
    
    func contentBackgroundStyle(cornerOne: UIRectCorner, cornerTwo: UIRectCorner) -> some View {
        self.frame(maxWidth: .infinity)
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("startSearchbarGradient"), lineWidth: 10)
            )
            .cornerRadius(12)
    }

    func titleBackgroundStyle(cornerOne: UIRectCorner, cornerTwo: UIRectCorner) -> some View {
        self.padding(.top, 5)
            .frame(maxWidth: .infinity)
            .background(Color("startSearchbarGradient"))
            .cornerRadius(12)
    }
}
