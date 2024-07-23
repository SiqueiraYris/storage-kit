import Foundation
@testable import StorageKit

final class JSONDecoderSpy: JSONDecoderProtocol {
    enum Messages: Equatable {
        case decode(data: Data)
    }

    var receivedMessages: [Messages] = []
    var decodedDataToBeReturned: Decodable?

    func decode<T>(_ type: T.Type,
                   from data: Data) throws -> T where T: Decodable {
        receivedMessages.append(.decode(data: data))
        return decodedDataToBeReturned as! T
    }
}
