import UIKit
import Kingfisher

protocol CellDelegate: AnyObject {
    func tapped(for cell: PicturesCollectionViewCell)
}

class PicturesCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CellDelegate?
    
    var indexPath: IndexPath?
    var tapPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(getPoint(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func getPoint(_ sender: UITapGestureRecognizer) {
        tapPoint = sender.location(in: self)
        
        delegate?.tapped(for: self)
    }
        
    func configure(data: ApodModel.Nasa?, indexPath: IndexPath) {
        guard let data = data else { return }
        
        apodImageView.kf.setImage(with: URL(string: data[indexPath.item].url))
        titleLabel.text = data[indexPath.item].title
        dateLabel.text = data[indexPath.item].date
        copyrightLabel.text = "© \(data[indexPath.item].copyright ?? "None")"
        explanationLabel.text = data[indexPath.item].explanation
        
    }
    
    lazy var apodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    lazy var copyrightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    lazy var explanationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        
        return label
    }()
    
    private func fill() {
        addSubview(apodImageView)
        apodImageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.height.equalTo(250)
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(apodImageView.snp.bottom).offset(10)
            make.right.equalTo(apodImageView)
        }
        
        addSubview(copyrightLabel)
        copyrightLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel)
            make.left.equalTo(apodImageView)
            make.width.equalTo(160)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(copyrightLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
        }
        
        addSubview(explanationLabel)
        explanationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.left.bottom.right.equalToSuperview().inset(8)
        }
    }
}
