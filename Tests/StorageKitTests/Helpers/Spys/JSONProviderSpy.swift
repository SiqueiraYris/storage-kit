import Foundation
@testable import StorageKit

final class JSONProviderSpy: JSONProviderProtocol {
    enum Messages: Equatable {
        case encode
        case decode(json: Data)
    }

    var receivedMessages: [Messages] = []
    var encodedDataToBeReturned: Data?
    var decodedDataToBeReturned: Decodable?

    func encode<T>(object: T) -> Data? where T : Encodable {
        receivedMessages.append(.encode)
        return encodedDataToBeReturned
    }

    func decode<T>(json: Data, as clazz: T.Type) -> T? where T : Decodable {
        receivedMessages.append(.decode(json: json))
        return decodedDataToBeReturned as? T
    }
}
