# DancingSteps
This app was created as a final project of the “Become an iOS Developer” nanodegree program from Udacity (more info: https://www.udacity.com/course/ios-developer-nanodegree--nd003).

## Objective and audience of the app
 * The main functionalities of the app are to record all the dancing steps to be learnt by a dancer, organise them by different styles and check the most important dancing events around the user.
 * The target audience is supposed to be dancers, including dance instructors, learners and all the people interested in the dancing world.

## Why it was created
One of my passions is to dance so that I spend so much time learning new steps of different styles and, when I attend to a workshop, at the end of it, we, dance learners, record a video with what we have done during the workshop. Afterwards, we can remember the new movements and steps watching the video again. There are hundreds of dance styles and the problems comes when somebody attends so many workshops that it is difficult to organise all the videos in Albums.
Therefore,  I thought a useful way to have all the videos in the same place arranged by styles. To give added value to the application and to meet all the requirements to pass the Udacity nanodegree, a list of dancing events around the user can also be seen in the app.

## Screenshots
TODO: Include some screenshots of the app when it is finished.

## Learning purposes
I wanted to focus on learning new materials which were not covered in the iOS Nanodegree Program, paying special attention to:
- Clean Architecure.
- RxSwift - Reactive programming.

TODO: Explain this a little bit more with links.

## Steps to build, run and access the app
In order to build, run and access the app, the only thing you have to do is to clone my repository and follow the common steps to build an app. It is important to remark that I have used CocoaPods as the dependency manager of the project so that you will need to execute a ‘pod install’ command in the same path where the PodFile is located.
Note that there are two targets:
* LAB: This one includes tools to monitor and get information about the operation of the app in real time (real-time debuggers, logs and so on).
* PRO: This target would be a simulation of the app if it was going to be submitted to the App Store.

## Process followed to create the app
1) Creating an UI prototype.
2) Listing all of the functionalities of the app.
3) Looking for libraries/frameworks useful for the development.
4) Estimating each functionality

| Functionality | Description | Initial Estimation | Time spent |
| --- | --- | --- | --- |
| Login | In order to access the app, the user needs to enter the correct credentials | 15 | Not developed yet |
| Clean Architecture/RxSwift | Training and setting up the architecture following the guidelines of the Clean architecture and implementing some functionalities with RxSwift | 15 | X |
| Model (Realm Swift) | X | 15 | X |
| Camera functionality | X | 15 | X |
| Top chart screen | X | 10 | X |
| Styles screen | X | 15 | X |
| Bottom bar | X | 5 | X |
| LAB/PRO targets | X | 10 | X |
| FLEX Debugger (LAB) | X | 5 | X |

## Resources
### Third-party frameworks
* [CocoaPods](https://github.com/CocoaPods/CocoaPods) - The Cocoa Dependency Manager.
* [FLEX Debugger](https://github.com/Flipboard/FLEX) - An in-app debugger.
* [SwiftLint](https://github.com/realm/SwiftLint) - A tool to enforce Swift style and conventions.
* [Alamofire](https://github.com/Alamofire/Alamofire) - Elegant HTTP Networking in Swift.
* .....
### APIs
* [EventBrite API](https://www.eventbriteapi.com/v3/) - It is used to retrieve the information about the dancing events.
### Other information resources
* [Writing READMEs Udacity course](https://www.udacity.com/course/writing-readmes--ud777) - In order to document this project.
* [GitHub documentation to write READMEs](https://help.github.com/categories/writing-on-github/) - In order to document this project.
* .....

## Difficulties
Difficulties found along the way:
* Kiuwan: It does not support Swift yet.

## Future work & Improvements
Include all the pending points.
If I find enough time to carry out it, I will work on this project to improve it in a way that it is feasible to publish this app in the App Store.

## License
The contents of this repository are covered under the [MIT License](LICENSE).
