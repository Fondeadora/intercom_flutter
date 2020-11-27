import 'package:flutter/material.dart';
import 'package:intercom_flutter/intercom_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Intercom.initialize(
    'appId',
    androidApiKey: 'androidApiKey',
    iosApiKey: 'iosApiKey',
  );
  // await Intercom.registerUnidentifiedUser(); Depending on your config you might need a registered user for the Messenger or Help Center to display

  runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Intercom example app'),
        ),
        body: IntercomDemo(),
      ),
    );
  }
}

class IntercomDemo extends StatefulWidget {
  @override
  _IntercomDemoState createState() => _IntercomDemoState();
}

class _IntercomDemoState extends State<IntercomDemo> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Unread messages count: $_count'),
          FlatButton(
            onPressed: () {
              Intercom.displayMessenger();
            },
            child: Text('Show Messenger'),
          ),
          FlatButton(
            onPressed: () {
              Intercom.displayHelpCenter();
            },
            child: Text('Show Help Center'),
          ),
          FlatButton(
            onPressed: () {
              Intercom.displayArticle('4668681');
            },
            child: Text('Display an Article'),
          ),
          FlatButton(
            onPressed: () {
              Intercom.setLauncherVisibility(IntercomVisibility.visible);
            },
            child: Text('Show Launcher'),
          ),
          FlatButton(
            onPressed: () {
              Intercom.setLauncherVisibility(IntercomVisibility.gone);
            },
            child: Text('Hide Launcher'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    var stream = Intercom.getUnreadStream();

    stream.listen((count) {
      setState(() {
        _count = count;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
