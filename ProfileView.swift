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
    @State private var showAlert = false
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
                            .multilineTextAlignment(.leading) // Align the text to the left
                            .frame(maxWidth: .infinity, alignment: .leading) // Expand the frame to fill the available width
                            .padding(.top, 100) // Move the text higher
                            .padding(.leading, 20) // Move the text to the right
                        Image(uiImage: profileImage ?? UIImage(systemName: "person")!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 250)
                            .cornerRadius(8) // Apply a corner radius to the frame
                            .overlay(Rectangle().stroke(Color.white, lineWidth: 4))
                            .shadow(color: Color.blue.opacity(0.5), radius: 7) // Apply a shadow with blue color and opacity
                            .onTapGesture {
                                showCamera = true
                            }
                        
                        Spacer().frame(height: 80) // Add spacing between the profile picture and the form
                        
                        VStack(alignment: .leading) {
                            Text("Username: \(userArray[userIndex].username)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading) // Align the text to the left
                                .padding(.vertical, 20) // Add padding to adjust the spacing between the image and the username
                            
                            TextField("New Password", text: $newPassword)
                                .autocapitalization(.none) // Disable autocapitalization
                            
                        }
                        .padding(.horizontal)
                        Section {
                            Button("Change Password") {
                                changePassword(for: userIndex)
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
            .sheet(isPresented: $showCamera) {
                CameraView(profileImage: $profileImage)
            }
            .navigationBarTitle(Text("Profile"))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Warning"), message: Text("New password cannot be the same as the original password."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func changePassword(for userIndex: Int) {
        let originalPassword = userArray[userIndex].password
        
        // Check if the new password is different from the original password
        guard newPassword != originalPassword else {
            showAlert = true
            return
        }
        
        // Perform the password change logic here
        userArray[userIndex].password = newPassword
        print("New password: \(userArray[userIndex].password)")
        
        newPassword = "" // Reset the new password field
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
