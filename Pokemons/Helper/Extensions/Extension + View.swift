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
}
