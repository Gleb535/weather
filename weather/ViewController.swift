//
//  ViewController.swift
//  weather
//
//  Created by Глеб Груздев on 15.04.2025.
//

import UIKit

class ViewController: UIViewController {
    
    // ссылки на элементы пользовательского интерфейса
    @IBOutlet var weatherLabel: UILabel! // ссылка на лейбл
    @IBOutlet var getWeatherButton: UIButton! // ссылка на кнопку

    override func viewDidLoad() {
        super.viewDidLoad()

        getWeatherButton.addTarget(self, action: #selector(didTapGetWeatherButton), for: .touchUpInside) // для вывода инфы о погоде в лейбл
    }
    // метод для получения инфы для вывода ее в лейбл:
    @objc func didTapGetWeatherButton() {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m" // строка url free weather api
        let url = URL(string: urlString)! // формируем настоящий url
        let request = URLRequest(url: url) //запрос
        // создаем задачу
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async { // перенаправляем данные в main поток
                    self.weatherLabel.text = "\(weather.current.temperature2M) °" //выводим температуру
                }
            } else {
                self.weatherLabel.text = "failed" // если не получилось структурировать выводим ошибку
            }
            
        }
        task.resume()
    }

}

