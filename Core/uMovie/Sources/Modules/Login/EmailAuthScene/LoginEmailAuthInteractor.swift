import Foundation

protocol LoginEmailAuthBusinessLogic {
    func authenticate(request: LoginEmailAuth.Authenticate.Request)
}

final class LoginEmailAuthInteractor: LoginEmailAuthBusinessLogic {

    // MARK: - Private Properties

    private let presenter: LoginEmailAuthPresentationLogic
    private let worker: LoginEmailAuthWorkerProtocol

    // MARK: - Initializers

    init(
        presenter: LoginEmailAuthPresentationLogic,
        worker: LoginEmailAuthWorkerProtocol
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    // MARK: - Internal Methods

    func authenticate(request: LoginEmailAuth.Authenticate.Request) {

        worker.authenticate(email: request.email, password: request.password) {
            // TODO - Handle Authentication Response
        }
    }
}
