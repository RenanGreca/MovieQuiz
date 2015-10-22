MovieQuiz

Quiz app about movies. MovieQuiz shows the synopsis for a movie and the player has to guess the movie's title.

------

This version is fully functional in a small scope of its intended purpose.

- It fetches movie data from Rotten Tomatoes and iTunes Store APIs.
- Shows movies in a random order for users to guess from the synopsis.

------

Improvements over the original version, made in Objective-C:

v1.0
- The storyboard was completely remade to comply with iOS navigation standards and improve UI
- Fetching of web data is now made in background, so there is very little waiting time for the user.
- The name and date input was removed since those were only added because of BEPiD requirements.
- Instead of continuing endlessly, each session has only 10 questions.
- At the end of the play session, a results screen appears showing how many points were made and with Facebook and Twitter share buttons.


v1.1
- Along with the Rotten Tomatoes and iTunes APIs, the Open Movie Database API is used to fetch higher-quality movie posters.
- Fixed bug in which app would crash if there was no internet connection, or it was unable to fetch data from an API.

v1.2
- The game’s score is now based on elapsed time until 10 correct answers are reached, not number of correct answers out of 10.
- Game Center integration has been implemented and the above elapsed time is used in a leaderboard.

v1.3
- Fixed a bug that would make the app crash if the user got too many wrong answers
- Updated all code to Swift 2.0 and the app is now compatible with iOS 9.

------

v1.0 of this app was sent to Apple for review on 2015-05-08.

v1.1 of this app was sent to Apple for review on 2015-05-12.

v1.2 of this app was sent to Apple for review on 2015-07-20.

v1.3 of this app was sent to Apple for review on 2015-10-22.

©2015 Renan Greca