import Alamofire

enum Result<T, E> where E: Error, T: Decodable {
    case success(T)
    case failure(E)
}

typealias networkCompletionHandler<T: Decodable> = (Result<T, Error>) -> ()

// ApiService class makes network request using Alamofire Lib
// response is provided back to calling side via closure
class ApiService {
    
    static let shared: ApiService = ApiService()
    
    private init() {}
    
    // execute network request
    func executeRequest<T: Decodable>(withApi api: ApiProtocol, completion: @escaping networkCompletionHandler<T>) {
        AF.request(api.baseUrl,
                   method: Alamofire.HTTPMethod(rawValue: api.requestType.rawValue),
                   parameters: nil,
                   encoding: api.encoding,
                   headers: nil)
            .validate().responseDecodable(of: T.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(Result.failure(error))
                case .success(let data):
                    completion(Result.success(data))
                }
            }
    }
}
