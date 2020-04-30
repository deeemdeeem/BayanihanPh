import 'package:flutter/material.dart';
import 'package:helpinghand/services/auth.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _BackgroundVideoState createState() => _BackgroundVideoState();
}

final AuthService _auth = AuthService();

void main() => runApp(SignIn());
// Code tutorial for video background used
// from https://medium.com/swlh/flutter-how-to-add-a-video-background-90a0e09ce332

class _BackgroundVideoState extends State<SignIn> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset("assets/phflag.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Adjusted theme colors to match logo.
        primaryColor: Color(0xffb55e28),
        accentColor: Color(0xffffd544),
      ),
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              SizedBox.expand(
                child: FittedBox(
                  // If your background video doesn't look right, try changing the BoxFit property.
                  // BoxFit.fill created the look I was going for.
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size?.width ?? 0,
                    height: _controller.value.size?.height ?? 0,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
              LoginWidget()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            child: Center(
              child: Image(
                image: AssetImage("assets/bayanihan.png"),
                width: 300.0,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: SizedBox(
            height: 50.0,
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.all(16),
            width: 300,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ButtonTheme(
                    minWidth: 300.0,
                    child: SignInButton(
                      Buttons.Google,
                      text: "Sign in with Google",
                      onPressed: () async {
                        _auth.googleSignIn();
                      },
                    )
                   

                    // FlatButton.icon(
                    //   color: Colors.blueAccent[500],
                    //   icon: Icon(Icons.add_a_photo),
                    //   label: Text(
                    //     'Login with Gmail',
                    //     style: TextStyle(color: Colors.white, fontSize: 20),
                    //   ),
                    //   onPressed: () async {
                    //     _auth.googleSignIn();
                    //   },
                    // ),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// old code for reference only

// class _SignInState extends State<SignIn> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent[600],
//         elevation: 0.0,
//         title: Text('Bayanihan PH'),
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
//         child: Form(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               // Sized box same as margin
//               RaisedButton(
//                 color: Colors.blueAccent[200],
//                 child: Text(
//                   'Sign In with Google',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () async {
//                   _auth.googleSignIn();
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
