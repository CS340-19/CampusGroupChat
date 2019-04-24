# Campus Chat App

### Rockstar Developers -- Team #1

### Bryson Howell, Spencer Howell, Ankush Patel, Hearan Kim

## Introduction
The Campus Chat app allows students at the University of Tennessee, Knoxville to connect with each other by joining automatically generated group chats focused around various interests. Students are able to send messages to discuss the topics and introduce themselves to others. The goal of the app is to help students meet new people on campus with similar interests.

Our team has developed a mobile app using Flutter that allows students to connect to these chatrooms and send messages in them. We have implemented a geolocation feature that allows students to connect and chat with other students in their area. The app verifies students at UT and allows them to connect with others in group chats created and served to all students. This product satisfies our goal of helping students connect with each other.

## Customer Value
The vision for our product has not changed from the initial proposal. We are still targeting college students, starting with our campus in Knoxville with plans to expand to other campuses in the future. Our current iteration of the product allows students to communicate in group chats focused on topics that are set up by database administrators, as well as in group chats based on physical location. This can help bring students together and make connections over similar interests on campus.

## Technology
After comleting our minimal viable system, which was simply a group messaging app with chat rooms created by database administrators, we wanted to improve the app experience by enhancing the user interface and adding a feature that limits chat rooms based on geolocation.

Our final app has two types of screens: the "Chat Select Screen" that launches when the app starts up, and a "Chat Screen" that shows all messages within that chat. The Chat Select Screen, shown in the first image below, allows the user to select a topic to chat about with others. This screen checks the user's geolocation and dynamically adds or removes chats if the phone is within a certain radius. This feature is used to serve location-specific chats to each user.

<img src="https://github.com/CS340-19/CampusGroupChat/blob/master/Screenshot_20190423-122018.png" width="40%">

The Chat Screen fetches the list of messages from the database document for the chat selected and displays them for the user. When a user sends a message, they must sign in with a Google account and be authenticated by the database. Only UTK student emails are permitted in order to keep the app used by students. The user's profile name and profile picture are both pulled from their Google account and displayed with their message text. Below is a screenshot of the Chat Screen:

<img src="https://github.com/CS340-19/CampusGroupChat/blob/master/Screenshot_20190423-122033.png" width="40%">

The Firebase Realtime Database is organized into documents, one for each chat. Within each of these documents are a list of message objects, sorted by the time they were sent. Each message object has a field for the text of the message and the name of the sender, as well as a URL of the user's profile photo if available. Below are pictures of the structure of the database, with the documents for each chat in the first picture, and the list of message objects for a single chat in the second.

<img src="https://github.com/CS340-19/CampusGroupChat/blob/master/BackendScreenshot.png">

To test the app, we have deployed it on a variety of mobile devices, including physical devices and virtual machines. While we had great success on the three different Android phones that we deployed the app to, our iOS testing on virtual machines and physical devices proved to be more difficult. The app will run on iOS but we are still having issues with authenticating new accounts on the platform. This is an issue that we would like to address in future iterations. Overall, we feel confident with the results of our testing and would like to use those results to further improve the product.

## Team
As the development of the project continued, team members began to take on more concrete and well-defined roles. Ankush and Spencer were originally both on Android and backend development, and while Ankush started as the designated project leader, Spencer became the project leader for the last half of the process. Hearan continued to specialize in the development of the iOS version of the app. Bryson specialized in customizing the user interface of the app, as well as doing much of the testing and analysis of new features. Besides the swap of Spencer and Ankush for project management, the roles for the group were mostly static. We found this beneficial as each member could specialize and strive to fully understand the component that they work on. 

## Project Management
Our team was able to complete most of the goals set out in the original schedule, but not quite all of them. While we were able to implement a geolocation feature to create chats of nearby students, the system is not as robust as we had planned. In addition, we planned on implementing the various group chat topics in a way where students would be able to define their own chats as well. Both of these additions were unable to be included due to time restraints. Our biggest error was underestimating the amount of time that setup and research would take at the beginning of the development cycle. This caused us to get behind schedule, and must be taken into account in future software development projects.

## Reflection
Our team had many successed throughout the development process. We all feel that we have gained valuable knowledge in mobile app development through this project, especially since none of us had a lot of experience to begin with. We were able to overcome this obstacle by spending a lot of time researching, which was a good decision. We also were sure to dedicate time to testing the application, which helped us to fix issues as they cropped up and to ensure stability of the app. Our team was able to successfully collaborate using GitHub tools, and felt that implementing large new features on a new branch was a great way to structure the project.

However, there are several things that we could improve on for our next software product. Our initial difficulties in development came when trying to get the tools and environments set up on each member's computer. Since we had a variety of laptops and mobile devices to deploy to, getting everyone's work to compile and sync up with other member's commits was challenging. We should have allocated much more time in our initial schedule to setup.

Similarly, as we got behind schedule, our sprints began to fall behind, with tasks being rolled over to the next milestone almost every single time. We could have set more realistic goals for our milestone issues in order to make more consistent and visible progress.

Overall, the team is happy with the application that we have created. It achieves our goal of connecting students on campus to those that have similar interests. We were able to implement this product using the technology we decided to utilize and learned a lot along the way. Our team would like to see this product continue to be iterated on in the future.
