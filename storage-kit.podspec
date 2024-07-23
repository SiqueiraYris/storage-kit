Pod::Spec.new do |spec|
    spec.name = 'StorageKit'
    spec.version = '1.0.0'
    spec.license = 'MIT'
    spec.summary = 'Swift library for data storage on iOS'
    spec.homepage = 'https://github.com/SiqueiraYris/storage-kit'
    spec.authors = { 'Yris Siqueira' => 'siqueirayris@hotmail.com' }
    spec.source = { :git => 'https://github.com/SiqueiraYris/storage-kit', :tag => spec.version.to_s }
    spec.source_files = [
        'Sources/StorageKit/**', 
        'Sources/StorageKit/**/*.{swift}'
    ]
    spec.requires_arc = true
    spec.static_framework = true
    spec.ios.deployment_target = '12.0'
    spec.platforms = { :ios => "12.0" }
    spec.swift_versions = ['5']
end
