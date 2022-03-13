//
//  ContentView.swift
//  ImageEditor
//
//  Created by Jiejie Wang on 2/25/22.
//

import SwiftUI


//class for navigation bar color
class Theme {
    static func navigationBarColors(background : UIColor?,
       titleColor : UIColor? = nil, tintColor : UIColor? = nil ){
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .clear
        
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
       
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance

        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    }
}



struct ContentView: View {
    @State private var ShowPhotoPicker1 = false
    @State private var ShowPhotoPicker2 = false
    @State private var ShowPhotoPicker3 = false
    
    @State private var inputImage1: UIImage?
    @State private var inputImage2: UIImage?
    @State private var inputImage3: UIImage?
    
    @State private var image1: Image?
    @State private var image2: Image?
    @State private var image3: Image?
    
    
    @State private var threeImgaesSelected = false
    

    
    //call Theme class to change navigationBarColors
    init(){
        Theme.navigationBarColors(background: .magenta, titleColor: .white)
        }
 
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                if (inputImage1 != nil && inputImage2 != nil && inputImage3 != nil)
                {
                NavigationLink("Collage->"){
                    CollageView(uiImage1: inputImage1!, uiImage2: inputImage2!, uiImage3: inputImage3!)
                    }
                }
                
            
                HStack{
                    //image1
                    VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 25).fill(.purple)
                            Text("click to select a picture")
                                .foregroundColor(.white)
                                .font(.headline)
                            image1?
                                .resizable()
                                .scaledToFit()
                              
                        }
                    .onTapGesture {
                        ShowPhotoPicker1 = true;
                    }
                    .onChange(of: inputImage1){
                        _ in loadImage1()
                    }
                    .sheet(isPresented: $ShowPhotoPicker1) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: $inputImage1)
                    }
                        NavigationLink("Change filter"){
                            FilterView(img: $image1, uiImage: $inputImage1)
                        }
    
                    }
                  
                    //image2
                    VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 25).fill(.purple)
                            Text("click to select a picture")
                                .foregroundColor(.white)
                                .font(.headline)
                            image2?
                                .resizable()
                                .scaledToFit()
                        }
                       
                        .onTapGesture {
                            ShowPhotoPicker2 = true;
                        }
                        .onChange(of: inputImage2){
                            _ in loadImage2()
                        }
                        .sheet(isPresented: $ShowPhotoPicker2) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $inputImage2)
                        }
                        
                        NavigationLink("Change filter"){
                            FilterView(img: $image2, uiImage: $inputImage2)
                        }
                    }
                }//HStack
                
                //image3
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 25).fill(.purple)
                        Text("click to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                        image3?
                            .resizable()
                            .scaledToFit()
                    }
                    .onTapGesture {
                        ShowPhotoPicker3 = true;
                    }
                    .onChange(of: inputImage3){
                        _ in loadImage3()
                    }
                    .sheet(isPresented: $ShowPhotoPicker3) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: $inputImage3)
                    }
                    NavigationLink("Change filter"){
                        FilterView(img: $image3, uiImage: $inputImage3)
                    }
                }
            }//VStack
            .navigationBarTitle(Text("Image Editor"), displayMode: .inline)
        }// NavigationView
            }// some View
    
    //convert UIImage to SwiftUI Image
    func loadImage1(){
        guard let inputImage = inputImage1 else { return }
        image1 = Image(uiImage: inputImage)
    }
    
    func loadImage2(){
        guard let inputImage = inputImage2 else { return }
        image2 = Image(uiImage: inputImage)
    }
    
    func loadImage3(){
        guard let inputImage = inputImage3 else { return }
        image3 = Image(uiImage: inputImage)
    }
    
}//View


struct ContentViewPreview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
