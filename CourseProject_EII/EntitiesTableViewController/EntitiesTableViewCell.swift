import UIKit

class EntitiesTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        fill()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(indexPath: IndexPath, data: [ObserverEntity]) {
        let e = data[indexPath.row]
        
        titleLabel.text = e.acod_title
        dateLabel.text = "ACOD date: \(e.acod_date ?? "error")"
        coordLabel.text = "x: \(String(format: "%.2f", e.x_coord)), y: \(String(format: "%.2f", e.y_coord))"
        idLabel.text = "\(e.id)"
        timestampLabel.text = "Tap timestamp: \(e.timestamp ?? "error")"
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    lazy var coordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 13)
        
        return label
    }()
    
    lazy var timestampLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    private func fill() {
        backgroundColor = .white
        selectionStyle = .none
        
        addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(20)
        }
        
        addSubview(coordLabel)
        coordLabel.snp.makeConstraints { make in
            make.top.equalTo(idLabel)
            make.left.equalTo(idLabel.snp.right).offset(10)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(10)
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.right.equalTo(titleLabel)
        }
        
        addSubview(timestampLabel)
        timestampLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.right.equalTo(dateLabel)
        }
    }

}
