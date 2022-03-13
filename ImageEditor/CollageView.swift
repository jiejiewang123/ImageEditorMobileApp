//
//  CollageView.swift
//  ImageEditor
//
//  Created by Jiejie Wang on 3/8/22.
//

import SwiftUI
import UIKit

import CoreImage
import CoreImage.CIFilterBuiltins


struct CollageView: View {
    var uiImage1: UIImage
    var uiImage2: UIImage
    var uiImage3: UIImage
    
    @State var mergedImage = ImageCollage()

    var body: some View {
        VStack{
        Text("Photo Collage")
        
        if (uiImage1.size.width != 0 && uiImage2.size.width  != 0 && uiImage3.size.width != 0){

            Image(uiImage: mergedImage.collage(im1: uiImage1, im2: uiImage2, im3: uiImage3))

            .resizable()
            .scaledToFit()
            
            Button(action: {save()}) {
                Text("Save Image")
            }
        }
        else{
            Text("Select three photos first!")
        }
            
        }//VStack
    }
    func save(){
        let processedImage = mergedImage.collage(im1: uiImage1, im2: uiImage2, im3: uiImage3)
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success")
        }
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
}
//function to collage images
struct ImageCollage {
    func collage(im1: UIImage, im2: UIImage, im3: UIImage) -> UIImage {
        let size = CGSize(width: im1.size.width + im2.size.width, height: im1.size.height + im3.size.height)
        let area1 = CGRect(x: 0, y: 0, width: im1.size.width, height: im1.size.height)
        let area2 = CGRect(x: im1.size.width, y: 0, width: im2.size.width, height: im1.size.height)
        let area3 = CGRect(x: 0, y: im1.size.height, width: im1.size.width+im2.size.width, height: im3.size.height)
        UIGraphicsBeginImageContext(CGSize(width: size.width, height: size.height))
        
        im1.draw(in: area1)
        im2.draw(in: area2)
        im3.draw(in: area3, blendMode: .normal, alpha: 1)
        
        let finalImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
      
        return finalImage
    }
}

struct CollageView_Previews: PreviewProvider {
    static var previews: some View {
        CollageView(uiImage1: UIImage(), uiImage2: UIImage(), uiImage3: UIImage())
    }
}
