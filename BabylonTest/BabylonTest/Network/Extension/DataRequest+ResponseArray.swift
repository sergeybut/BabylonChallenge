//
//  DataRequest+ResponseArray.swift
//  BabylonTest
//
//  Created by Serhii Butenko on 09/28/17.
//  Copyright © 2017 Serhii Butenko. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    @discardableResult
    func responseArray(completion: @escaping (APIResult<NSArray>) -> Void) -> Self {
        return responseJSON { response in
            guard let httpResponse = response.response else {
                completion( .error( .requestFailed))
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = response.data {
                    guard let object = try? JSONSerialization.jsonObject(with:data),
                        let json = object as? NSArray else {
                            completion( .error( .jsonConversionFailure))
                            return
                    }
                    completion( .success(json))
                }
            } else {
                completion( .error( .responseUnsuccessful))
            }
        }
    }
}
