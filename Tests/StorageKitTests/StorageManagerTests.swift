import XCTest
@testable import StorageKit

final class StorageManagerTests: XCTestCase {
    func test_save_shouldSetsObject() {
        let key = "any-key"
        let storageType = StorageType.memory
        let data = makeData()
        let (sut, jsonProviderSpy, storageSpy) = makeSUT(storageType: storageType)

        jsonProviderSpy.encodedDataToBeReturned = data
        sut.save(on: storageType, withKey: key, object: data)

        XCTAssertEqual(jsonProviderSpy.receivedMessages, [.encode])
        XCTAssertEqual(jsonProviderSpy.encodedDataToBeReturned, data)
        XCTAssertEqual(storageSpy.receivedMessages, [.save(key: key, data: data)])
    }

    func test_load_whenObjectIsSet_shouldDeliversObjectCorrectly() {
        let key = "any-key"
        let storageType = StorageType.memory
        let data = makeData()
        let (sut, jsonProviderSpy, storageSpy) = makeSUT(storageType: storageType)

        jsonProviderSpy.decodedDataToBeReturned = data
        jsonProviderSpy.encodedDataToBeReturned = data
        storageSpy.dataToBeReturned = data
        sut.save(on: storageType, withKey: key, object: data)
        let receivedValue = sut.load(from: storageType, withKey: key, toType: Data.self)

        XCTAssertEqual(jsonProviderSpy.receivedMessages, [.encode, .decode(json: data)])
        XCTAssertEqual(jsonProviderSpy.encodedDataToBeReturned, data)
        XCTAssertEqual(jsonProviderSpy.decodedDataToBeReturned as! Data, data)
        XCTAssertEqual(storageSpy.receivedMessages, [.save(key: key, data: data),
                                                     .load(key: key)])
        XCTAssertEqual(receivedValue, data)
    }

    func test_load_whenObjectIsNot_shouldDeliversEmptyObject() {
        let key = "any-key"
        let storageType = StorageType.memory
        let data = makeData()
        let (sut, jsonProviderSpy, storageSpy) = makeSUT(storageType: storageType)

        let receivedValue = sut.load(from: storageType, withKey: key, toType: Data.self)

        XCTAssertEqual(storageSpy.receivedMessages, [.load(key: key)])
        XCTAssertNil(receivedValue)
    }
    
    func test_delete_shouldDeletesObject() {
        let key = "any-key"
        let storageType = StorageType.memory
        let data = makeData()
        let (sut, jsonProviderSpy, storageSpy) = makeSUT(storageType: storageType)

        sut.delete(from: storageType, withKey: key)

        XCTAssertEqual(storageSpy.receivedMessages, [.delete(key: key)])
    }

    func test_clear_shouldClearStorage() {
        let key = "any-key"
        let storageType = StorageType.memory
        let data = makeData()
        let (sut, jsonProviderSpy, storageSpy) = makeSUT(storageType: storageType)

        sut.clear(storage: storageType)

        XCTAssertEqual(storageSpy.receivedMessages, [.clear])
    }

    // MARK: - Helpers

    private func makeSUT(storageType: StorageType) -> (
        sut: StorageManager,
        jsonProviderSpy: JSONProviderSpy,
        storageSpy: StorageProtocolSpy
    ) {
        let jsonProviderSpy = JSONProviderSpy()
        let storageSpy = StorageProtocolSpy()
        let sut = StorageManager(
            jsonProvider: jsonProviderSpy,
            providers: [storageType: storageSpy]
        )

        trackForMemoryLeaks(jsonProviderSpy)
        trackForMemoryLeaks(storageSpy)
        trackForMemoryLeaks(sut)

        return (sut, jsonProviderSpy, storageSpy)
    }

    private func makeData() -> Data {
        return "any-value".data(using: .utf8) ?? Data()
    }
}
