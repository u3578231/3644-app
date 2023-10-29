# 3644-app
Important! If you want to access camera function, you must perform this change!
In targets (AI_learning.swift), go to Info which is in middle of Resource Tags and Build Settings, add Key"Privacy - Camera Use Description", Type = "String", Value = "AI_learning.swift Need camera access to provide an interface for users to change their profile pictures"


Important! If you want to access AR feature, you must perform this change!
In Build phases (between Build Settings and Build Rules), in copy bundle resources, add the all .usdz files to view the 3D models. In Build Phase, also add ARKit and RealityKit in Link Binary with Libraries
