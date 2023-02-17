//
//  DetailView.swift
//  Bookworm
//
//  Created by Bahadır Ersin on 17.02.2023.
//

import CoreData
import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var displayAlert:Bool = false
    let book:Book
    
    var body: some View {
        ScrollView{
            
            ZStack(alignment:.bottomTrailing){
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .background(.black.opacity(75.0))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .offset(x:-5,y:-5)
            }
            
            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.reviewDate?.formatted(date: .abbreviated, time: .omitted) ?? "Unknown Date")
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No Review")
                .padding()
            
            RatingView(rating:.constant(Int(book.rating)),label:"")
                .font(.largeTitle)
            
        }.alert("Delete Book?", isPresented:$displayAlert){
            Button("Delete",role:.destructive, action:deleteBook)
            Button("Cancel",role:.cancel){}
        }message:{
            Text("Are you sure?")
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement:.navigationBarTrailing){
                Button{
                    displayAlert = true
                }label:{
                    Label("Delete this book",systemImage: "trash")
                }
            }
        }
    }
    
    func deleteBook(){
        moc.delete(book)
        
//        try? moc.save()
        dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Harry Potter: Philosopher's Stone"
        book.author = "JK. Rowling"
        book.rating = 4
        book.review = """
        It was a great book from the beginning to the end.
        Especially the friendship between Harry, Ron and
        Hermoine is both touching and entertaining.
        """
        book.genre = "Fantasy"
        
        return NavigationView{
            DetailView(book: book)
        }
    }
}
