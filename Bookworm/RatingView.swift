//
//  RatingView.swift
//  Bookworm
//
//  Created by Bahadır Ersin on 17.02.2023.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating:Int
    
    var label:String
    var maximumRating = 5
    var offImg:Image?
    var onImg:Image = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack{
            if(!label.isEmpty){
                Text(label)
            }
            
            ForEach(1..<maximumRating+1,id:\.self){ number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
    
    func image(for number:Int) -> Image{
        if(number > rating){
            return offImg ?? onImg
        }
        return onImg
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating:.constant(4),label:"")
    }
}
