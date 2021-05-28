import 'package:flutter/material.dart';
import 'package:inject_js/inject_js.dart' as JS;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inject JS Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Inject JS Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _jsScript;

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/hello_world.js')
        .then((String js) => setState(() {
              _jsScript = js;
            }));
  }

  void _injectJs() {
    JS.injectScript(_jsScript!);
  }

  Widget _loadingOrButton() {
    if (_jsScript != null) {
      return new ElevatedButton(
          onPressed: _injectJs, child: new Text('Inject js'));
    } else {
      return new Container(
          width: 30.0, height: 30.0, child: new CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: _loadingOrButton()),
    );
  }
}
