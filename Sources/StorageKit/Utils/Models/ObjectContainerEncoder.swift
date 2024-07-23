import Foundation

struct ObjectContainerEncoder<T: Encodable>: Encodable {
    let object: T
}
