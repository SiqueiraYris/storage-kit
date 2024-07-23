import Foundation
@testable import StorageKit

final class StorageProtocolSpy: StorageProtocol {
    enum Messages: Equatable {
        case save(key: String, data: Data)
        case delete(key: String)
        case load(key: String)
        case clear
    }

    var receivedMessages: [Messages] = []
    var dataToBeReturned: Data?

    func save(key: String, data: Data) {
        receivedMessages.append(.save(key: key, data: data))
    }

    func delete(key: String) {
        receivedMessages.append(.delete(key: key))
    }

    func load(key: String) -> Data? {
        receivedMessages.append(.load(key: key))
        return dataToBeReturned
    }

    func clear() {
        receivedMessages.append(.clear)
    }
}
