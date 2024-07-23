@testable import StorageKit

final class UserDefaultsSpy: UserDefaultsProtocol {
    enum Messages: Equatable {
        case set(forKey: String)
        case removeObject(forKey: String)
        case object(forKey: String)
        case removePersistentDomain(domainName: String)
        case synchronize
    }

    var receivedMessages: [Messages] = []
    var objectToBeReturned: Any?
    var domainToPersist: String = ""

    func set(_ value: Any?, forKey defaultName: String) {
        objectToBeReturned = value
        receivedMessages.append(.set(forKey: defaultName))
    }

    func removeObject(forKey defaultName: String) {
        receivedMessages.append(.removeObject(forKey: defaultName))
    }

    func object(forKey defaultName: String) -> Any? {
        receivedMessages.append(.object(forKey: defaultName))
        return objectToBeReturned
    }

    func removePersistentDomain(forName domainName: String) {
        receivedMessages.append(.removePersistentDomain(domainName: domainToPersist))
    }

    func synchronize() -> Bool {
        receivedMessages.append(.synchronize)
        return Bool.random()
    }
}
