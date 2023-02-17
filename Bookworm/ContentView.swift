//
//  ContentView.swift
//  Bookworm
//
//  Created by Bahadır Ersin on 16.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)]) var books:FetchedResults<Book>
    
    @State private var showAddScreen = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(books){ book in
                    NavigationLink{
                        DetailView(book: book)
                    }label:{
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack{
                                Text(book.title ?? "Uknown Book")
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? Color.red : Color.primary)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }.onDelete(perform: deleteBooks)
            }
            .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button{
                    showAddScreen = true
                }label:{
                    Label("Add Book", systemImage: "plus")
                }
            }
                
                ToolbarItem(placement:.navigationBarLeading){
                    EditButton()
                }
                
        }
        .navigationTitle("Bookworm")
        .sheet(isPresented: $showAddScreen){
            AddBookView()
        }
        }
    }
    
    func deleteBooks(at offsets:IndexSet){
        for offset in offsets{
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
