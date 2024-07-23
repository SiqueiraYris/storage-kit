import XCTest
@testable import StorageKit

final class UserDefaultsProviderTests: XCTestCase {
    func test_save_shouldSetsObject() {
        let key = "any-key"
        let data = makeData()
        let (sut, spy) = makeSUT()

        sut.save(key: key, data: data)

        XCTAssertEqual(spy.receivedMessages, [.set(forKey: key)])
    }

    func test_load_whenObjectWasNotSet_shouldCallsObjectAndReturnEmptyData() {
        let key = "any-key"
        let (sut, spy) = makeSUT()

        let object = sut.load(key: key)

        XCTAssertEqual(spy.receivedMessages, [.object(forKey: key)])
        XCTAssertNil(object)
    }

    func test_load_whenObjectWasSet_shouldCallsObjectAndReturnCorrectData() {
        let key = "any-key"
        let data = makeData()
        let (sut, spy) = makeSUT()

        sut.save(key: key, data: data)
        let object = sut.load(key: key)

        XCTAssertEqual(spy.receivedMessages, [.set(forKey: key),
                                              .object(forKey: key)])
        XCTAssertEqual(object, data)
    }

    func test_delete_shouldRemovesObject() {
        let key = "any-key"
        let (sut, spy) = makeSUT()

        sut.delete(key: key)

        XCTAssertEqual(spy.receivedMessages, [.removeObject(forKey: key)])
    }

    func test_clear_shouldClearAndSynchronizeData() {
        let domainToPersist = "any-domain"
        let (sut, spy) = makeSUT()

        spy.domainToPersist = domainToPersist
        sut.clear()

        XCTAssertEqual(spy.receivedMessages, [.removePersistentDomain(domainName: domainToPersist),
                                              .synchronize])
    }

    // MARK: - Helpers

    private func makeSUT() -> (sut: UserDefaultsProvider,
                               spy: UserDefaultsSpy) {
        let spy = UserDefaultsSpy()
        let sut = UserDefaultsProvider(spy)

        trackForMemoryLeaks(spy)
        trackForMemoryLeaks(sut)

        return (sut, spy)
    }

    private func makeData() -> Data {
        return "any-value".data(using: .utf8) ?? Data()
    }
}
