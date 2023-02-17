//
//  AddBookView.swift
//  Bookworm
//
//  Created by Bahadır Ersin on 16.02.2023.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var review = ""
    @State private var rating = 3
    @State private var emptyAlert:Bool = false
    @FocusState private var editorFocused:Bool
    
    let genres = ["Fantasy","Thriller","Romance","Kids","Horror","Mystery"]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name of book",text: $title)
                    TextField("Author's name",text:$author)
                    
                    Picker("Genre",selection: $genre){
                        ForEach(genres, id:\.self){
                            Text($0)
                        }
                    }
                }header:{
                    Text("Book Details")
                }
                
                Section{
                    ZStack(alignment: .topLeading){
                        TextEditor(text: $review)
                            .focused($editorFocused)
                            .frame(minHeight:64)
                        if(!editorFocused && review.isEmpty){
                            Text("Write your review")
                                .foregroundColor(Color(uiColor: .placeholderText))
                                .padding(.top,10)
                                .padding(.leading,5)
                                .allowsHitTesting(false)
                        }
                    }
                    RatingView(rating:$rating,label:"Rating")
                    
                }header:{
                    Text("Write a review")
                }
                
                Section{
                    Button("Save"){
                        if(title.trimmingCharacters(in: .whitespaces).isEmpty || author.trimmingCharacters(in: .whitespaces).isEmpty || review.trimmingCharacters(in: .whitespaces).isEmpty || genre.trimmingCharacters(in: .whitespaces).isEmpty ){
                            emptyAlert = true
                        }else{
                            let newBook = Book(context: moc)
                            newBook.id = UUID()
                            newBook.title = title
                            newBook.author = author
                            newBook.review = review
                            newBook.rating = Int16(rating)
                            newBook.genre = genre
                            newBook.reviewDate = Date.now
                            
                            try? moc.save()
                            dismiss()
                        }
                    }
                }.navigationTitle("Add Book")
            }.alert("Missing Details",isPresented: $emptyAlert){
                Button("OK",role:.none){ }
            }message: {
                Text("Please fill out all fields to save your review")
            }
            
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
