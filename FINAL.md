# Campus Chat App

### Rockstar Developers -- Team #1

### Bryson Howell, Spencer Howell, Ankush Patel, Hearan Kim

## Introduction
The Campus Chat app allows students at the University of Tennessee, Knoxville to connect with each other by joining automatically generated group chats focused around various interests. Students are able to send messages to discuss the topics and introduce themselves to others. The goal of the app is to help students meet new people on campus with similar interests.

Our team has developed a mobile app using Flutter that allows students to connect to these chatrooms and send messages in them. We have implemented a geolocation feature that allows students to connect and chat with other students in their area. The app verifies students at UT and allows them to connect with others in group chats created and served to all students. This product satisfies our goal of helping students connect with each other.

## Customer Value
The vision for our product has not changed from the initial proposal. We are still targeting college students, starting with our campus in Knoxville with plans to expand to other campuses in the future. Our current iteration of the product allows students to communicate in group chats focused on topics that are set up by database administrators. This can help bring students together and make connections over similar interests on campus.

## Technology
Our team implemented various different technologies in order to create our app. The app is built on the Flutter framework, written using the Dart programming language. This technology allows us to build the frontend and the user interface for the app. The benefit of Flutter is that the app will deploy to both iOS and Android using one main application file.

The backend of our app uses Google Firebase to implement the user information and messaging. Firebase Authentication requires users to sign in with their UTK Google account, and users are added to the log of users in the database. The names and profile images of the Google user are pulled and displayed in the app. In addition, messages are stored as rows in the Firebase Realtime Database, keeping information about the sender's name, their profile picture, and the messsage contents. The frontend then retrieves this information in order to display it.

Our goal for this iteration was to implement the basic messaging system for the app, and we were mostly successful in this aspect. Our current app allows students to login with their Google accounts, access our database, and message with other students at UT. Below is a screenshot of the app in action:

<img src="https://github.com/CS340-19/CampusGroupChat/blob/interface/chat_screenshot.png" width="40%">

To test the app, we have deployed it on a variety of Android devices, including physical devices and virtual machines. We are still in the process of implementing the iOS specific features in order to deploy to the platform, but we will conduct further tests once these features are complete. 

## Team
For this iteration of our project development, our team members served in various roles. Spencer and Ankush acted as Android developers, while Hearan developed and adapted the app for iOS devices. Bryson served as our customer / tester, ensuring that the app performed properly in various scenarios.

Our team plans to continue acting in these roles for the rest of the development cycle.

## Project Management
Our schedule has changed slightly due to our team being behind our estimated schedule. The process of learning Flutter and the Dart langauge proved to take longer than anticipated, mostly due to changes made in the framework that required additional research and testing. Therefore, we are slightly behind schedule, with the implementation of the geolocation feature having to be pushed back a couple of weeks. Below is the updated schedule for the remainder of the development period:

* 4/6:  Development of geolocation feature
* 4/13: Integrate geolocation with rest of app
* 4/20: Final project testing and demo prepartion

## Reflection
For this iteration of the product, we had several successes. Our team was able to set up and configure the tools required for us to develop Flutter applications for Android and iOS, and integrate GitHub in order to collaborate and share our work. We were also able to create a rudimentary app by referring to documentation and example code for Flutter applications.

Our difficulties came from reconciling the changes that have been made in Flutter recently with the resources that we used. Since Flutter is a very new technology, a lot has changed in it recently, and as a result a lot of online documentation is out of date. This made progress slower than anticipated and has resulted in our team being slightly behind schedule.

For the next iteration of development, we plan on moving more quickly now that we have a solid understanding of the platform and language we are developing with. In addition, we plan on making collaboration easier by creating separate branches for features being developed, and then merging these branches together in the master branch. This will allow us to be more efficient in our implementations.
