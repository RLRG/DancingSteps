# DancingSteps
:dancer: :dancer: :dancer: :dancer: :dancer: :dancer: :dancer: :dancer: :dancer: :dancer: :dancer: :dancer: :dancer: :dancer:

This app was created as a final project of the [“Become an iOS Developer” Nanodegree program from Udacity](https://www.udacity.com/course/ios-developer-nanodegree--nd003).

## Screenshots
*TODO: Include some screenshots of the app when it is finished.*

## Objective and audience of the app
 The main functionalities of the app are to record all the dancing steps to be learnt by a dancer, organise them by different styles and check the most important dancing events around the user.

 The target audience using the app is supposed to be dancers, including dance instructors, learners and all the people interested in the dancing world.

 Of course, if any iOS developer who would like to check how to use the frameworks and tools included in the *Resources* paragraph, is more than welcome. This project is also interesting if you want to see an app example using Clean Architecture along with RxSwift.

## Motivation
One of my passions is to dance so that I spend so much time learning new steps of different styles and, when I attend to a workshop, at the end of it, we, dance learners, record a video with what we have done during the workshop. Afterwards, we can remember the new movements and steps watching the video again. There are hundreds of dance styles and the problem comes when somebody attends so many workshops that it is difficult to organise all the videos in Albums.

Therefore,  I thought of a useful way to have all the videos in the same place arranged by styles. To give added value to the application and to meet all the requirements to pass the iOS Udacity Nanodegree, a list of dancing events around the user can also be seen in the app.

### Learning purposes
I wanted to focus on learning new materials which were not covered in the iOS Nanodegree Program, paying special attention to Clean Architecture & RxSwift (Reactive Programming). This paragraph is also intended to collect interesting and useful resources and links related to the aforementioned topics:
- Clean Architecture:
    - [Clean Swift documentation](http://clean-swift.com/clean-swift-ios-architecture/)
    - [Uncle Bob documentation](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)
    - [Robert C Martin - Clean Architecture and Design. Conference video](https://www.youtube.com/watch?v=Nsjsiz2A9mg)
- RxSwift - Reactive programming:
    - [Official documentation](https://github.com/ReactiveX/RxSwift)
    - [Interactive diagrams of Rx Observables](http://rxmarbles.com/)
    - [Marin Todorov Rx blog](http://rx-marin.com/)
    - [RxSwift ecosystem projects](https://github.com/RxSwiftCommunity)
    - Other resources (tutorials/talks/...):
      - https://www.raywenderlich.com/138547/getting-started-with-rxswift-and-rxcocoa
      - https://github.com/Artsy/eidolon - Real app programmed in RxSwift.
      - https://news.realm.io/news/altconf-scott-gardner-reactive-programming-with-rxswift/
      - https://news.realm.io/news/slug-max-alexander-functional-reactive-rxswift/
      - https://www.raywenderlich.com/138547/getting-started-with-rxswift-and-rxcocoa
      - http://www.develapps.com/es/noticias/rxswift-programacion-reactiva-en-swift
      - https://medium.com/ios-os-x-development/learn-and-master-%EF%B8%8F-the-basics-of-rxswift-in-10-minutes-818ea6e0a05b
      - http://as.ync.io/
      - https://www.thedroidsonroids.com/blog/ios/rxswift-by-examples-1-the-basics/
      - .....
      - Other million of resources !

In order to create the architecture and the communications of my app I have studied mainly the following projects in addition to the links provided above:
* [An example of and app built with clean architecture and RxSwift](https://github.com/sergdort/CleanArchitectureRxSwift)
* [An example of and app built with clean architecture](https://github.com/RLRG/RealProgrammers-Clean-Architecture) in a workshop given by Jorge Ortiz at #SwiftAveiro event.

## Build and install
### Requirements
* Xcode 8.3.3
* iOS 10.3 SDK
* Swift 3.1.
### Getting the code
In order to build, run and access the app, the first thing you have to do is to clone my repository:
```
git clone https://github.com/RLRG/DancingSteps.git
```
It is important to remark that I have used CocoaPods as the dependency manager of the project so that you will need to execute a ‘pod install’ command in the same path where the PodFile is located to download all the third-party frameworks:
```
pod install
```
### Running the app
Open `DancingSteps.xcworkspace` with XCode 8.3.3. Then, it is recommended to install the app in a real device so that you can test the video recording functionality.

Before running it, note that there are two targets:
* DancingStepsLAB: When you run this target, in the "Videos" tab, you will see an UIBarButtonItem in the navigation bar (DEBUG) in order to open this debug screen. This target, then, includes tools to monitor and get information about the operation of the app in real time (real-time debuggers, logs and so on).
* DancingSteps: This target would be a simulation of the app if it was going to be submitted to the App Store.

## Resources
This paragraph includes all the resources used to create this app project, including frameworks, APIs and other information resources such as tutorials, documentation and so on.
### Third-party frameworks
| Framework | Description |
| --- | --- |
| [CocoaPods](https://github.com/CocoaPods/CocoaPods) | The Cocoa Dependency Manager. |
| [FLEX Debugger](https://github.com/Flipboard/FLEX) | An in-app debugger. |
| [SwiftLint](https://github.com/realm/SwiftLint) | A tool to enforce Swift style and conventions. |
| [Alamofire](https://github.com/Alamofire/Alamofire) | Elegant HTTP Networking in Swift. |
| [SwiftyCam](https://github.com/Awalz/SwiftyCam) | A Snapchat Inspired iOS Camera Framework written in Swift |
| [Kiuwan](https://www.kiuwan.com/codereview/) | Automated code review tool to detect vulnerabilities and improve quality. After setting it up, I discovered that moment, Swift was not supported yet. There must be working on it. |
| [Travis CI](https://travis-ci.org/) | Continuous Integration used to build the project automatically. |
| [Realm](https://github.com/realm/realm-cocoa) | Mobile database used to persist data of the app. |
| Other | Other frameworks related to the ones already mentioned such as: RxAlamofire, ObjectMapper, AlamofireObjectMapper, RxRealm, QueryKit (see PodFile of the project) |
### APIs
| Framework | Description |
| --- | --- |
| [EventBrite API](https://www.eventbriteapi.com/v3/) | It is used to retrieve the information about the dancing events. |
### Other information resources
| Resource | Description |
| --- | --- |
| App icon | Icon made by [Freepik](http://www.freepik.com/) from www.flaticon.com and all the sizes of the icon were generated with https://makeappicon.com/ |
| [Writing READMEs Udacity course](https://www.udacity.com/course/writing-readmes--ud777) | In order to document this project. |
| [GitHub documentation to write READMEs](https://help.github.com/categories/writing-on-github/) | In order to document this project. |

## Future work & Improvements
Among other things:
- Support of multi-language.
- Order the dancing events in the top chart by month.
- Include an animation when the app is launching.
- Extend the model of the app so that a video can be related to a dancer and to a song (in case the video is recorded with music).
- ...

If I find enough time to carry out it, I will work on this project to improve it in a way that it is feasible to publish this app in the App Store.

## Feedback
As I am continuously learning, I would appreciate if you take a look at my code and you have recommendations to improve it in different ways. You can contact me at rodri.lopezromero@gmail.com to do so :smiley:

## License
The contents of this repository are covered under the [MIT License](LICENSE).
