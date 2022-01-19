//
//  WeatherController.swift
//  Baluchon
//
//  Created by fred on 24/12/2021.
//

import UIKit
import AVKit

class WeatherController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var localWeather: WeatherView!
    @IBOutlet weak var research: UITextField!
    @IBOutlet weak var destinationWeather: WeatherView!

    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    let localLocation = "New York"

    override func viewDidLoad() {
        super.viewDidLoad()
        getLocalWeather()
        self.title = "Météo"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupBackgroundVideo()
    }

    // MARK: - Get Weather

    private func getUrl(for location: String) -> URL {
        let weatherUrl = WeatherAPI.shared.buildUrl(location: location)

        guard let url = weatherUrl else {
            AlertView().presentAlert(message: "L'adresse de la ressource semble erronée")
            return URL(fileURLWithPath: "")
        }
        return url
    }

    private func getLocalWeather() {

        APIService.shared.getData(
            request: getUrl(for: localLocation),
            dataType: WeatherData.self
        ) { result in
                switch result {
                case .failure(let error) :
                    AlertView().presentAlert(message: error.localizedDescription)
                case .success(let localData) :
                    self.setupWeatherView(with: localData, from: self.localWeather)
                }
        }
    }

    @IBAction func getDestinationWeather(_ sender: UIButton) {
        guard let destination = research.text else { return }

        APIService.shared.getData(
            request: getUrl(for: destination),
            dataType: WeatherData.self
        ) { [self] result in
            switch result {
            case .failure(let error) :
                AlertView().presentAlert(message: error.localizedDescription)
            case .success(let destinationData) :
                setupWeatherView(with: destinationData, from: destinationWeather)
            }
        }
        research.resignFirstResponder()
    }

    // MARK: - Keyboard

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        research.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        research.resignFirstResponder()
        return true
    }

    // MARK: - Player Video

    private func setupBackgroundVideo() {

        /// get the path to the video resource
        let bundlePath = Bundle.main.path(forResource: "SkyBackground", ofType: "mp4")
        guard bundlePath != nil else { return }

        /// create a url from the path
        let url = URL(fileURLWithPath: bundlePath!)

        /// create the player
        let item = AVPlayerItem(url: url)
        videoPlayer = AVPlayer(playerItem: item)
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)

        /// full screen video
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width * 1.5, y: 0, width: self.view.frame.size.width * 4, height: self.view.frame.size.height)

        /// add to view and launch
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        videoPlayer?.playImmediately(atRate: 0.6)
    }
}
extension WeatherController {

    func setupWeatherView(with meteoData: (WeatherData), from location: WeatherView) {
        location.cityName.text = meteoData.city
        location.countryName.text = meteoData.country
        location.skyConditions.text = "actuellement " + meteoData.description
        let temperature = meteoData.temperature.withoutDecimal()
        let feelsLike = meteoData.feelsLike.withoutDecimal()
        let tempMini = meteoData.temperatureMini.withoutDecimal()
        let tempMaxi = meteoData.temperatureMaxi.withoutDecimal()
        location.temperature.text = "\(temperature) °C"
        location.delta.text = "Max. \(tempMaxi)°  Min. \(tempMini)°"
        location.feelsLike.text = "ressentie \(feelsLike)°"
        location.weatherIcon.image = UIImage(named: meteoData.icon)
    }
}
