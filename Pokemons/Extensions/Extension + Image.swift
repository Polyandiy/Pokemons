//
//  Extension + Image.swift
//  Pokemons
//
//  Created by Поляндий on 03.12.2022.
//

import Foundation
import SwiftUI

extension Image {
    func topIconSizeStyle() -> some View  {
        self.resizable()
            .frame(width: 30, height: 30)
    }
    
    func bottomIconSizeStyle() -> some View  {
        self.resizable()
            .frame(width: 50, height: 50)
    }
}
