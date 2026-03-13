import Testing
import OSLog
import Foundation
@testable import HelloSkip

let logger: Logger = Logger(subsystem: "HelloSkip", category: "Tests")

@Suite struct HelloSkipTests {

    @Test func helloSkip() throws {
        logger.log("running testHelloSkip")
        #expect(1 + 2 == 3, "basic test")
    }

    @Test func decodeType() throws {
        // load the TestData.json file from the Resources folder and decode it into a struct
        let resourceURL: URL = try #require(Bundle.module.url(forResource: "TestData", withExtension: "json"))
        let testData = try JSONDecoder().decode(TestData.self, from: Data(contentsOf: resourceURL))
        #expect(testData.testModuleName == "HelloSkip")
    }

}

struct TestData : Codable, Hashable {
    var testModuleName: String
}
