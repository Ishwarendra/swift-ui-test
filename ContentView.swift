//
//  ContentView.swift
//  SwiftUITesting
//
//  Created by Ishwarendra Jha on 01/02/25.
//

import SwiftUI

struct ContentView: View {
    @State var searchText: String = ""
    @State var isSearchBarFocused: Bool = false

    @State var shouldShowHeader: Bool = true

    public var body: some View {
        titleView()
    }

    @ViewBuilder
    private func titleView() -> some View {
        if shouldShowHeader {
            titleBar()
            pageHeader("Page Header")
        }

        SearchBar(
            searchText: $searchText,
            isFocused: $isSearchBarFocused
        ).padding()
            .background(.white)
    }

    @ViewBuilder
    private func titleBar() -> some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 14, height: 24)
            Spacer()
            Image(systemName: "triangle.fill")
                .resizable()
                .frame(width: 24, height: 24)
        }.padding([.leading, .trailing], 16)
            .padding([.top, .bottom], 8)
    }

    @ViewBuilder
    private func pageHeader(_ text: String) -> some View {
        HStack {
            PageHeader(text: text)
            Spacer()
        }.padding(.leading, 16)
    }
}

#Preview {
    ContentView()
}
