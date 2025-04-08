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

    @State var scrollOffset: CGFloat = 0

    let listItemCount: Int = 20

    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Color.white
                    .frame(
                        width: geometry.size.width,
                        height: geometry.safeAreaInsets.top,
                        alignment: .center
                    )
                    .aspectRatio(contentMode: ContentMode.fit)
                    .zIndex(1)
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
                    }.background(GeometryReader { geometry in
                        Color.clear.preference(key: ScrollOffsetPreferenceKey.self,
                                               value: -geometry.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        self.scrollOffset = value
                        print("offset >> \(value)")
                    }
                }.coordinateSpace(name: "scroll")
            }.onChange(of: isSearchBarFocused) { newValue in
                withAnimation {
                    shouldShowHeader = newValue == false
                }
            }.edgesIgnoringSafeArea(.top)
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
            .background(.white)
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
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
