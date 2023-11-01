//.  only AI_Girl
//  ContentView.swift
//  ModelPickerApp
//
//  Created by Ryan Hui on 14/9/2023.
//
//
import SwiftUI
import RealityKit
import ARKit
struct AR_View: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var modelConfirmedForPlacement: String? = nil
    @State private var eraseModels = false
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(modelConfirmedForPlacement: $modelConfirmedForPlacement,eraseModels: $eraseModels)
                .edgesIgnoringSafeArea(.all)
            VStack {
            Button(action: {
                self.eraseModels = true
                }) {
                Text("Clear")
                    .foregroundColor(.red)
                    .cornerRadius(10)
                    .padding(.top, 50)
                    .font(.system(size: 22))
                }
                .frame(minWidth: 100, maxWidth: .infinity)
                Spacer()
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Button(action: {
                        modelConfirmedForPlacement = "Ai_Girlfriend"
                    }) {
                        Image("Ai_Girlfriend")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                    }
                    
                    Button(action: {
                        modelConfirmedForPlacement = "Dog_AI_generated"
                    }) {
                        Image("Dog_AI_generated")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                    }
                    Button(action: {
                        modelConfirmedForPlacement = "FREE_Ai_based_ConceptCar_049_public_domain_CC0"
                    }) {
                        Image("FREE_Ai_based_ConceptCar_049_public_domain_CC0")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                    }
                    Button(action: {
                        modelConfirmedForPlacement = "knife"
                    }) {
                        Image("knife")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                    }
                    Button(action: {
                        modelConfirmedForPlacement = "Tree_AI_generated"
                    }) {
                        Image("Tree_AI_generated")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                    }
                    // Add more images/buttons as needed
                }
                .padding(10)
                .background(Color.white.opacity(0.8))
                .cornerRadius(20)
                .padding()
            }        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var modelConfirmedForPlacement: String?
    @Binding var eraseModels: Bool
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        arView.backgroundColor = .white
        arView.session.run(config)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if let modelName = self.modelConfirmedForPlacement {
            print("DEBUG: adding model to scene - \(modelName)")
            let filename = modelName + ".usdz"
            let modelEntity = try! ModelEntity.loadModel(named: filename)
            let anchorEntity = AnchorEntity(plane: .any)
            anchorEntity.addChild(modelEntity)
            uiView.scene.addAnchor(anchorEntity)
            DispatchQueue.main.async {
                self.modelConfirmedForPlacement = nil
            }
        }
        if self.eraseModels {
           uiView.scene.anchors.removeAll()
           DispatchQueue.main.async {
               self.eraseModels = false
           }
       }
    }
}
#if DEBUG
struct ARView_Previews : PreviewProvider {
    static var previews: some View {
        AR_View()
    }
}
#endif
