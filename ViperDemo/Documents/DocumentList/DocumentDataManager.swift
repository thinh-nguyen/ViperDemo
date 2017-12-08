//
//  DocumentDataManager.swift
//  ViperDemo
//
//  Created by Thinh Nguyen on 12/3/17.
//  Copyright © 2017 Prospertin. All rights reserved.
//
import Foundation
import PromiseKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

public class DocumentDataManager: DataManagerInputProtocol {
    var interactor:DataManagerOutputProtocol?

    public func retrieveDocuments(payload: Parameters)  {
        PromiseRestClient.getJsonFromUrl(urlString: "https://ins-services.meltwater.com/documentService/v3/documents?", payload: payload)
            .then { (page: DocumentsPage) -> Void in // Return Void to stop the promise chain
                print(page)
                self.interactor?.didRetrieveDocuments(documents: page.documents)
            }
            .catch { error in
                print(error)
                self.interactor?.onError(errorMsg: error.localizedDescription)
        }
    }
}

public class PromiseRestClient {
    
    public static let headers: HTTPHeaders = [
        "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1c2VyIjp7Il9pZCI6IjU1MDhkMDgzZTIzZmQ5MjkwOGZmMDlkYSIsImZpcnN0TmFtZSI6IlRoaW5oIiwibGFzdE5hbWUiOiJOZ3V5ZW4iLCJlbWFpbCI6InRoaW5oLm5ndXllbkBtZWx0d2F0ZXIuY29tIiwicGFzc3dvcmQiOiIkMmEkMTAkTHVuWUJxcGVVV0YwdUhHTjJxWDhWT1p6WkQyMi43QTBNRU0wck1WeEhmU1NJZE4xZlpVWEMiLCJhY3RpdmVDb21wYW55SWQiOiI1NmU5ODY1OTYzNzNmYjJkY2ViYTE2MGYiLCJpc0ludGVybmFsIjp0cnVlLCJ0aW1lem9uZSI6IkFtZXJpY2EvTG9zX0FuZ2VsZXMiLCJsYW5ndWFnZSI6ImVuIiwiY3JlYXRlZCI6IjIwMTUtMDMtMThUMDE6MTA6MjcuMTUyWiIsIm1vZGlmaWVkIjoiMjAxNy0xMS0yOVQwODowMDozMy44NDZaIn0sImNvbXBhbnkiOnsiX2lkIjoiNTZlOTg2NTk2MzczZmIyZGNlYmExNjBmIiwibmFtZSI6IlRoaW5oIE5ndXllbiAtIEZhaXJoYWlyIiwiY291bnRyeSI6InVzIiwiYWNjb3VudElkIjoxNTk5NjA1LCJvcHBvcnR1bml0eUlkIjoyMDcyNzcxLCJjcmVhdGVkIjoiMjAxNi0wMy0xNlQxNjoxNDoxNy4wMDZaIiwibW9kaWZpZWQiOiIyMDE2LTA4LTE2VDE4OjAxOjIzLjMyM1oifSwiZXhwIjoxNTEyNjI3MTczNTIwfQ.eRtZTTTO5C0BafdbvNvmpWlnGRXNzvgOtXiDNHwEUMIWnrebjzarqHwyXy-gNcN3mGSJFyWsYqTD0tzKO0OLnuruQHPXEiA7FPvW9dB_IQzdno_0jrY07gpCfrpjAziJJf4AaQdO4KKiA38UJ41InLOv8YbRxTSORuLz01MiDzRNFWfjRx22OMZfC5nA630FSGRhz8IjwcV2DPgc6wZlHIIdeaCdWzMP2tMN8BCq-RVhsBxWVgjFfHlN_aczGqJrdCKf8T6M3-Rtf9YuJWTlteMmYQgODX39vivyKhItWb__u-Qbn1SOyjkuIYC4BQSNEyj2HWS_4e5DD-1hqLOZPw",
        "Accept": "application/json"
    ]
    
    internal static func getFromUrl(urlString: String) -> Promise<NSDictionary> {
        
        return Promise { fulfill, reject in
            Alamofire.request(urlString).validate().responseJSON { response in
                switch response.result {
                case .success(let dict):
                    fulfill(dict as! NSDictionary)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
    
    internal static func getFromUrl(urlString: String, parameters: Parameters? ) -> Promise<NSDictionary> {
        
        return Promise { fulfill, reject in
            Alamofire.request(urlString, parameters: parameters, headers: headers).validate().responseJSON { response in
                switch response.result {
                case .success(let dict):
                    fulfill(dict as! NSDictionary)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
    
    internal static func getJsonFromUrl<T: Mappable>(urlString: String, payload: Parameters? ) -> Promise<T> {
        return Promise { fulfill, reject in
            Alamofire.request(urlString, method: .get, parameters: payload, headers: headers)
                .validate().responseObject { (response: DataResponse<T>) in
                    switch response.result {
                    case .success(let obj):
                        fulfill(obj )
                    case .failure(let error):
                        reject(error)
                    }
            }
        }
    }
    
    internal static func postToUrl<T: Mappable>(urlString: String, payload: Parameters? ) -> Promise<T> {
        return Promise { fulfill, reject in
            Alamofire.request(urlString, method: .post, parameters: payload, encoding: JSONEncoding.default, headers: headers)
                .validate().responseObject { (response: DataResponse<T>) in
                    switch response.result {
                    case .success(let obj):
                        fulfill(obj )
                    case .failure(let error):
                        reject(error)
                    }
            }
        }
    }
    
}

