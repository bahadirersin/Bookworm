//
//  ContentView.swift
//  Bookworm
//
//  Created by Bahadır Ersin on 16.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books:FetchedResults<Book>
    
    @State private var showAddScreen = false
    
    var body: some View {
        NavigationView{
            Text("\(books.count)")
                .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showAddScreen = true
                    }label:{
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Bookworm")
            .sheet(isPresented: $showAddScreen){
                AddBookView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
