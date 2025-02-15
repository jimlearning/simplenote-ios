import Foundation
import SimplenoteEndpoints
@testable import Simplenote

extension Remote {
    static func randomResult() -> Result<Data?, RemoteError> {
        if Bool.random() {
            return .success(nil)
        }

        return .failure(RemoteError(statusCode: 0, response: nil, networkError: nil))
    }
}
