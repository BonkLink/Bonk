//
//  SearchBox.swift
//  BonkLink
//
//  Created by Jessica Wood on 4/27/21.
//

import SwiftUI

struct SearchBox: View {
    
    var placeholder: String = "Search"
    @Binding var searchText: String

    private enum Dimensions {
        static let inset: CGFloat = 7.0
        static let bottomInset: CGFloat = 4.0
        static let heightTextField: CGFloat = 36.0
        static let cornerRadius: CGFloat = 10.0
        static let padding: CGFloat = 16.0
        static let topPadding: CGFloat = 15.0
        static let glassSize: CGFloat = 24.0
        static let dividerHeight: CGFloat = 1.0
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SearchBox_Previews: PreviewProvider {
    static var previews: some View {
        //SearchBox()
        Text("Needs to be fixed")
    }
}
