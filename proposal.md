# Campus Chat App

### Rockstar Developers

### Bryson Howell, Spencer Howell, Ankush Patel, Hearan Kim


## Introduction
Our project is to make a chat app for UT students to be able to easily socialize on campus. While there are many chat apps that are already popular among college students, these apps are used to be connected with the other students who they already know. What we want from our chat app is to give students opportunities to be connected easily with the other students with similar interests although they do not know each other before.
 
To do this, our app window will display various group chat channels that are populated by students in the same geographical area, that have the same major, or have similar interests. These features will be very helpful to socialize with other students on campus. For example, if a student wants to go to a music concert on campus with someone, he or she might be able to contact the students who posted their interest as music. Or even they did not contact before the concert, they can meet up at the concert venue through our app’s location service. Then, although they did not talk to each other before, they could become close easily by talking about the concert. Wherever a student goes on campus such as a library or a cafeteria, they can easily contact or meet up with other students there through our chat app.
 
Although existing location-based chat apps are not popular because they chat with strangers anonymously, our app is different from those apps in that our users are UT students using their real name, and the purpose of our app is not anonymous chatting but helping to make friends on campus. In addition, unlike the other location-based anonymous messaging apps, our app will need to distinguish much smaller areas because some buildings on campus are very close.
 
To implement this app for Android and iOS, we will use Flutter, which is an open-source mobile application development kit created by Google. As a real-time database, we will use Firebase, which is Google’s mobile platform. Our team members do not have experience of making a chatting app although Bryson and Spencer have made some Android apps, and Ankush and Hearan have made some web-based apps. Our team members have experience of using several programming languages such as C++, Java, Python, and JavaScript. But we have not used Dart language for Flutter SDK before. Firebase and Android Studio are also new to most of our team members. So, we will learn Dart language and how to use Flutter, Firebase, and Android Studio first. And we will implement a basic chat app with Flutter, Firebase, and Android Studio. After that, we plan to add additional features gradually.  


## Customer Value
The Campus Group Chat app will be targeted directly at college students. The first customers we will target are the students here at UT, but we will be building the app with the possibility of expanding our audience to college campuses across the country. We believe that college students want to be more connected with other students at their university, especially those with similar interests and passions. However, it is sometimes difficult to connect with classmates. Our app would help to facilitate these connections by allowing students who are in similar locations, have the same majors, or just have similar interests to communicate with each other.

While there are several group messaging apps that are already popular among college students, they are different from the app that we are building. One such app is GroupMe [1], a group chat app that has become very frequently used in student organizations, study groups, and personal communication. However, GroupMe requires that members create the groups themselves, and new members have to be invited in order to join the conversation. We have also noticed that on campus, several very large GroupMe chats have emerged, with hundreds of members. These group chats become so large that they are unwieldy. For example, a “Free Food” group chat exists for discussing where free food can be found on campus, but typically the information in the chat is only useful if a student is on campus and near the location where the food is located. Otherwise, the constant messages are too much to parse.

Another chat app that was very popular on campus was YikYak. This app was based on location, as users could leave anonymous messages that could only be seen by other users who were within five miles of the original sender. The anonymous and localized nature of the app made it very popular on campus as relevant and humorous messages could be seen by hundreds or thousands of students. However, the anonymity that the app provides was also used to harass others and make threats, and as a result of lawsuits it was shut down in 2017 [2]. Care will have to be taken in order to avoid the same problems that YikYak had.

Our app aims to combine the best parts of both of these previous apps. By including the group messaging features of GroupMe that students are familiar with, and integrating the location-based features that made YikYak popular on campus, we hope to create a product that will fill a gap in students communication needs. When asked, several UT students have said that this app would be something they would consider using. To measure the success of our product, we can measure the number of students using the app on UT’s campus, as well as issuing surveys to our members to gather feedback.

## Proposed Solution & Technology
From a developer’s perspective, Campus Group Chat aims to offer a service that streamlines the process of social interaction on an academic campus by aggregating user profiles and using geolocation. Our technology stack focuses on Firebase and Flutter to offer the application experience. In particular, Flutter offers a native app experience on Android and IOS complemented with expressive user interfaces based on Material Design for Android and Cupertino for iOS. On the other hand, while Flutter offers a front end experience, we will be coupling it with Firebase to integrate critical functionality such as storing channel, user, and relevant location information. Since Firebase is a NoSQL database, we will be using JSON documents to communicate between the front end and the backend.

As far as features go, we plan on offering channels or group messages based on similar interests and throughout buildings on campus. In order to capture similar interests, we plan on having a small form on initial account creation that asks for channel relevant information such as major, clubs, etc. Then, the data will be sent to Firebase. Based on that data, Flutter will request a response from Firebase and relevant channels will be added to the users’ experience. In a similar vein, if location services are enabled, users will be able to automatically join channels by navigating to other buildings on campus as long as the user is within a specific range of the geolocation.

For the minimum viable product, we plan on implementing channel offerings based on similar interests and building channels based on geolocation; however, if we have more time, we would like to offer other features such as campus related events which would capture relevant news feeds that are dedicated to the campus and create specific channels around the time of the event. We would like to offer a chat filtering system based on machine learning to filter specific messages and images so that otherwise harmful or explicit content may be discarded. Since the initial set of channel offerings will have to be manually created i.e. explicitly programming the bounds for the geolocation of buildings and adding major related channels, we would like to devise an additional computational layer behind the database that frequently analyzes data and automatically creates new channels. This would allow users to have a more socially interactive experience.

We plan on writing unit tests throughout the development process to ensure there are no edge cases and functions work as desired. In addition, we will implement several widget tests to make sure our major features function properly. If time allows, we will offer the product to various peer groups from different colleges to test the product. In particular, we will request information regarding the UI experience, ease of usage, and overall benefit. 

We will use Android Studio along with Flutter’s integrated IDE tools to build our product on IOS and Android. Furthermore, we plan on using Flutter’s hot reload feature to enable fast testing while building new features and experimenting with the UI via mobile emulation. As far as integrating with the backend and using geolocation goes, Flutter offers several packages which will streamline the process of development. Furthermore, we plan on using Git as our version control system to manage our code.

## Team
Our team members do not have an experience of making a chatting app before. Spencer and Bryson have experience making Android apps, but using Flutter to make an app is new to all members. The following is about each member’s experience.
 
Bryson is proficient in C++ programming and is familiar Python and Java. He has some experience working on the front end and back end from high school projects and hackathons.
Spencer is experienced with Android app development using the Java language. He also has experience with web app development, and has an interest in graphic design and creating user interfaces.
Ankush is experienced with developing web applications. He has experience with working on full stack applications through various course projects, hackathons, and personal projects.
Hearan has made a web-based app to track a daily goal and show graphs of daily achievement using JavaScript and MySQL. She is also familiar with the other programming languages such as C++, Java, and Python.
 
The roles of our team members will rotate. The current role of each member is the following. Bryson is a researcher. Spencer and Ankush are software developers. Hearan is a tester.


## Project Management
### Schedule
* 2/2: Become familiar with Flutter
* 2/9: Learn Dart programming language
* 2/16: Implement a basic chat app
* 2/23: Add additional features to chat app (channels, user profiles)
* 3/2: Test current features and fix bugs
* 3/9: Research how to implement the location-based channel feature
* 3/16: Begin work on the location-based channel feature
* 3/23: Add the location feature to the main app
* 3/30: Test the location feature and fix bugs
* 4/6: Research ways to improve the front-end features
* 4/13: Test app and perform final bug fixes
* 4/20: Project deadline

Our team will not have a fixed meeting schedule outside of class time. We will communicate with each other through GroupMe, a messaging app, to try and resolve issues that occur as we develop our individual sections of the project. If issues cannot be resolved online, we will schedule in person meetings at a time when everyone is available. We believe that we will be able to implement our entire system by the end of the semester, as we have split our app into multiple essential and non-essential features and allotted plenty of time to complete each one. Our minimum viable product will be a campus-oriented chat app with set channels for various topics. Although this app would not offer many advantages over existing chat apps, we believe that a chat app which is strongly tailored for college students would still be useful to many people.

We have determined that we will have access to the data that our app needs. There are multiple geolocation APIs that will allow our location-based channels feature to function, and information about our users such as class standing and major can be pulled from the university’s public student directory or provided by the users themselves.

There are currently not any regulations that would hinder development of our messaging app, but we do have to acknowledge the ethical concerns that stem from storing users’ messages. We need to be transparent about what will be done with user data and also ensure that user data is stored securely. Additionally, we will have to implement measures to make sure that our app is not being used for illegal or unethical purposes such as cheating or harassment. 

## References
[1]  “The best way to chat with everyone you know,” GroupMe, 2019. [Online]. Available: https://groupme.com/en-US/. [Accessed: 28-Jan-2019].

[2] Valeriya, “The Rise and Fall of Yik Yak, the Anonymous Messaging App,” The New York TImes, 27-May-2017. [Online]. Available: https://www.nytimes.com/2017/05/27/style/yik-yak-bullying-mary-washington.html. [Accessed: 28-Jan-2019].