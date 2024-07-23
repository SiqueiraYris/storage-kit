import XCTest
@testable import StorageKit

final class MemoryProviderTests: XCTestCase {
    func test_save_shouldSetsObject() {
        let key = "any-key"
        let expectedData = makeData()
        let sut = makeSUT()

        sut.save(key: key, data: expectedData)
        let receivedData = sut.load(key: key)

        XCTAssertEqual(expectedData, receivedData)
    }

    func test_load_whenDataIsEmpty_shouldDeliversEmptyObject() {
        let key = "any-key"
        let sut = makeSUT()

        let receivedData = sut.load(key: key)

        XCTAssertNil(receivedData)
    }

    func test_delete_shouldDeletesObject() {
        let key = "any-key"
        let data = makeData()
        let sut = makeSUT()
        sut.save(key: key, data: data)

        sut.delete(key: key)
        let receivedData = sut.load(key: key)

        XCTAssertNil(receivedData)
    }

    func test_clear_shouldDeliversEmptyObject() {
        let key = "any-key"
        let data = makeData()
        let sut = makeSUT()
        sut.save(key: key, data: data)

        sut.clear()
        let receivedData = sut.load(key: key)

        XCTAssertNil(receivedData)
    }

    // MARK: - Helpers

    private func makeSUT() -> MemoryProvider {
        let sut = MemoryProvider()

        trackForMemoryLeaks(sut)

        return sut
    }

    private func makeData() -> Data {
        return "any-value".data(using: .utf8) ?? Data()
    }
}
