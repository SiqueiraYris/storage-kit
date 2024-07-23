import Foundation

struct StorageProvidersFactory {
    static func makeProviders() -> [StorageType: StorageProtocol] {
        let keychain = KeychainProvider()
        let userDefaults = UserDefaultsProvider(UserDefaults.standard)
        let memory = MemoryProvider()

        return [
            .userDefaults: userDefaults,
            .keychain: keychain,
            .memory: memory
        ]
    }
}
