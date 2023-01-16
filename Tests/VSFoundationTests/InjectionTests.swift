import XCTest
@testable import VSFoundation

protocol Animal {
    func walk()
}

struct Cat: Animal {
    func walk() { }
}

class BasicInjection {
    @OptionalInject var pet: Animal?
}

struct AppConfig: Config {
    func configure(_ injector: Injector) {
        injector.map(Animal.self) {
            Cat()
        }
    }
}

final class InjectionTests: XCTestCase {
    let context = Context()

    func test_injection() {
        inject()
        let sut = BasicInjection()
        XCTAssertNotNil(sut.pet)
    }

    func test_unmap() {
        inject()
        let sut = BasicInjection()
        XCTAssertNotNil(sut.pet)

        Injector.main.unmap(Animal.self)

        let unmappedSut = BasicInjection()
        XCTAssertNil(unmappedSut.pet)
    }

    private func inject() {
        context.configure(AppConfig()) {}
    }
}
