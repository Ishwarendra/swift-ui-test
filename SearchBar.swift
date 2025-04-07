//
//  SearchBar.swift
//  SwiftUITesting
//
//  Created by Ishwarendra Jha on 08/04/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isFocused: Bool
    @FocusState private var textFieldFocused: Bool

    var body: some View {
        TextField("Search", text: $searchText)
            .padding([.top, .bottom], 10)
            .padding([.leading, .trailing], 20)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .focused($textFieldFocused)
            .onChange(of: textFieldFocused) { newValue in
                isFocused = newValue
            }
    }
}

#Preview {
    SearchBar(searchText: .constant("hi"), isFocused: .constant(true))
}
