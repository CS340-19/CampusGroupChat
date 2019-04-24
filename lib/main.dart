import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:developer';
import 'package:location/location.dart';
import 'package:simple_permissions/simple_permissions.dart';

final googleSignIn = new GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
var location = new Location();
var currLoc;

// For test chat room
var initLoc;
var testRadius = [0.0, 0.0];
var currDif = [0.0, 0.0]; // Lat and lng diff from init

void main() {
  _getLocation();
  runApp(new CampuschatApp());
}

Future<Null> _getLocation() async {
  final res = await SimplePermissions.requestPermission(Permission.AccessFineLocation);
  print("permission request result is " + res.toString());

  location.onLocationChanged().listen((Map<String,double> currentLocation) {
      if (initLoc == null) {
        initLoc = currentLocation;
        testRadius[0] = initLoc["latitude"];
        testRadius[1] = initLoc["longitude"];

        print("test location: " + initLoc.toString());
      }
      currLoc = currentLocation;
      if (currLoc != null) {
        currDif[0] = testRadius[0] - currLoc["latitude"];
        currDif[0] = currDif[0].abs();
        currDif[1] = testRadius[1] - currLoc["longitude"];
        currDif[1] = currDif[1].abs();

        runApp(new CampuschatApp());

        print(currLoc);
      }
  });
}

class CampuschatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "CampusChat",
      home: new ChatSelect(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String title;
  final String refString;

  // Require a refString in this constructor
  ChatScreen({Key key, @required this.title, @required this.refString}) : super (key: key);

  @override
  State createState() => new ChatScreenState(this.title, this.refString);
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;
  final String title;
  final String refString;

  // Require a refString in this constructor
  ChatScreenState(this.title, this.refString);

  void initState() {
    super.initState();
    reference = FirebaseDatabase.instance.reference().child(refString);
  }

  DatabaseReference reference;

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container (
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible( // Text field -- fills up remaining space in row
              child: new TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration:
                new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container( // Send button)
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text)
                    : null,
              ),
            ),
          ]
        )
      ),
    );
  }

  // Sign user in
  // Attempts in background first, then process begins if not successful
  Future<Null> _ensureLoggedIn() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null)
      user = await googleSignIn.signInSilently();
    if (user == null) {
      await googleSignIn.signIn();
    }

    // Authenticate user
    // Uses updated method of FireBase Authentication
    if (await auth.currentUser() == null) {
      final GoogleSignInAuthentication googleAuth =
          await googleSignIn.currentUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
      );
      await auth.signInWithCredential(credential);
    }
  }

  Future<Null> _handleSubmitted(String text) async {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    await _ensureLoggedIn();
    _sendMessage(googleSignIn.currentUser, text: text);
  }


   _sendMessage(GoogleSignInAccount user, {String text}) {
    reference.push().set({
      'text': text,
      'senderName': user.displayName,
      'senderPhotoUrl': user.photoUrl,
      //'senderPhotoUrl': "https://avatars3.githubusercontent.com/u/7920823?s=460&v=4",
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(this.title)),
      body: new Column(children: <Widget>[
        new Flexible(
          child: new FirebaseAnimatedList(
              query: reference,
              sort:(a, b) => b.key.compareTo(a.key),
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation, index) {
               return new ChatMessage(
                 snapshot: snapshot,
                 animation: animation
               );
              },
        ),
        ),
        new Divider(height: 1.0),
        new Container(
          decoration:
            new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]
      )
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.snapshot, this.animation});
  final DataSnapshot snapshot;
  final Animation animation;

  NetworkImage _getAvatar() {
    if (snapshot.value['senderPhotoUrl'] != null) {
      return new NetworkImage(snapshot.value['senderPhotoUrl']);
    } else {
      //return new NetworkImage('https://avatars3.githubusercontent.com/u/7920823?s=460&v=4');
    }
  }

  Text _getSender(BuildContext context) {
    if (snapshot.value['senderName'] != null) {
      return new Text(snapshot.value['senderName'],
                      style: Theme.of(context).textTheme.subhead);
    } else {
      return new Text('???',
                      style: Theme.of(context).textTheme.subhead);
    }
  }

  Text _getText() {
    if (snapshot.value['text'] != null) {
      return new Text(snapshot.value['text']);
    } else {
      return new Text('???');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animation, curve: Curves.easeOut),
      axisAlignment: 0.0,
    child: new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(
              backgroundImage: _getAvatar()
            )
          ),
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _getSender(context),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: _getText(),
                ),
              ],
            ),
          ),
        ],
      ),
    )
    );
  }
}

class ChatSelect extends StatefulWidget {
  @override
  State createState() => new ChatSelectState();

}

class ChatSelectState extends State<ChatSelect> {
  @override
  Widget build(BuildContext context) {
    final title = 'Campus Chat';
    var cards = <Widget>{};

    var refStrings = ['messages', 'basketball', 'computer_science',
    'demoRoom', 'demoRoom2'];
    var titleStrings = ['Messages', 'Basketball', 'Min Kao', 'CS340 Back', 'CS340 Front'];

    for (var i = 0; i < refStrings.length; i++) {
      if ((refStrings[i] == 'demoRoom' && currDif[0] <= 0.0001 && currDif[1] <= 0.0001) ||
          (refStrings[i] == 'demoRoom2' && currDif[0] <= 0.00005 && currDif[1] <= 0.00005) ||
          (refStrings[i] != 'demoRoom' && refStrings[i] != 'demoRoom2')) {
        cards.add(Card(
          child: new InkWell(
            onTap: () {
              Navigator.push(context, new MaterialPageRoute(
                  builder: (context) =>
                  new ChatScreen(
                      title: titleStrings[i], refString: refStrings[i])));
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(titleStrings[i], style: TextStyle(fontSize: 22.0)),
            ),
          ),
        ));
      }
    }

    // For testing latitude and longitude difference
//    cards.add(RichText(
//      text: TextSpan(
//        text: 'Location',
//        style: DefaultTextStyle.of(context).style,
//        children: <TextSpan>[
//          TextSpan(text: '$currDif', style: TextStyle(fontWeight: FontWeight.bold)),
//        ],
//      ),
//    ));

    return new Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: cards.toList(),
      )
    );
  }
}
