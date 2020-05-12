# MovieQuiz

This is a simple app I developed at the Apple Developer Academy back in 2015. It was originally written in Objective-C and shortly after remade in Swift 2. Recently I updated the app to Swift 5 to improve code quality and ensure compatibility going forward. It was the first app I ever published on the App Store.

You can check it out the released version [here](https://apps.apple.com/br/app/moviequiz-synopsis-trivia/id993354458?l=en).

Feel free to clone or fork the project, but please don't publish simple copies of the app.

## Dependencies

The app only uses [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) as a dependency.

In order to build it, you must create an `APIKeys.swift` file and fill it with your own [OMDb API](http://www.omdbapi.com) and [IMDb-API](https://imdb-api.com) keys.

## Privacy Policy

This app collects no data from your phone. It requires an Internet connection simply to fetch movie information from the two APIs listed above.

## Support

If you find bugs or have suggestions, feel free to open an Issue here or contact me at [@RenanGreca](https://twitter.com/RenanGreca) on Twitter.

## Version history

v1.4
- Updated code to Swift 5.
- Removed Rotten Tomatoes API usage.

v1.3
- Fixed a bug that would make the app crash if the user got too many wrong answers.
- Updated all code to Swift 2.0 and the app is now compatible with iOS 9.

v1.2
- The game’s score is now based on elapsed time until 10 correct answers are reached, not number of correct answers out of 10.
- Game Center integration has been implemented and the elapsed time is used in a leaderboard.

v1.1
- Along with the Rotten Tomatoes and iTunes APIs, the Open Movie Database API is used to fetch higher-quality movie posters.
- Fixed bug in which app would crash if there was no internet connection, or it was unable to fetch data from an API.

v1.0
- The storyboard was completely remade to comply with iOS navigation standards and improve UI
- Fetching of web data is now made in background, so there is very little waiting time for the user.
- The name and date input was removed since those were only added because of BEPiD requirements.
- Instead of continuing endlessly, each session has only 10 questions.
- At the end of the play session, a results screen appears showing how many points were made and with Facebook and Twitter share buttons.