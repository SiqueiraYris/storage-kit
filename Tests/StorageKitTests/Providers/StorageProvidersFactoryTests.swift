import XCTest
@testable import StorageKit

final class StorageProvidersFactoryTests: XCTestCase {
    func test_makeProviders_shouldSetupsProvidersCorrectly() {
        let sut = StorageProvidersFactory.makeProviders()

        XCTAssertEqual(sut.count, 3)
        XCTAssertNotNil(sut[.keychain])
        XCTAssertNotNil(sut[.userDefaults])
        XCTAssertNotNil(sut[.memory])
        XCTAssertTrue(sut[.keychain] is KeychainProvider)
        XCTAssertTrue(sut[.userDefaults] is UserDefaultsProvider)
        XCTAssertTrue(sut[.memory] is MemoryProvider)
    }
}
