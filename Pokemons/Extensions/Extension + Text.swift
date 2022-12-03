//
//  Extension + Text.swift
//  Pokemons
//
//  Created by Поляндий on 03.12.2022.
//

import Foundation
import SwiftUI

extension Text {
    func withNormalTextStyle() -> some View  {
        self.font(.system(size: 14))
    }
    
    func withNormalTextAndUnderlinedStyle() -> some View  {
        self.font(.system(size: 14))
            .underline()
    }
    
    func withNormalTextAndBoldStyle() -> some View  {
        self.font(.system(size: 14))
            .bold()
    }
    
    func withCustomFont(size: CGFloat) -> some View  {
        self.font(.custom("Pokemon-Pixel-Font", size: size))
    }
}
