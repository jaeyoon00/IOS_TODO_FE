import UIKit

class RequestViewCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let acceptButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.systemBlue, for: .normal)
        let image = UIImage(systemName: "checkmark")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nameTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let refuseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.systemBlue, for: .normal)
        let image = UIImage(systemName: "multiply")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        return button
    }()
    
    var textLabelRightConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(acceptButton)
        
        NSLayoutConstraint.activate([
            acceptButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            acceptButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50)
        ])
        
        contentView.addSubview(refuseButton)
        
        NSLayoutConstraint.activate([
            refuseButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            refuseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        contentView.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        
    
        contentView.backgroundColor = UIColor(named: "mainColor")
    }
    
    func setProfileImage(image: UIImage?) {
        profileImageView.image = image
    }
    func setNameText(text: String) {
            nameTextLabel.text = text
        }
}
