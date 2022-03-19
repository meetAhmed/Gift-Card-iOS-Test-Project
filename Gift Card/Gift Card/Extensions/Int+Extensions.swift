import Foundation

// extension to decode a key
// check if key is int, decode it as int
// check if key is string, decode it as string, then convert to int
// if can not decode a key, use defualt value as 0
@propertyWrapper struct Flexible<T: FlexibleDecodable>: Decodable {
    var wrappedValue: T
    
    init(from decoder: Decoder) throws {
        wrappedValue = try T(container: decoder.singleValueContainer())
    }
}

protocol FlexibleDecodable {
    init(container: SingleValueDecodingContainer) throws
}

extension Int: FlexibleDecodable {
    init(container: SingleValueDecodingContainer) throws {
        if let int = try? container.decode(Int.self) {
            self = int
        } else if let string = try? container.decode(String.self), let int = Int(string) {
            self = int
        } else {
            self = 0
        }
    }
}
