//
//  TextUtils.swift
//  Pokemons
//
//  Created by Поляндий on 03.12.2022.
//

import Foundation

public class TextUtils {
    func removeBlankSpacesFromText(description: String) -> String {
        let descriptionFormatted = description.replacingOccurrences(of: "\n", with: " ")
        return descriptionFormatted.replacingOccurrences(of: "\u{0C}", with: " ")
    }
}
