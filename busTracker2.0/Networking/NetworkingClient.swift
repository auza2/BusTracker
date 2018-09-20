//
//  NetworkingClient.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/17/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import Foundation

public final class NetworkingClient{
    internal let baseURL: String
    internal let session = URLSession.shared
    internal let keyAndFormat = "key=FALhHGhFEJf77fyfhZvTZgZ6Y&format=json"
    
    public static let shared: NetworkingClient = {
        return NetworkingClient(baseURL: "http://ctabustracker.com/bustime/api/v2/")
    }()
    
    private init(baseURL: String){
        self.baseURL = baseURL
    }

    func getBusInformation(_ networkParameter:NetworkParameter, success _success: @escaping (ApiWrapper) -> Void){
        let parameters = getParametersString(networkParameter)
        let urlString = "\(baseURL)\(parameters)\(keyAndFormat)"
        let url = URL(string: urlString)!

        session.dataTask(with: url) { (data, repsonse, error) in
            guard let myData = data else {return}
            
            do {
                let wrapper = try JSONDecoder().decode(ApiWrapper.self, from: myData)
                
                _success(wrapper)
            }catch let jsonError{
                print("Error: Unable to get routes \(jsonError)")
            }
            }.resume()
    }
    
    private func getParametersString(_ networkParameter: NetworkParameter) -> String{
        switch networkParameter {
        case .getRoutes:
            return "getroutes?"
        case .getDirection(let route):
            return "getdirections?rt=\(route)&"
        case .getStops(let route, let direction):
            return "getstops?rt=\(route)&dir=\(direction)&"
        case .getPredictions(let stopId):
            return "getpredictions?stpid=\(stopId)&"
        case .getPatterns(let route):
            print(route)
            return "getpatterns?rt=\(route)&"
        case .getVehiclesUsingRoute(let route):
            return "getvehicles?rt=\(route)&"
        case .getVehiclesUsingVehicles(let vehicles):
            let vehicleIds = NSMutableString()
            
            for (i, vehicle) in vehicles.enumerated(){
                if( i < 10){ //cap at 10
                    vehicleIds.append("\(vehicle),")
                }
            }
            if ( vehicleIds.length >  1){
                 vehicleIds.deleteCharacters(in: NSRange(location: vehicleIds.length-1, length: 1))
            }
           
            return "getvehicles?vid=\(vehicleIds)&"
        }
    }
}
