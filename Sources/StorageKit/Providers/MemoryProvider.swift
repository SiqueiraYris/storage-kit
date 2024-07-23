import Foundation

final class MemoryProvider: StorageProtocol {
    private var datas: [String: Data] = [:]

    func save(key: String, data: Data) {
        datas[key] = data
    }

    func delete(key: String) {
        datas.removeValue(forKey: key)
    }

    func load(key: String) -> Data? {
        return datas[key]
    }

    func clear() {
        datas.removeAll()
    }
}
