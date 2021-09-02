//
//  ViewController.swift
//  ChuckJokes
//
//  Created by Иван on 9/1/21.
//

import UIKit

class ViewController: UIViewController {
    
    private let stringURL = "https://matchilling-chuck-norris-jokes-v1.p.rapidapi.com/jokes/random"
    private let networkManager = NetworkManager()
    
    private let imageView = UIImageView()
    private let jokeLabel = UILabel()
    private let welcomeLabel = UILabel()
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureJokeLabel()
        configureImageView()
        configureButton()
        configureWelcomeLabel()
        layout()
        
    }
    
    private func configureImageView() {
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
    }
    
    private func configureJokeLabel() {
        jokeLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        jokeLabel.numberOfLines = 0
        jokeLabel.textAlignment = .center
        jokeLabel.font = UIFont.italicSystemFont(ofSize: 20)
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(jokeLabel)
    }
    
    private func configureWelcomeLabel() {
        welcomeLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 40)
        welcomeLabel.text = "Welcome!"
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
    }
    
    private func configureButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.setTitle("Get random joke!", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    private func layout() {
        let margins = view.safeAreaLayoutGuide
        button.bottomAnchor.constraint(lessThanOrEqualTo: margins.bottomAnchor, constant: -50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        imageView.topAnchor.constraint(lessThanOrEqualTo: margins.topAnchor, constant: 12).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        jokeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        jokeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        jokeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func buttonPressed() {
        welcomeLabel.isHidden = true
        networkManager.makeUrlRequest(with: stringURL) { (joke) in
            DispatchQueue.main.async {
                self.jokeLabel.text = joke.value
                
                guard let stringURL = joke.icon_url else { return }
                guard let imageURL = URL(string: stringURL) else { return }
                guard let stringData = try? Data(contentsOf: imageURL) else { return }
                self.imageView.image = UIImage(data: stringData)
            }
        }
    }
    
}

