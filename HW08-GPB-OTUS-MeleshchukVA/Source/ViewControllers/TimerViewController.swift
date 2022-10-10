//
//  TimerViewController.swift
//  HW08-GPB-OTUS-MeleshchukVA
//
//  Created by Владимир Мелещук on 06.10.2022.
//

import UIKit

final class TimerViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.text = "00:00"
        timerLabel.font = UIFont.boldSystemFont(ofSize: 100)
        timerLabel.textColor = UIColor.white
        timerLabel.textAlignment = .center
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        return timerLabel
    }()
    
    let startButton = TimerButton(color: UIColor.systemGreen.cgColor, systemName: "play")
    let stopButton = TimerButton(color: UIColor.systemRed.cgColor, systemName: "pause")
    let mainStackView = BaseStackView(stackAxis: .vertical, stackSpacing: 0)
    let buttonsStackView = BaseStackView(stackAxis: .horizontal, stackSpacing: 16)
    let timerLabelBaseView = BaseView(frame: .zero)
    let startButtonBaseView = BaseView(frame: .zero)
    let stopButtonBaseView = BaseView(frame: .zero)
    
    var timer = Timer()
    var seconds = 0
    var isTimerRunning = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupConstraints()
    }
}

private extension TimerViewController {
    
    // MARK: - Private methods
    
    func setupView() {
        view.backgroundColor = .black
        
        // После первого запуска приложения кнопка cтоп выключена.
        stopButton.isEnabled = false
        
        configureStartButton()
        configureStopButton()
    }
    
    func setupSubviews() {
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(timerLabelBaseView)
        mainStackView.addArrangedSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(startButtonBaseView)
        buttonsStackView.addArrangedSubview(stopButtonBaseView)
        
        timerLabelBaseView.addSubview(timerLabel)
        startButtonBaseView.addSubview(startButton)
        stopButtonBaseView.addSubview(stopButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            timerLabel.centerXAnchor.constraint(equalTo: timerLabelBaseView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: timerLabelBaseView.centerYAnchor),
            timerLabel.widthAnchor.constraint(equalTo: timerLabelBaseView.widthAnchor),
            timerLabel.heightAnchor.constraint(equalTo: timerLabelBaseView.heightAnchor),
            
            startButton.centerXAnchor.constraint(equalTo: startButtonBaseView.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: startButtonBaseView.centerYAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 100),
            startButton.heightAnchor.constraint(equalToConstant: 100),
            
            stopButton.centerXAnchor.constraint(equalTo: stopButtonBaseView.centerXAnchor),
            stopButton.centerYAnchor.constraint(equalTo: stopButtonBaseView.centerYAnchor),
            stopButton.widthAnchor.constraint(equalToConstant: 100),
            stopButton.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func configureStartButton() {
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
    }
    
    func configureStopButton() {
        stopButton.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    // MARK: - Private actions
    
    @objc func startButtonPressed(_ sender: TimerButton) {
        if isTimerRunning == false {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
            RunLoop.main.add(timer, forMode: .common)
            startButton.isEnabled = false
            stopButton.isEnabled = true
            isTimerRunning = true
            
            // Если кнопка старт нажата, то таймер останавливается когда приложение свернуто.
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(stopTimerAtBackground),
                name: UIApplication.willResignActiveNotification,
                object: nil
            )
            
            // Если кнопка старт нажата, таймер возобновляет работу, когда приложение развернуто.
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(startTimerAtForeground),
                name:UIApplication.willEnterForegroundNotification,
                object: nil
            )
        }
    }
    
    @objc func updateTimer() {
        seconds += 1
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    @objc func stopButtonPressed(_ sender: TimerButton) {
        if isTimerRunning == true {
            timer.invalidate()
            startButton.isEnabled = true
            stopButton.isEnabled = false
            isTimerRunning = false
            
            // Если кнопка стоп нажата, то таймер не возобновляет работу после разворачивания приложения.
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(stopTimerAtForeground),
                name:UIApplication.willEnterForegroundNotification,
                object: nil
            )
        }
    }
    
    @objc func stopTimerAtBackground() {
        timer.invalidate()
        startButton.isEnabled = true
        stopButton.isEnabled = false
    }
    
    @objc func startTimerAtForeground() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        startButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    @objc func stopTimerAtForeground() {
        timer.invalidate()
        startButton.isEnabled = true
        stopButton.isEnabled = false
    }
}
