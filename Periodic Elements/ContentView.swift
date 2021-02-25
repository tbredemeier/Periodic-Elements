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
                NavigationLink(
                    destination: VStack {
                        Text(element.name)
                            .padding()
                        Text(element.symbol)
                            .padding()
                        Text(element.history)
                            .padding()
                        Text(element.facts)
                            .padding()
                    },
                    label: {
                        HStack {
                            Text(element.symbol)
                            Text(element.name)
                        }
                    })
            }
            .navigationTitle("Periodic Elements")
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
                let contents = json.arrayValue
                for item in contents {
                    let name = item["name"].stringValue
                    let symbol = item["symbol"].stringValue
                    let facts = item["facts"].stringValue
                    let history = item["history"].stringValue
                    let element = Element(symbol: symbol, name: name, history: history, facts: facts)
                    elements.append(element)
                }
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
    var symbol: String
    var name: String
    var history: String
    var facts: String
}
