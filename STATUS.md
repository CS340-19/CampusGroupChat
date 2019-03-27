# Campus Chat App

### Rockstar Developers -- Team #1

### Bryson Howell, Spencer Howell, Ankush Patel, Hearan Kim

## Introduction
After three sprints of development in a Scrum framework, our team has developed a rudimentary app to allow communication between students at the University of Tennessee, Knoxville. Due to our team having to learn the technologies behind this app, progress was slower than anticipated, and not all planned features have been fully implemented. Specifically, the geolocation feature has yet to be implemented. However, we do have an app that authenticates student accounts and allows them to communicate in a 'group chat' format.

## Customer Value
The vision for our product has not changed from the initial proposal. We are still targeting college students, starting with our campus in Knoxville with plans to expand to other campuses in the future. Our current iteration of the product does not have the geolocation feature implemented, instead requiring students to communicate in group chats focused on topics that are set up by database administrators. While we believe that this change does not drastically change the value to the customer, we still plan on implementing this feature in future iterations.

## Technology
Our team implemented various different technologies in order to create our app. The app is built on the Flutter framework, written using the Dart programming language. This technology allows us to build the frontend and the user interface for the app. The benefit of Flutter is that the app will deploy to both iOS and Android using one main application file.

The backend of our app uses Google Firebase to implement the user information and messaging. Firebase Authentication requires users to sign in with their UTK Google account, and users are added to the log of users in the database. The names and profile images of the Google user are pulled and displayed in the app. In addition, messages are stored as rows in the Firebase Realtime Database, keeping information about the sender's name, their profile picture, and the messsage contents. The frontend then retrieves this information in order to display it.

Our goal for this iteration was to implement the basic messaging system for the app, and we were mostly successful in this aspect. Our current app allows students to login with their Google accounts, access our database, and message with other students at UT. Below is a screenshot of the app in action:

![Chat Screen](https://github.com/CS340-19/CampusGroupChat/blob/interface/chat_screenshot.png)

To test the app, we have deployed it on a variety of Android devices, including physical devices and virtual machines. We are still in the process of implementing the iOS specific features in order to deploy to the platform, but we will conduct further tests once these features are complete. 

Our goal for the next iteration is to complete the geolocation feature to allow students to chat with those in their proximity on campus, as well as to complete transferring the app to iOS. The final touches to the user interface will be made at the end of the itertion as well. Finally, we would like to further test the app to ensure its functionality for the demo.

## Team
For this iteration of our project development, our team members served in various roles. Spencer and Ankush acted as Android developers, while Hearan developed and adapted the app for iOS devices. Bryson served as our customer / tester, ensuring that the app performed properly in various scenarios.

Our team plans to continue acting in these roles for the rest of the development cycle.

## Project Management
Our schedule has changed slightly due to our team being behind our estimated schedule. The process of learning Flutter and the Dart langauge proved to take longer than anticipated, mostly due to changes made in the framework that required additional research and testing. Therefore, we are slightly behind schedule, with the implementation of the geolocation feature having to be pushed back a couple of weeks. Below is the updated schedule for the remainder of the development period:

* 4/6:  Development of geolocation feature
* 4/13: Integrate geolocation with rest of app
* 4/20: Final project testing and demo prepartion

## Reflection


