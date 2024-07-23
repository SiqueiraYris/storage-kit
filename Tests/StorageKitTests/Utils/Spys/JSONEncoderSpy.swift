import Foundation
@testable import StorageKit

final class JSONEncoderSpy: JSONEncoderProtocol {
    enum Messages: Equatable {
        case encode
    }

    var outputFormatting: JSONEncoder.OutputFormatting = .prettyPrinted
    var receivedMessages: [Messages] = []
    var encodedDataToBeReturned: Data?

    func encode<T>(_ value: T) throws -> Data where T: Encodable {
        receivedMessages.append(.encode)
        return encodedDataToBeReturned ?? Data()
    }
}
