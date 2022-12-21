import UIKit
import SnapKit

class ApodView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NASA APOD"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 36)
        
        return label
    }()
    
    lazy var picturesCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    lazy var showDataButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Data", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 15
        
        return button
    }()
    
    private func fill() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.centerX.width.equalTo(scrollView)
            make.height.equalTo(scrollView).priority(250)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.left.right.equalToSuperview().inset(30)
        }
        
        contentView.addSubview(picturesCollectionView)
        picturesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview()
        }
        
        contentView.addSubview(showDataButton)
        showDataButton.snp.makeConstraints { make in
            make.top.equalTo(picturesCollectionView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(40)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(30)
        }
        

        
        
    }
}
