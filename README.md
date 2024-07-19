# AnimalsApp

## Getting Started
This project goals is to show Animal name list and show images related to it, you can also have toggle favourite on image you like and will be saved localy.
The APIs used in this project are [Ninja API](https://api-ninjas.com/api/animals) and [Pexel Image API](https://www.pexels.com/api/documentation)

## App Architecture
This project is mainly using **MVVM + Clean Architecture Pattern**

## MVVM
This project use **RxSwift** & **RxCocoa** as the main helper for MVVM binding to bind properties with UI Components.

## Repository Pattern
Repository exist as data layer of the project, it responsible to provide and process data to presentation layer so presentation layer doesn't need to know implementation detail of the data. Repository also as bridge for multi DataService communitation for example API Service & Local Service.

## API Service
Responsible to provide and process data from certain Remote API, in here I use **Alamofire** as main dependency for API communication

## Local Service
Responsible to provide and process data from storage in local device, in here I use **Core Data** as main dependecny for Local Storage.

## Items not completed
- Unit Test
