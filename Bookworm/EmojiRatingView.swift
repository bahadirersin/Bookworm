//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by BahadÄ±r Ersin on 17.02.2023.
//

import SwiftUI

struct EmojiRatingView: View {
    
    let rating:Int16
    
    var body: some View {
        switch(rating){
        case 1:
            Text("ð")
        case 2:
            Text("ð")
        case 3:
            Text("ð")
        case 4:
            Text("ð")
        case 5:
            Text("ð¤©")
        default:
            Text("ð")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating:3)
    }
}
