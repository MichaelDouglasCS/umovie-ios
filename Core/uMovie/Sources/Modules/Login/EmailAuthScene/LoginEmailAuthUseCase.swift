import Foundation

enum LoginEmailAuth {

    enum Authenticate {

        struct Request {
            let email: String
            let password: String
        }

        enum Response {
            case loading
            case success
            case failure
        }

        enum ViewModel {
            case loading
            case success
            case failure
        }
    }
}
