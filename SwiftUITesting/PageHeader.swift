//
//  PageHeader.swift
//  SwiftUITesting
//
//  Created by Ishwarendra Jha on 08/04/25.
//

import SwiftUI

struct PageHeader: View {
    var text: String

    init(text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(.title.bold())
    }
}

#Preview {
    PageHeader(text: "Page Header")
}
