import Foundation

final class UserDefaultsProvider: StorageProtocol {
    private let userDefaults: UserDefaultsProtocol

    init(_ userDefaults: UserDefaultsProtocol) {
        self.userDefaults = userDefaults
    }

    func save(key: String, data: Data) {
        userDefaults.set(data, forKey: key)
    }

    func delete(key: String) {
        userDefaults.removeObject(forKey: key)
    }

    func load(key: String) -> Data? {
        if let data = userDefaults.object(forKey: key) as? Data {
            return data
        }
        return nil
    }

    func clear() {
        if let bundleId = Bundle.main.bundleIdentifier {
            userDefaults.removePersistentDomain(forName: bundleId)
            _ = userDefaults.synchronize()
        }
    }
}
