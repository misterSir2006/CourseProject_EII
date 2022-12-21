import UIKit

class NetworkService {
    
    func getData(url: String,
                 startDate: String,
                 endDate: String,
                 apiKey: String, completionHandler: @escaping (Result<ApodModel.Nasa, Error>) -> Void) {
        
        let url = URL(string: "\(url)?api_key=\(apiKey)&start_date=\(startDate)&end_date=\(endDate)&thumbs=true")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard data != nil else {
                completionHandler(.failure(error!))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(ApodModel.Nasa.self, from: data!)
                
                DispatchQueue.main.async {
                    completionHandler(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
        
    }
    
}
