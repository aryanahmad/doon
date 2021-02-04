import Foundation
import Alamofire

class ApiManager: NSObject {
    static let shared = ApiManager()
    
    static let baseUrl: String = url
    var mainSession: Session!
    let tokenSession = Alamofire.Session()
    var authInterceptor: OAuthInterceptor!
    
    private override init(){
        let configuration = URLSessionConfiguration.default
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "accessToken")
        self.authInterceptor = OAuthInterceptor(baseURLString: ApiManager.baseUrl, accessToken: token ?? "")
        mainSession = Session(configuration: configuration, interceptor: self.authInterceptor)
        super.init()
        refreshToken()
    }
    
    
    
    public func refreshToken() {
        // --- Below we will check if the token will expire within 4 min. If so we will request a refresh token
        let currentDate = Date()
        let formatter = DateFormatter.utcDateFormatter
        let currentDateString = formatter.string(from: currentDate)
        let currentDateObj = formatter.date(from: currentDateString)
        //print("currentDate = " , currentDateObj!)
        let expirationDate = UserDefaults.standard.object(forKey: "token_expire") as! Date
        //print("expiration Date = " , expirationDate)
        let currentTime = 60*Calendar.current.component(.hour, from: currentDateObj!) + Calendar.current.component(.minute, from: currentDateObj!)
        let expirationTime =  60*Calendar.current.component(.hour, from: expirationDate) + Calendar.current.component(.minute, from: expirationDate)
        
        if(expirationTime - currentTime < 4)
        {
            // here we will refresh our token
            
            self.callRefreshToken{ (loginResponse) in
                if loginResponse != nil {
                    
                    let accessToken = loginResponse!.accessToken
                    let defaults = UserDefaults.standard
                    defaults.set(accessToken, forKey: "accessToken")
                    defaults.set(loginResponse?.expiration, forKey: "token_expire")
                    
                }
            }
            
        }
    }
    
    // MARK: - Function - Get Inventory Item List
    func callDashboardInventoryByItemGraphData(completion: @escaping (_ inventoryByItemGraphData: IventoryByItemGraphResponse?) -> Void){
        mainSession.request(url + ref + inventoryByItemGraphUrl).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).responseJSON { response  in
            switch response.result{
            case .failure(let f):
                print(">> ERROR:",f)
            case .success(let JSON):
                //print("graph Data = " ,JSON)
                if let data = response.data {
                    // Convert This to a Object
                    do {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.dateDecodingStrategy = .formatted(.utcDateFormatter)
                        let graphData = try jsonDecoder.decode(IventoryByItemGraphResponse.self, from: data)
                        completion(graphData)
                    }
                    catch let error as NSError
                    {
                        print(error)
                    }
                    
                }
                
            }
        }
    }
    
    // MARK: - Function - Get Inventory Item List
    func callIncomingShipmentList(completion: @escaping (_ incomingShipmentList: IncomingShipmentList?) -> Void){
        mainSession.request(url + incomingShipmentList).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).responseJSON { response  in
            switch response.result{
            case .failure(let f):
                print(">> ERROR:",f)
            case .success(let JSON):
                //print(JSON)
                if let data = response.data {
                    // Convert This to a Object
                    do {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.dateDecodingStrategy = .formatted(.utcDateFormatter)
                        let incomingShipmentList = try jsonDecoder.decode(IncomingShipmentList.self, from: data)
                        completion(incomingShipmentList)
                    }
                    catch let error as NSError
                    {
                        print(error)
                    }
                    
                }
                
            }
        }
    }
    
    // MARK: - Function - Get Inventory Item List
    func callInventoryItemList(completion: @escaping (_ inventoryItemList: InventoryItemListResponse?) -> Void){
        mainSession.request(url + inventoryItems).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).responseJSON { response  in
            switch response.result{
            case .failure(let f):
                print(">> ERROR:",f)
            case .success(let JSON):
                print(JSON)
                if let data = response.data {
                    // Convert This to a Object
                    do {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.dateDecodingStrategy = .formatted(.utcDateFormatter)
                        let inventoryItemList = try jsonDecoder.decode(InventoryItemListResponse.self, from: data)
                        completion(inventoryItemList)
                    }
                    catch let error as NSError
                    {
                        print(error)
                    }
                    
                }
                
            }
        }
    }
    
    
    // MARK: - Function - Dashboard API
    func callDashboardAPI(completion: @escaping (_ dashboardResponse: DashboardResponse?) -> Void){
        mainSession.request(url + ref + dashboardNum).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).responseJSON { response  in
            switch response.result{
            case .failure(let f):
                print(">> ERROR:",f)
            case .success(let s):
                //print(s)
                if let data = response.data {
                    
                    // Convert This in JSON
                    do {
                        let responseDecoded = try JSONDecoder().decode(DashboardResponse.self, from: data)
                        //print("DasboardResponse: ", responseDecoded.incomingShipmentCount, "Etc...")
                        completion(responseDecoded)
                    }catch let error as NSError{
                        print(error)
                    }
                    
                }
                
            }
        }
    }
    
    // MARK: - Function - Refresh Token API
    func callRefreshToken(completion: @escaping (_ refreshTokenResponse: LoginResponse?) -> Void){
        mainSession.request(url + refreshTokenUrl).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).responseJSON { response  in
            switch response.result{
            case .failure(let f):
                print(">> ERROR:",f)
            case .success(let JSON):
                //print("Success calling refreshToken: \n", s)
                if let data = response.data {
                    // Convert This into an object
                    do {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.dateDecodingStrategy = .formatted(.utcDateFormatter)
                        let refreshTokenResponse = try jsonDecoder.decode(LoginResponse.self, from: data)
                        completion(refreshTokenResponse)
                    }catch let error as NSError{
                        print(error)
                    }
                    
                }
                
            }
        }
    }
    
    // MARK: - Function - Get Form Reference Data
    
    func callGetFormReferenceData(completion: @escaping (_ formReferenceList: FormReferenceData?) -> Void){
        mainSession.request(url + formReferenceData).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).responseJSON { response  in
            switch response.result{
            case .failure(let f):
                print(">> ERROR:",f)
            case .success(let JSON):
                if let data = response.data {
                    // Convert This to a Object
                    do {
                        //print("JSON",JSON)
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.dateDecodingStrategy = .formatted(.utcDateFormatter)
                        let formRefList = try jsonDecoder.decode(FormReferenceData.self, from: data)
                        completion(formRefList)
                    }
                    catch let error as NSError
                    {
                        print(error)
                    }
                    
                }
                
            }
        }
    }
    
    // MARK: POST NEW INVENTORY ITEM
    public func createNewInventoryItem(myparams: Parameters , completion: @escaping (_ succeeded: Bool, _ message: String) -> Void) {
        
        mainSession.request("http://localhost:5000/api/inventory/inventory-item", method: .post, parameters: myparams, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 300).validate(contentType: ["application/json"]).responseJSON { response in
            switch response.result {
            case .success( _):
                completion(true, "")
            case .failure(let error):
                //print(error.localizedDescription)
                do {
                    if(response.data == nil)
                    {
                        return
                            completion(false, error.localizedDescription)
                    }
                    let responseDecoded = try JSONDecoder().decode(ErrorResponse.self, from: response.data!)
                    completion(false, responseDecoded.message)
                    
                } catch {
                    print("Error Calling Login: \(error).")
                }
                
                
            }
        }
        
    }
    
    
    
    // MARK: - Private - Refresh Tokens
    public func refreshTokens(completion: @escaping (_ succeeded: Bool, _ accessToken: String?) -> Void) {
        let urlString = "https://accounts.spotify.com/api/token"
        let parameters: [String:String] = [
            "grant_type": "client_credentials"
        ]
        let basicAuthHeader: HTTPHeader = HTTPHeader.authorization(username: "test", password: "temp")
        let contentTypeHeader: HTTPHeader = HTTPHeader.contentType("application/x-www-form-urlencoded")
        let authHeaders = HTTPHeaders(arrayLiteral: basicAuthHeader,contentTypeHeader)
        print("🔐 - Retrieving Token")
        
        tokenSession.request(urlString, method: .post,
                             parameters: parameters,
                             encoder: URLEncodedFormParameterEncoder.default ,
                             headers: authHeaders).validate(contentType: ["application/json"]).responseJSON {[weak self] response  in
                                guard let strongSelf = self else { return }
                                if
                                    let json = response.value as? [String: Any],
                                    let accessToken = json["access_token"] as? String
                                {
                                    print("🌕 - New Token: \(accessToken)")
                                    completion(true, accessToken)
                                } else {
                                    completion(false, nil)
                                }
        }
    }
}
