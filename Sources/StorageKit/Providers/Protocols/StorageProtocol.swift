import Foundation

public protocol StorageProtocol {
    func save(key: String, data: Data)
    func delete(key: String)
    func load(key: String) -> Data?
    func clear()
}
