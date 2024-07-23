import Foundation

public protocol JSONEncoderProtocol {
    var outputFormatting: JSONEncoder.OutputFormatting { get set }

    func encode<T>(_ value: T) throws -> Data where T: Encodable
}

extension JSONEncoder: JSONEncoderProtocol { }
