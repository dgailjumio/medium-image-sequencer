//
//  ViewController.swift
//  Instruments Demo App
//
//  Created by Dominik Gail on 05.04.23.
//

import UIKit

class ViewController: UIViewController {

    private let titleLabel = UILabel()
    private let settingsTitle = UILabel()
    private let numDescription = UILabel()
    private let numSlider = UISlider()
    private let numLabel = UILabel()
    private let rateDescription = UILabel()
    private let rateSlider = UISlider()
    private let rateLabel = UILabel()
    private let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTitle()
        setupSettingsTitle()
        setupNumDescription()
        setupNumSlider()
        setupNumLabel()
        setupRateDescription()
        setupRateSlider()
        setupRateLabel()
        setupStartButton()
        setupConstraints()
    }
    
    @objc
    private func startSequencer() {
        let cameraViewController = CameraViewController()
        cameraViewController.totalImages = Int(numSlider.value)
        cameraViewController.sequenceRate = Int(rateSlider.value)
        navigationController?.pushViewController(cameraViewController, animated: true)
    }
    
    @objc
    private func numChanged(sender: UISlider) {
        numLabel.text = "\(Int(sender.value))"
    }
    
    @objc
    private func rateChanged(sender: UISlider) {
        rateLabel.text = "\(Int(sender.value))"
    }

}

// MARK: - Views
extension ViewController {
    
    private func setupTitle() {
        titleLabel.text = "Image Sequencer"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(titleLabel)
    }
    
    private func setupSettingsTitle() {
        settingsTitle.text = "Settings"
        settingsTitle.textColor = .black
        settingsTitle.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(settingsTitle)
    }
    
    private func setupNumDescription() {
        numDescription.text = "Sequenced images:"
        numDescription.textColor = .black
        numDescription.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(numDescription)
    }
    
    private func setupNumSlider() {
        numSlider.minimumValue = 10
        numSlider.maximumValue = 100
        numSlider.value = 30
        numSlider.tintColor = UIColor(named: "Jumio")
        numSlider.addTarget(self, action: #selector(numChanged(sender:)), for: .valueChanged)
        view.addSubview(numSlider)
    }
    
    private func setupNumLabel() {
        numLabel.text = "30"
        numLabel.textColor = .black
        numLabel.font = UIFont.systemFont(ofSize: 18)
        numLabel.contentMode = .right
        view.addSubview(numLabel)
    }
    
    private func setupRateDescription() {
        rateDescription.text = "Sequence rate:"
        rateDescription.textColor = .black
        rateDescription.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(rateDescription)
    }
    
    private func setupRateSlider() {
        rateSlider.minimumValue = 1
        rateSlider.maximumValue = 30
        rateSlider.value = 10
        rateSlider.tintColor = UIColor(named: "Jumio")
        rateSlider.addTarget(self, action: #selector(rateChanged(sender:)), for: .valueChanged)
        view.addSubview(rateSlider)
    }
    
    private func setupRateLabel() {
        rateLabel.text = "10"
        rateLabel.textColor = .black
        rateLabel.font = UIFont.systemFont(ofSize: 18)
        rateLabel.contentMode = .right
        view.addSubview(rateLabel)
    }
    
    private func setupStartButton() {
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        startButton.layer.cornerRadius = 8
        startButton.backgroundColor = UIColor(named: "Jumio")
        startButton.addTarget(self, action: #selector(startSequencer), for: .touchUpInside)
        view.addSubview(startButton)
    }
    
}

// MARK: - Layout
extension ViewController {
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36).isActive = true
        
        settingsTitle.translatesAutoresizingMaskIntoConstraints = false
        settingsTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        settingsTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48).isActive = true
        
        numDescription.translatesAutoresizingMaskIntoConstraints = false
        numDescription.leadingAnchor.constraint(equalTo: settingsTitle.leadingAnchor).isActive = true
        numDescription.topAnchor.constraint(equalTo: settingsTitle.bottomAnchor, constant: 16).isActive = true
        
        numSlider.translatesAutoresizingMaskIntoConstraints = false
        numSlider.leadingAnchor.constraint(equalTo: numDescription.trailingAnchor, constant: 48).isActive = true
        numSlider.trailingAnchor.constraint(equalTo: rateLabel.leadingAnchor, constant: -16).isActive = true
        numSlider.centerYAnchor.constraint(equalTo: numDescription.centerYAnchor).isActive = true
        
        numLabel.translatesAutoresizingMaskIntoConstraints = false
        numLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        numLabel.widthAnchor.constraint(equalToConstant: 32).isActive = true
        numLabel.centerYAnchor.constraint(equalTo: numDescription.centerYAnchor).isActive = true
        
        rateDescription.translatesAutoresizingMaskIntoConstraints = false
        rateDescription.leadingAnchor.constraint(equalTo: settingsTitle.leadingAnchor).isActive = true
        rateDescription.widthAnchor.constraint(equalTo: numDescription.widthAnchor).isActive = true
        rateDescription.topAnchor.constraint(equalTo: numDescription.bottomAnchor, constant: 16).isActive = true
        
        rateSlider.translatesAutoresizingMaskIntoConstraints = false
        rateSlider.leadingAnchor.constraint(equalTo: rateDescription.trailingAnchor, constant: 48).isActive = true
        rateSlider.trailingAnchor.constraint(equalTo: rateLabel.leadingAnchor, constant: -16).isActive = true
        rateSlider.centerYAnchor.constraint(equalTo: rateDescription.centerYAnchor).isActive = true
        
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        rateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        rateLabel.widthAnchor.constraint(equalToConstant: 32).isActive = true
        rateLabel.centerYAnchor.constraint(equalTo: rateDescription.centerYAnchor).isActive = true
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -36).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
}
