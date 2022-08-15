# Le Baluchon

## Table of Contents

-   [Introduction](https://github.com/fredMilloh/TravelTools#introduction)
-   [Features](https://github.com/fredMilloh/TravelTools#features)
-   [Screenshots](https://github.com/fredMilloh/TravelTools#screenshots)
-   [IDE](https://github.com/fredMilloh/TravelTools#ide)
-   [Skills](https://github.com/fredMilloh/TravelTools#skills)
-   [How to use](https://github.com/fredMilloh/TravelTools#how-to-use)
-   [License](https://github.com/fredMilloh/TravelTools#license)


## Introduction

Tools for a trip to New York. 
 - Euro <-> Dollar conversion, 
 - translation between EU languages and English, 
 - local weather for New York and the destination to be entered

In the event of an input error, a connection error or incorrect data being received, an alert informs the user.

## Features

Fist tab :
- The user enters an amount and gets the conversion by pressing the "convert" button.
- An amount in Euro can be converted into Dollar, and vice versa.
- The conversion rate is updated once a day and stored in the user's device.
- A button allows to reverse the currencies.
 

Second tab :
- By default, the translation is from French to English, or vice versa.
- Each language button offers a list of the languages of the European Union.
- The user selects the original language and the language of the translation.
- A button provides a translation of the text entered in the selected language.

Third tab :
- As soon as the page is opened, the weather for New York is displayed.
- The user can compare with the weather of the destination of his choice.

## Screenshots

https://user-images.githubusercontent.com/47221695/184694454-bb8d3c03-94f7-46e5-9744-1d3d4091f229.mp4


## IDE

-   Swift 5
-   iOS deployment target 11
-   Xcode 13.2

## Skills
-   Singleton Pattern
-   Delegate Pattern
-   URLSession
-   URLComponents
-   URLProtocol
-   DataMocks
-   UserDefaults
-   UIAlertController
-   UITabBarController
-   UITableView
-   Storyboard Reference
-   AVKit/AVPlayer
-   Unit test XCTestCase, and UITests
-   Code coverage

## How To Use

 - Fork the project
 
From your terminal :

 - Create a branch and work on it
 - Publish the branch on its fork
 - Create the pull-request

**API**

This application uses the following APIs :

Convert : https://fixer.io/

Translate : https://cloud.google.com/translate/docs/

Weather : https://openweathermap.org/current



Project without API keys. Add your API keys.


Delete the ConfigKeys file and add a new "configuration settings file" to the project.

Name it *ConfigKeys*.

Set the configurations (Debug, Release) in the project, with this configuration file.

Add your API values to the following keys :

CONVERT_API_KEY = 

TRANSLATE_API_KEY = 

WEATHER_API_KEY =


## License

[MIT License](https://github.com/fredMilloh/Instagrid/blob/master)

----------------------------------------------------------------------------------------

This application was realized from a specification, within the framework of a study project.

