//
//  ContentView.swift
//  Periodic Elements
//
//  Created by Tom Bredemeier on 2/24/21.
//

import SwiftUI

struct ContentView: View {
    @State private var elements = [Element]()
    var body: some View {
        NavigationView {
            List(elements) { element in
                Text(element.name)
            }
        }
        .onAppear(perform: {
            queryAPI()
        })
    }
    
    func queryAPI() {
        let apiKey = "?rapidapi-key=d87dc96880msh138dad116ed364ep17b762jsnfa65120c7d18"
        let query = "https://periodictable.p.rapidapi.com/\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                print(json)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Element: Identifiable {
    let id = UUID()
    var name: String
}
