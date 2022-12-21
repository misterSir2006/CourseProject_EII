import Foundation

class ApodModel {
    
    // MARK: - Data
    struct NasaData: Codable {
        let copyright: String?
        let date, explanation: String
        let hdurl: String
        let title: String
        let url: String

        enum CodingKeys: String, CodingKey {
            case copyright, date, explanation, hdurl
            case title, url
        }
    }

    typealias Nasa = [NasaData]
}
