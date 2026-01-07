import XCTest
import SwiftTreeSitter
import TreeSitterYttAnnotation

final class TreeSitterYttAnnotationTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_ytt_annotation())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading YttAnnotation grammar")
    }
}
