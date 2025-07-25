//
//  APIService.swift
//  PraveenKumar_MVVM
//
//  Created by 1976969 on 23/07/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case decodingFailed
    case noData
    case unknown
}

class APIService {
    /// Function call for main data fetch
    /// - Parameter completionHandler: completionHandler with Result and Error type defined with escaping as the data is asynchronous type and void as return type
    func fetchCustomerData(url: URL,completionHandler: @escaping (Result<[CustomerDataModel], Error>) -> Void) {
        
        // Initiate data fetch
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            // Note: A video has been attached in the project zip file with the same project tested with mock data.
            if let error = error {
                print("Error: \(String(describing: error))")
                completionHandler(.failure(APIError.noData)) // Data error from URL
            }
            
            if let fetchedData = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let customerData = try jsonDecoder.decode([CustomerDataModel].self, from: fetchedData)
                    completionHandler(.success(customerData)) // On fetch success
                } catch {
                    print("Error: \(String(describing: error))")
                    completionHandler(.failure(APIError.decodingFailed)) // On JSON decode fail
                }
            }
             
             /*
            //Below test code is not deleted for mock data testing purposes if the URL defined is throwing code=-1200 due to some restrictions
            let testJSON = """
        [{"id":"0","customerName":"Ava","customerAddress":"123 Main St, Anytown, CA 91234","phoneNumber":"(0)152-28817386","imageURL":"https://placebear.com/g/200/200"},{"id":"1","customerName":"Amelia","customerAddress":"456 Oak Ave, Somecity, NY 10001","phoneNumber":"(0)152 28895456","imageURL":"https://picsum.photos/id/1/5000/3333"},{"id":"2","customerName":"Aiden","customerAddress":"789 Pine Ln, Othertown, TX 75001","phoneNumber":"(0)152-54599371","imageURL":"https://picsum.photos/id/2/5000/3333"},{"id":"3","customerName":"Alex","customerAddress":"101 Elm Rd, Smallville, IL 60601","phoneNumber":"(0)172-9925904","imageURL":"https://picsum.photos/id/3/5000/3333"},{"id":"4","customerName":"Avery","customerAddress":"222 Maple Dr, Bigcity, FL 33101","phoneNumber":"(0)172-9968532","imageURL":"https://picsum.photos/id/4/5000/3333"},{"id":"5","customerName":"Bella","customerAddress":"333 Birch Ct, Metropolis, GA 30301","phoneNumber":"(0)152-28817386","imageURL":"https://picsum.photos/id/5/5000/3334"},{"id":"6","customerName":"Brooke","customerAddress":"999 Willow Way, Gotham, NJ 07001","phoneNumber":"(0)172-9973185","imageURL":"https://picsum.photos/id/6/5000/3333"},{"id":"7","customerName":"Blake","customerAddress":"555 Cedar Ln, Springfield, MO 65801","phoneNumber":"(0)172-9973186","imageURL":"https://picsum.photos/id/7/4728/3168"},{"id":"8","customerName":"Brandon","customerAddress":"888 Walnut St, Sunnyvale, CA 94085","phoneNumber":"(0)172-9980752","imageURL":"https://picsum.photos/id/8/5000/3333"},{"id":"9","customerName":"Bailey","customerAddress":"444 Park Ave, Central City, NY 10022","phoneNumber":"(0)174-9091317","imageURL":"https://picsum.photos/id/9/5000/3269"}]
        """.data(using: .utf8)!
            
            do {
                let customerData = try JSONDecoder().decode([CustomerDataModel].self, from: testJSON)
                completionHandler(.success(customerData)) // On fetch success
            } catch {
                print("Error: \(String(describing: error))")
                completionHandler(.failure(APIError.decodingFailed)) // On JSON decode fail
            }
             */
              
        }
        dataTask.resume()
        
    }
    
}
