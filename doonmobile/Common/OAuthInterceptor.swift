
import Foundation
import Alamofire

class OAuthInterceptor: Alamofire.RequestInterceptor {
    private var baseURLString: String
    private var accessToken: String?
    
    // MARK: - Initialization
    
    public init(baseURLString: String, accessToken: String) {
        self.baseURLString = baseURLString
        self.accessToken = accessToken
    }
    
    // MARK: - RequestAdapter
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void){

        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(baseURLString) {
            var adaptedRequest = urlRequest
            
            if let sToken = accessToken {
                adaptedRequest.setValue("Bearer \(sToken)", forHTTPHeaderField: "Authorization")
                //print("🔑 >> AuthToken appended: \(urlString)")
            }
            completion(.success(adaptedRequest))
        }
        
    }
    
    
    
    
    
    
    // MARK: - RequestRetrier
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        dump(request.request?.allHTTPHeaderFields!) //Prints twice because for some reason, I read that 401 causes to repeat the request automatically no matter what. But still no Authorization Header that I set in adapt()
        completion(.doNotRetry)
    }
    
    
    
}
