
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI


struct FilterView: View {
    @Binding var img: Image?
    @Binding var uiImage: UIImage?
    
    
    @State private var filterIntensity = 0.5
    @State private var currentFilter:  CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false


    var body: some View {
        NavigationView{
            
        VStack{
            img?
                .resizable()
                .scaledToFit()
                .padding()
            HStack{
                Text("Intensity")
                Slider(value: $filterIntensity)
                    .onChange(of: filterIntensity){ _ in
                        applyProcessing()
                    }
            }
            Button("Select a filter"){
                showingFilterSheet = true
                Spacer()
            }
        }//vstack
        .navigationTitle("Add Filter")
        .confirmationDialog("Select a filter", isPresented: $showingFilterSheet){
            Button("Crystallize") { setFilter(CIFilter.crystallize()) }
            Button("Edges") { setFilter(CIFilter.edges()) }
            Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
            Button("Pixellate") { setFilter(CIFilter.pixellate()) }
            Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
            Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
            Button("Vignette") { setFilter(CIFilter.vignette()) }
            Button("Color MAP") { setFilter(CIFilter.colorMap()) }
            Button("Zoom Blur"){setFilter(CIFilter.zoomBlur())}
            Button("Cancel", role: .cancel) { }
        }
    }//navigation view
    } //some view
    
   func loadImage(){
        guard let inputImage = uiImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    func setFilter( _ filter: CIFilter){
        currentFilter = filter
        loadImage()
    }
    func applyProcessing(){
        
        // set values for different filters
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey){currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)}
        if inputKeys.contains(kCIInputRadiusKey){currentFilter.setValue(filterIntensity*200, forKey: kCIInputRadiusKey)}
        if inputKeys.contains(kCIInputScaleKey){currentFilter.setValue(filterIntensity*10, forKey: kCIInputScaleKey)}
        
        //get the filtered  output CIImage
        guard let outputImage = currentFilter.outputImage else{return}
      
        //context rendered a CIImage to a CGImage
        let context = CIContext() //rendering a CIImage to a CGImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            //convert cgImage to UIImage
            let uiImage = UIImage(cgImage: cgimg)
            //convert UIImage to SwiftUI image
            img = Image(uiImage: uiImage)
        }
    }
}



//
//struct FilterViewPreview: PreviewProvider{
//    static var previews: some View {
//        FilterView(img: <#T##Binding<Image?>#>, uiImage: <#T##Binding<UIImage?>#>)
//    }
//}

