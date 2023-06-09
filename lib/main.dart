import 'package:flutter/services.dart';
import 'constants/screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
        MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'РЕС',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        primarySwatch: Colors.orange,
        fontFamily: 'ACDisplay',
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: darkBlueColor),
          elevation: 0.0,
          color: bgColor
        ),
      ),
      home: SplashScreen(),
    );
  }
}
