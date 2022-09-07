//
//  FlagImage.swift
//  GuessTheFlagSwiftUI
//
//  Created by Anastasiia Veremiichyk on 07/09/2022.
//

import SwiftUI

struct FlagImage: View {
    let country: String

    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(country: "Ukraine")
    }
}
