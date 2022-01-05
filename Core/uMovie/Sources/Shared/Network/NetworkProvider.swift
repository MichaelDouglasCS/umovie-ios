import Alamofire
import Foundation

protocol NetworkProviderProtocol {

}

// MARK: - Definitions

typealias JSON = [String: Any]
typealias JSONArray = [[String: Any]]

// MARK: - NetworkProvider

final class NetworkProvider: NetworkProviderProtocol {

    // MARK: - Internal Properties

    static let shared = NetworkProvider()

    // MARK: - Initializers

    init() {
        AF.sessionConfiguration.allowsExpensiveNetworkAccess = true
        AF.sessionConfiguration.allowsConstrainedNetworkAccess = true
        AF.sessionConfiguration.waitsForConnectivity = true
        AF.sessionConfiguration.headers = .default
//        AF.sessionConfiguration.headers.add(.authorization(bearerToken: ""))
    }

    // MARK: - Internal Methods

    func requestDecodable<T: Decodable>(
        _ url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.prettyPrinted,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        requestModifier: Session.RequestModifier? = nil,
        completion: @escaping ((AFDataResponse<T>) -> Void)
    ) {
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers,
            interceptor: interceptor,
            requestModifier: requestModifier
        ).validate().responseDecodable(of: T.self, completionHandler: completion)
    }

    func requestJSON(
        _ url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.prettyPrinted,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        requestModifier: Session.RequestModifier? = nil,
        completion: @escaping ((AFDataResponse<Any>) -> Void)
    ) {
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers,
            interceptor: interceptor,
            requestModifier: requestModifier
        ).validate().responseJSON(completionHandler: completion)
    }
}
