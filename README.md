# StorageKit
[![Version](https://img.shields.io/badge/Version-1.0.0-green.svg?style=flat-square)](https://img.shields.io/badge/version-1.21.0-green.svg?style=flat-square)
[![Swift](https://img.shields.io/badge/Swift-5.7_5.8_5.9-orange?style=flat-square)](https://img.shields.io/badge/Swift-5.7_5.8_5.9-Orange?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-iOS-blue.svg?style=flat-square)](https://img.shields.io/badge/Platforms-iOS-blue.svg?style=flat-square)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-green?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-green?style=flat-square)
[![CocoaPods](https://img.shields.io/badge/CocoaPods-compatible-green?style=flat-square)](https://img.shields.io/badge/CocoaPods-compatible-green?style=flat-square)
[![License](https://img.shields.io/badge/license-MIT-orange.svg?style=flat-square)](https://opensource.org/licenses/MIT)

StorageKit is a powerful and easy-to-use Swift library for data storage on iOS. Designed to simplify data persistence, StorageKit provides a clean and intuitive interface for efficiently storing and retrieving information.

## Features
- UserDefaults Storage: Easily save and retrieve user settings and preferences.
- Keychain Storage: Securely manage sensitive data using iOS Keychain.
- Memory Storage: Provides fast and easy access to temporary data without the need for disk I/O. It's perfect for caching data and storing information that does not need to be persisted.

## Architecture
The StorageManager in StorageKit is the main class responsible for managing data storage across different storage types, such as UserDefaults, Keychain, files, and memory. It utilizes a JSON provider for encoding and decoding objects and a set of storage providers to perform save, load, and delete operations.
The StorageManagerProtocol defines the essential methods for saving, loading, and deleting data from different storage types.

```swift
public protocol StorageManagerProtocol {
    func save<T: Encodable>(on storage: StorageType, withKey key: String, object: T)
    func load<T: Decodable>(from storage: StorageType, withKey key: String, toType type: T.Type) -> T?
    func delete(from storage: StorageType, withKey key: String)
}
```

### Key Components
jsonProvider: A JSON provider that implements the JSONProviderProtocol for encoding and decoding objects.
providers: A dictionary mapping different storage types (StorageType) to their respective implementations (StorageProtocol).

### Methods
- save<T: Encodable>(on storage: StorageType, withKey key: String, object: T): Saves an encoded object to the specified storage type.
- load<T: Decodable>(from storage: StorageType, withKey key: String, toType type: T.Type) -> T?: Loads a decoded object from the specified storage type.
- delete(from storage: StorageType, withKey key: String): Deletes an object from the specified storage type.
- clear(storage: StorageType): Clears all objects from the specified storage type.

## Installation

### Swift Package Manager
Add StorageKit to your project via Swift Package Manager. In Xcode, go to File > Swift Packages > Add Package Dependency and enter the repository URL:
```
https://github.com/SiqueiraYris/storage-kit
```

If you want to use this library inside a Swift Package Manager file, add it to the dependencies value of your Package.swift:
```swift
dependencies: [
    .package(url: "https://github.com/SiqueiraYris/storage-kit", branch: "main")
]
```
And then add it to the target:

```swift
.product(name: "StorageKit", package: "storage-kit")
```

### CocoaPods
To integrate StorageKit into your Xcode project using CocoaPods, specify it in your Podfile:
```
pod 'StorageKit', :git => 'https://github.com/SiqueiraYris/storage-kit'
```

## Usage

### UserDefaults

#### Saving data:
```swift
let object = false
StorageManager.shared.save(on: .userDefaults, withKey: "any-key", object: object)
```

#### Loading data:
```swift
let object = StorageManager.shared.load(from: .userDefaults, withKey: "any-key", toType: Bool.self)
```

#### Deleting data:
```swift
StorageManager.shared.delete(from: .userDefaults, withKey: "any-key")
```

#### Clear storage:
```swift
StorageManager.shared.clear(storage: .userDefaults)
```

### Keychain

#### Saving data:
```swift
let object = false
StorageManager.shared.save(on: .keychain, withKey: "any-key", object: object)
```

#### Loading data:
```swift
let object = StorageManager.shared.load(from: .keychain, withKey: "any-key", toType: Bool.self)
```

#### Deleting data:
```swift
StorageManager.shared.delete(from: .keychain, withKey: "any-key")
```

#### Clear storage:
```swift
StorageManager.shared.clear(storage: .keychain)
```

### Memory

#### Saving data:
```swift
let object = false
StorageManager.shared.save(on: .memory, withKey: "any-key", object: object)
```

#### Loading data:
```swift
let object = StorageManager.shared.load(from: .memory, withKey: "any-key", toType: Bool.self)
```

#### Deleting data:
```swift
StorageManager.shared.delete(from: .memory, withKey: "any-key")
```

#### Clear storage:
```swift
StorageManager.shared.clear(storage: .memory)
```

### Full Usage Example
```swift
// Save a value in memory
StorageManager.shared.save(on: .memory, withKey: "userSessionToken", object: "abc123")

// Load a value from memory
if let token: String = StorageManager.shared.load(from: .memory, withKey: "userSessionToken", toType: String.self) {
    print("Session token: \(token)")
}

// Delete a value from memory
StorageManager.shared.delete(from: .memory, withKey: "userSessionToken")

// Clear all values from memory
StorageManager.shared.clear(storage: .memory)
```

## Next steps
- File Manager storage
- Database storage

## License
StorageKit is licensed under the MIT license. See the LICENSE file for more details.
