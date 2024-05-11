//
//  StudentAccountsViewController.swift
//  BLESample
//
//  Created by 蔡佳玲 on 2023/10/21.
//

import UIKit
import SnapKit


class StudentAccountsViewController: UIViewController {
    
    let manager = StudentDataManager()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "註冊學生基本資料"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 28)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "學生姓名:"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cardIDTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "學生證卡號:"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameinputTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.placeholder = "請輸入您的姓名"
        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var cardIDLabel: UILabel = {
        let label = UILabel()
        label.text = self.cardID
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var studentIDTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "學生學號:"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var studentIDTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.placeholder = "請輸入您的學號"
        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var seatTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "學生座號:"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var seatTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.placeholder = "請輸入您的座號"
        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var genderTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "性別:"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var genderTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.placeholder = "請輸入您的性別"
        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var birthTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "出生年月日:"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var birthTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.placeholder = "例：1990/10/05"
        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var classTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "班級:"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var classTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.placeholder = "例：五年三班"
        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
   
    
    lazy var confirmBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("填寫完成", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 24
        btn.backgroundColor = .systemBlue
        btn.addTarget(self, action: #selector(sendInfo), for: .touchUpInside)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var cardID: String?
    init(cardID: String?) {
        self.cardID = cardID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        view.backgroundColor = .systemGray6
        view.addSubview(titleLabel)
        view.addSubview(nameTitleLabel)
        view.addSubview(cardIDTitleLabel)
        view.addSubview(nameinputTextField)
        view.addSubview(cardIDLabel)
        view.addSubview(studentIDTitleLabel)
        view.addSubview(studentIDTextField)
        view.addSubview(seatTitleLabel)
        view.addSubview(seatTextField)
        view.addSubview(genderTitleLabel)
        view.addSubview(genderTextField)
        view.addSubview(birthTitleLabel)
        view.addSubview(birthTextField)
        view.addSubview(classTitleLabel)
        view.addSubview(classTextField)
        view.addSubview(confirmBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.leading.equalToSuperview().offset(15)
        }
        nameTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(15)
        }
        nameinputTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameTitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(24)
            
        }
        cardIDTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameinputTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(15)
        }
        cardIDLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cardIDTitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        studentIDTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cardIDLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
        }
        studentIDTextField.snp.makeConstraints { (make) in
            make.top.equalTo(studentIDTitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        seatTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(studentIDTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(15)
        }
        seatTextField.snp.makeConstraints { (make) in
            make.top.equalTo(seatTitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        genderTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cardIDTitleLabel.snp.top)
            make.leading.equalToSuperview().offset(UIScreen.main.bounds.width/2)
        }
        genderTextField.snp.makeConstraints { (make) in
            make.top.equalTo(genderTitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(UIScreen.main.bounds.width/2)
        }
        birthTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(studentIDTitleLabel.snp.top)
            make.leading.equalToSuperview().offset(UIScreen.main.bounds.width/2)
        }
        birthTextField.snp.makeConstraints { (make) in
            make.top.equalTo(birthTitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(UIScreen.main.bounds.width/2)
        }
        classTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(seatTitleLabel.snp.top)
            make.leading.equalToSuperview().offset(UIScreen.main.bounds.width/2)
        }
        classTextField.snp.makeConstraints { (make) in
            make.top.equalTo(seatTitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(UIScreen.main.bounds.width/2)
        }
        confirmBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-70)
            make.centerX.equalToSuperview()
            make.width.equalTo(112)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    @objc func sendInfo() {
        guard let id = cardID ,
              let name = nameinputTextField.text,
              let studentID = studentIDTextField.text,
              let seatNumber = seatTextField.text,
              let gender = genderTextField.text,
              let bitrh = birthTextField.text,
              let classroom = classTextField.text else { return }
        
        let model =  StudentTable(cardID: Int(id) ?? 0, name: name, studentID: Int(studentID) ?? 0, seatNumber: Int(seatNumber) ?? 0, gender: gender, birth:  bitrh, classroom: classroom)
        manager.createStudent(model: model) {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}

