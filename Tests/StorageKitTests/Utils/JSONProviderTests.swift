import XCTest
@testable import StorageKit

final class JSONProviderTests: XCTestCase {
    func test_decode_shouldDecodeObjectCorrectly() {
        let expectedValue = "any-value"
        let data = makeData(value: expectedValue)
        let (sut, decodeSpy, _) = makeSUT()

        decodeSpy.decodedDataToBeReturned = expectedValue
        let receivedValue = sut.decode(json: data, as: String.self)

        XCTAssertEqual(decodeSpy.receivedMessages, [.decode(data: data)])
        XCTAssertEqual(expectedValue, receivedValue)
    }

    func test_encode_shouldEncodeObjectCorrectly() {
        let value = "any-value"
        let expectedData = makeData(value: value)
        let (sut, _, encoderSpy) = makeSUT()

        encoderSpy.encodedDataToBeReturned = expectedData
        let receivedData = sut.encode(object: value)

        XCTAssertEqual(encoderSpy.receivedMessages, [.encode])
        XCTAssertEqual(expectedData, receivedData)
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: JSONProvider,
        decoderSpy: JSONDecoderSpy,
        encoderSpy: JSONEncoderSpy
    ) {
        let decoderSpy = JSONDecoderSpy()
        let encoderSpy = JSONEncoderSpy()
        let sut = JSONProvider(decoder: decoderSpy, encoder: encoderSpy)

        trackForMemoryLeaks(decoderSpy)
        trackForMemoryLeaks(encoderSpy)
        trackForMemoryLeaks(sut)

        return (sut, decoderSpy, encoderSpy)
    }

    private func makeData(value: String) -> Data {
        return value.data(using: .utf8) ?? Data()
    }
}
