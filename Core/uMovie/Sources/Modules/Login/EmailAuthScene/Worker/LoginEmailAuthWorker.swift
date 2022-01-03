import Foundation

protocol LoginEmailAuthWorkerProtocol {
    func authenticate(email: String, password: String, completion: @escaping (() -> Void))
}

final class LoginEmailAuthWorker: LoginEmailAuthWorkerProtocol {

    // MARK: - Internal Methods

    func authenticate(email: String, password: String, completion: @escaping (() -> Void)) {
        // TODO - Authenticate with API
    }
}
