import UIKit

class ApodPresenter {
    
    var nasaData: ApodModel.Nasa?
    func getData(collectionView: UICollectionView) {
        NetworkService().getData(url: "https://api.nasa.gov/planetary/apod",
                                 startDate: "2022-09-12", endDate: "2022-09-22",
                                 apiKey: "hHRozYdj4lkiC0EMOyhBH7mqX7hyAU89JgMp80LN") { result in
            switch result {
            case .success(let data):
                self.nasaData = data
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            case .failure( _):
                print("error")
            }
        }
    }
    
}
