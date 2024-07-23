import Foundation

struct ObjectContainerDecoder<T: Decodable>: Decodable {
    let object: T
}
