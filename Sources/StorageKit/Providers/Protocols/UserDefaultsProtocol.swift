import Foundation

protocol UserDefaultsProtocol {
    func set(_ value: Any?, forKey defaultName: String)
    func removeObject(forKey defaultName: String)
    func object(forKey defaultName: String) -> Any?
    func removePersistentDomain(forName domainName: String)
    func synchronize() -> Bool
}

extension UserDefaults: UserDefaultsProtocol { }
