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
    @State private var labels: [String: String] = [
        "Ai_Girlfriend": "AI_gen Girl",
        "Dog_AI_generated": "AI_gen Dog",
        "FREE_Ai_based_ConceptCar_049_public_domain_CC0": "AI_gen Car",
        "knife": "AI_gen Knife",
        "Tree_AI_generated": "AI_gen Tree"
    ]
    @State private var addedModels: [String] = []
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(modelConfirmedForPlacement: $modelConfirmedForPlacement, eraseModels: $eraseModels, labels: $labels)
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 10){
                        Button(action: {
                            modelConfirmedForPlacement = "Ai_Girlfriend"
                            addedModels.append("AI Girlfriend")
                        }) {
                            Image("Ai_Girlfriend")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                        }
                        
                        Button(action: {
                            modelConfirmedForPlacement = "Dog_AI_generated"
                            addedModels.append("Dog")
                        }) {
                            Image("Dog_AI_generated")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                        }
                        
                        Button(action: {
                            modelConfirmedForPlacement = "FREE_Ai_based_ConceptCar_049_public_domain_CC0"
                            addedModels.append("Concept Car")
                        }) {
                            Image("FREE_Ai_based_ConceptCar_049_public_domain_CC0")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                        }
                        
                        Button(action: {
                            modelConfirmedForPlacement = "knife"
                            addedModels.append("Knife")
                        }) {
                            Image("knife")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                        }
                        
                        Button(action: {
                            modelConfirmedForPlacement = "Tree_AI_generated"
                            addedModels.append("Tree")
                        }) {
                            Image("Tree_AI_generated")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                        }
                        
                        Button(action: {
                            eraseModels = true
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                                .cornerRadius(10)
                                .font(.system(size: 36))
                        }
                    }
                    .padding(10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                    .padding()
                    .onChange(of: eraseModels) { newValue in
                        if newValue {
                            addedModels.removeAll()
                            eraseModels = false
                        }
                    }
                }
                if !addedModels.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(addedModels, id: \.self) { modelName in
                                Text("Added \(modelName)")
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 5)
                            }
                        }
                        
                    }
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.8)))
                }
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var modelConfirmedForPlacement: String?
    @Binding var eraseModels: Bool
    @Binding var labels: [String: String]
    
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
            let filename = modelName + ".usdz"
            let modelEntity = try! ModelEntity.loadModel(named: filename)
            let anchorEntity = AnchorEntity(plane: .horizontal)
            anchorEntity.addChild(modelEntity)
            uiView.scene.addAnchor(anchorEntity)
            modelEntity.generateCollisionShapes(recursive: true)
            uiView.installGestures([.translation, .rotation, .scale], for: modelEntity)
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

struct LabelView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundColor(.white)
            .padding(8)
            .background(Color.black.opacity(0.8))
            .cornerRadius(8)
            .offset(y: -20)
    }
}
#if DEBUG
struct ARView_Previews : PreviewProvider {
    static var previews: some View {
        AR_View()
    }
}
#endif
