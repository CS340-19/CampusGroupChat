import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:developer';

final googleSignIn = new GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;

void main() {
  runApp(new CampuschatApp());
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
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = new TextEditingController();
  final reference = FirebaseDatabase.instance.reference().child('messages');
  bool _isComposing = false;

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
    _sendMessage(text: text);
  }


  void _sendMessage({ String text }) {
    reference.push().set({
      'text': text,
      'senderName': googleSignIn.currentUser.displayName,
      'senderPhotoUrl': googleSignIn.currentUser.photoUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Campus Chat")),
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
              backgroundImage:
                new NetworkImage(snapshot.value['senderPhotoUrl']),
              )
            ),
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(snapshot.value['senderName'],
                         style: Theme.of(context).textTheme.subhead),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: new Text(snapshot.value['text']),
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
                Navigator.push(context, new MaterialPageRoute(builder: (context) => new ChatScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Developer', style: TextStyle(fontSize: 22.0)),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Computer Science', style: TextStyle(fontSize: 22.0)),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('March Madness', style: TextStyle(fontSize: 22.0)),
            ),
          ),
        ],
      )
    );
  }
}
