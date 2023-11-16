//
//  ProfileView.swift
//  AI_learning.swift
//
//  Created by Ryan Hui on 25/10/2023.
//

import SwiftUI
import AVFoundation
import UIKit
struct ProfileView: View {
    let username: String
    @State private var newPassword = ""
    @State private var newUsername = ""
    @State private var showCamera = false
    @State private var profileImage: UIImage?
    @State private var isShowingEmptyPasswordAlert = false
    @State private var isShowingSamePasswordAlert = false
    @State private var isShowingPasswordChangedAlert = false
    @State private var showImagePicker = false
    @State private var showImagePickerAlert = false
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                Spacer().frame(height: 350)
                VStack {
                    if let userIndex = userArray.firstIndex(where: { $0.username == username }) {
                        Text("Profile Picture")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 100)
                            .padding(.leading, 20)
                        
                        Image(uiImage: profileImage ?? UIImage(systemName: "person")!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 240)
                            .cornerRadius(8)
                            .overlay(Rectangle().stroke(Color.white, lineWidth: 4))
                            .shadow(color: Color.blue.opacity(0.5), radius: 7)
                            .onTapGesture {
                                showImagePickerAlert = true
                            }
                        
                        Spacer().frame(height: 80)
                        
                        VStack(alignment: .leading) {
                            Text("Username: \(userArray[userIndex].username)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)
                                .padding(.vertical, 20)
                            
                            TextField("New Password", text: $newPassword)
                                .focused($isTextFieldFocused)
                                .autocapitalization(.none)
                                .onTapGesture {
                                    isTextFieldFocused = true
                                }
                            
                            Spacer().frame(height: 0)
                        }
                        .padding(.horizontal)
                        
                        Section {
                            Button(action: {
                                changePassword(for: userIndex)
                            }) {
                                Text("Change Password")
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                    } else {
                        Text("User not found")
                    }
                }
                .padding(.vertical, -210)
            }
            .navigationBarTitle(Text("Profile"))
            .sheet(isPresented: $showCamera) {
                CameraView(profileImage: $profileImage)
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(image: $profileImage)
            }
            .alert(isPresented: $isShowingEmptyPasswordAlert) {
                Alert(
                    title: Text("Warning"),
                    message: Text("New password cannot be empty."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .alert(isPresented: $isShowingSamePasswordAlert) {
                Alert(
                    title: Text("Warning"),
                    message: Text("New password cannot be the same as the original password."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .alert(isPresented: $isShowingPasswordChangedAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text("Password changed"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .alert(isPresented: $showImagePickerAlert) {
                Alert(
                    title: Text("Choose an option"),
                    message: nil,
                    primaryButton: .default(Text("Camera"), action: {
                        showCamera = true
                    }),
                    secondaryButton: .default(Text("Library"), action: {
                        showImagePicker = true
                    })
                )
            }
        }
    }
    
    private func changePassword(for userIndex: Int) {
        let originalPassword = userArray[userIndex].password
        
        guard !newPassword.isEmpty else {
            isShowingEmptyPasswordAlert = true
            return
        }
        
        guard newPassword != originalPassword else {
            isShowingSamePasswordAlert = true
            return
        }
        
        userArray[userIndex].password = newPassword
        print("New password: \(userArray[userIndex].password)")
        newPassword = ""
        isShowingPasswordChangedAlert = true
    }
}

struct CameraView: UIViewControllerRepresentable {
    @Binding var profileImage: UIImage?
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let viewController = CameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, CameraViewControllerDelegate {
        let parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func didCaptureImage(_ image: UIImage) {
            parent.profileImage = image
        }
    }
}

protocol CameraViewControllerDelegate: AnyObject {
    func didCaptureImage(_ image: UIImage)
}

class CameraViewController: UIViewController {
    weak var delegate: CameraViewControllerDelegate?
    var session: AVCaptureSession?
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        checkCameraPermissions()
        setUpShutterButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    
    private func setUpCamera() {
        let session = AVCaptureSession()
        if let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            do {
                let input = try AVCaptureDeviceInput(device: frontCamera)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                session.startRunning()
                self.session = session
            } catch {
                print(error)
            }
        }
    }
    
    private func setUpShutterButton() {
        let shutterButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        shutterButton.layer.cornerRadius = 100
        shutterButton.layer.borderWidth = 3
        shutterButton.layer.borderColor = UIColor.white.cgColor
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
        view.addSubview(shutterButton)
        shutterButton.center = CGPoint(x: view.bounds.midX, y: view.bounds.maxY - 100)
    }
    
    @objc private func didTapTakePhoto() {
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
}
struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
    }
}
extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        let image = UIImage(data: data)
        delegate?.didCaptureImage(image ?? UIImage())
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
