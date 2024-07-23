import Foundation

public protocol JSONProviderProtocol {
    func encode<T: Encodable>(object: T) -> Data?
    func decode<T: Decodable>(json: Data, as clazz: T.Type) -> T?
}

public final class JSONProvider: JSONProviderProtocol {
    private let decoder: JSONDecoderProtocol
    private var encoder: JSONEncoderProtocol

    public init(decoder: JSONDecoderProtocol = JSONDecoder(),
                encoder: JSONEncoderProtocol = JSONEncoder()) {
        self.decoder = decoder
        self.encoder = encoder
    }

    public func encode<T: Encodable>(object: T) -> Data? {
        do {
            if #available(iOS 13.0, *) {
                encoder.outputFormatting = .prettyPrinted
                return try? encoder.encode(object)
            } else {
                let objectContainer = ObjectContainerEncoder(object: object)
                return try? encoder.encode(objectContainer)
            }
        }
    }

    public func decode<T: Decodable>(json: Data, as clazz: T.Type) -> T? {
        do {
            if #available(iOS 13.0, *) {
                let data = try? decoder.decode(T.self, from: json)
                return data
            } else {
                let objectContainer = try? decoder.decode(ObjectContainerDecoder<T>.self, from: json)
                return objectContainer?.object
            }
        }
    }
}
