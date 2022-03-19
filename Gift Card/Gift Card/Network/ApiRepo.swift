import Alamofire

enum ApiRepo {
    // only one endpoint to be used in this app
    case getCards
}

extension ApiRepo: ApiProtocol {
 
    var baseUrl: String {
        "https://zip.co/giftcards/api/giftcards"
    }
    
    var requestType: ApiRequestType {
        switch self {
        case .getCards:
            return .GET
        }
    }
    
    var encoding: ParameterEncoding {
        URLEncoding.default
    }
}
