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

void main() {
  _getLocation();
  runApp(new CampuschatApp());
}

Future<Null> _getLocation() async {
  final res = await SimplePermissions.requestPermission(Permission.AccessFineLocation);
  print("permission request result is " + res.toString());

  var currentLocation = <String, double>{};

  var location = new Location();

  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    print("Trying to grab location");
    currentLocation = await location.getLocation();
    print(currentLocation["latitude"]);
    print(currentLocation["longitude"]);
    print(currentLocation["accuracy"]);
    print(currentLocation["altitude"]);
    print(currentLocation["speed"]);
    print(currentLocation["speed_accuracy"]); // Will always be 0 on iOS
  } on PlatformException {
    print("Err: PlatformException");
  }
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
    return new Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: new InkWell(
              onTap: () {
                Navigator.push(context, new MaterialPageRoute(builder: (context)
                  => new ChatScreen(title: "Test Chat", refString: 'messages')));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Test', style: TextStyle(fontSize: 22.0)),
              ),
            ),
          ),
          Card(
            child: new InkWell(
              onTap: () {
                Navigator.push(context, new MaterialPageRoute(builder: (context)
                => new ChatScreen(title: "Vol Basketball", refString: 'basketball')));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Vol Basketball', style: TextStyle(fontSize: 22.0)),
              ),
            ),
          ),
          Card(
            child: new InkWell(
              onTap: () {
                Navigator.push(context, new MaterialPageRoute(builder: (context)
                => new ChatScreen(title: "Computer Science", refString: 'computer_science')));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Computer Science', style: TextStyle(fontSize: 22.0)),
              ),
            ),
          ),
        ],
      )
    );
  }
}
