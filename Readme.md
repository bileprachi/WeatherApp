// Created by Prachi Bile, all rights reserved by prachibile.com

Weather App:

1. This app is created to fetch weather by city, or by zip code, or by current location of device and display on the screen.
2. This app is designed for iOS learners/beginners.
3. This app will cover below iOS topics -
    1. Software architecture pattern/iOS project architecture pattern - MVVM
        M - Model - App data that the app operates on
        V - View - Deals with UI 
        VM - View-Model - Most Important layer of MVVM architecture, which contains -
            .business Logic
            .Api call
            .DB Operations
            .Validations
            .Data binding,
            .etc.,
            
            MVVM Cycle - 
            
            View/VC(View Controller) ----event----> ViewModel -----update----> Model
            
            Model ----Notify----> ViewModel ----Binding----> View/VC
            
    2. Networking - Call weather api and fetch data from api using URLSession and for data parsing which is nothing but converting JSON formatted data into readable format using JSONDecoder and protocol Decodable/Encodable (Typealise - Codable)
    3. UIKit Framework - To add UI Controlls like - Search Bar, activity Indicator, Labels, Image Views, etc.
    4. Core Location Framework - To detect current location of device
    5. Extensions
    6. Delegates
    7. Protocols
