import UIKit
import CoreData

class ApodViewController: UIViewController {

    private let reuseIdentifier = "Cell"
    
    private let vcView = ApodView()
    private let presenter = ApodPresenter()
    
    private var entities = [ObserverEntity]()

    
    override func loadView() {
        view = vcView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getData(collectionView: vcView.picturesCollectionView)
        setupUI()
        
        entities = DataManager.shared.observerEntities()
    }
    
    private func setupUI() {
        vcView.showDataButton.addTarget(self, action: #selector(showDataTapped), for: .touchUpInside)
        
        vcView.picturesCollectionView.delegate = self
        vcView.picturesCollectionView.dataSource = self
        vcView.picturesCollectionView.register(PicturesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    @objc func showDataTapped() {
        let vc = EntitiesTableViewController(entities: entities)
        present(vc, animated: true)
    }
}

extension ApodViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.nasaData?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PicturesCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(data: presenter.nasaData, indexPath: indexPath)
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
}

extension ApodViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w: CGFloat = UIScreen.main.bounds.width
        let h: CGFloat = collectionView.bounds.height
        
        return CGSize(width: w, height: h)
    }
}

extension ApodViewController: CellDelegate {
    func tapped(for cell: PicturesCollectionViewCell) {
        
        let alert = UIAlertController(title: "New Entity in DB", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        let entity = DataManager.shared.observerEntity(id: (cell.indexPath!.item + 1) * 111,
                                                       x_coord: cell.tapPoint.x,
                                                       y_coord: cell.tapPoint.y,
                                                       acod_date: cell.dateLabel.text ?? "",
                                                       acod_title: cell.titleLabel.text ?? "",
                                                       timestamp: dateFormatter.string(from: date))
        print(entity)
        entities.append(entity)
        DataManager.shared.save()
    }
}
