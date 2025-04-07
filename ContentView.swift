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

    @State var scrollOffset: CGPoint = .zero

    let listItemCount: Int = 20

    public var body: some View {
        VStack(spacing: 0) {
            if shouldShowHeader {
                titleBar()
            }

            ScrollView {
                LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                    Section {
                        if shouldShowHeader {
                            pageHeader("Page Header")
                        }
                    }

                    Section {
                        listView()
                    } header: {
                        searchBar()
                            .ignoresSafeArea(.all, edges: .top)
                    }
                }
            }.coordinateSpace(name: "scroll")
                .background(GeometryReader { geometry in
                    Color.clear.preference(key: ScrollOffsetPreferenceKey.self,
                                           value: geometry.frame(in: .named("scroll")).origin)
                })
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    self.scrollOffset = value
                    print("offset >> \(value)")
                }

        }.onChange(of: isSearchBarFocused) { newValue in
            withAnimation {
                shouldShowHeader = newValue == false
            }
        }
    }

    @ViewBuilder
    private func searchBar() -> some View {
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
        }.padding([.top, .bottom, .leading], 16)
    }
}

extension ContentView {
    @ViewBuilder
    private func listView() -> some View {
        ForEach(0..<listItemCount, id: \.self) { index in
            Text("Item \(index + 1)")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
                .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}
