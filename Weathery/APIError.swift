import Foundation

enum APIError: Error {
    case failedRequest
    case failedTogetData
    case httpResponse(code: Int)
    case general(reason: String)
}
