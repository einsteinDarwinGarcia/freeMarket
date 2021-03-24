//
//  Carousel.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//

import SwiftUI

struct Carousel: View {
    @State var index = 0

    var images: [String]

    var body: some View {
        VStack(spacing: 20) {
            PagingView(index: $index.animation(), maxIndex: images.count - 1) {
                ForEach(self.images, id: \.self) { imageName in
                
                    AsyncImage(url: validateImage(image: imageName),
                               placeholder: { Text("Loading ...") },
                               image: {
                                Image(uiImage: $0).resizable()
                                 }
                               )
                    .aspectRatio(contentMode: .fit)
                   .frame(idealHeight: UIScreen.main.bounds.width / 2 * 3)
                }
            }
            .aspectRatio(4/3, contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .padding()
    }
    
    func validateImage(image: String) -> URL {
        guard let url = URL(string: image) else { return URL(string: "http://http2.mlstatic.com/D_937927-MCO31896772245_082019-O.jpg")! }
        return url
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel(images: [""])
    }
}
