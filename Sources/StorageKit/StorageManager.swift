import Foundation

public protocol StorageManagerProtocol {
    func save<T: Encodable>(on storage: StorageType, withKey key: String, object: T)
    func load<T: Decodable>(from storage: StorageType, withKey key: String, toType type: T.Type) -> T?
    func delete(from storage: StorageType, withKey key: String)
}

public final class StorageManager: StorageManagerProtocol {
    private let jsonProvider: JSONProviderProtocol

    private var providers: [StorageType: StorageProtocol] = [:]

    public static let shared = StorageManager(
        jsonProvider: JSONProvider(),
        providers: StorageProvidersFactory.makeProviders()
    )

    public init(
        jsonProvider: JSONProviderProtocol,
        providers: [StorageType: StorageProtocol]
    ) {
        self.jsonProvider = jsonProvider
        self.providers = providers
    }

    public func save<T: Encodable>(on storage: StorageType, withKey key: String, object: T) {
        if let data = jsonProvider.encode(object: object),
           let storage = providers[storage] {
            storage.save(key: key, data: data)
        }
    }

    public func load<T: Decodable>(from storage: StorageType, withKey key: String, toType type: T.Type) -> T? {
        if let storage = providers[storage],
           let data = storage.load(key: key) {
            let convertedType = jsonProvider.decode(json: data, as: type.self)
            return convertedType
        }

        return nil
    }

    public func delete(from storage: StorageType, withKey key: String) {
        guard let storage = providers[storage] else { return }
        storage.delete(key: key)
    }

    public func clear(storage: StorageType) {
        guard let storage = providers[storage] else { return }
        storage.clear()
    }
}
