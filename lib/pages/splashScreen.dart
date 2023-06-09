import 'dart:async';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:res/constants/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool visible = false;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String phoneNumber;

  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();

    // Splash screen или отображает кнопки регистрации или переводит на главный экран
    Timer(
      Duration(seconds: 2),
        () async {
          SharedPreferences prefs = await _prefs;
          phoneNumber = (prefs.getString('settings_phoneUser') ?? '');

          if (phoneNumber != '') {
            currentIndex = 0;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomBar()),
            );
          } else {
            setState(() {
              visible = true;
            });
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var heightSizedBox = MediaQuery.of(context).size.height - 350;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/main-bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          //color: blackColor.withOpacity(0.4),
        ),
        child: WillPopScope(
          onWillPop: () async {
            bool backStatus = onWillPop();
            if (backStatus) {
              exit(0);
            }
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //SizedBox(height: 80),
                //cornerLogo(),
                SizedBox(height: heightSizedBox),
                Column(
                  children: [
                    signupButton(context),
                    signinButton(context),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Для виходу натисніть "Назад" ще раз.',
        textColor: whiteColor,
        backgroundColor: darkBlueColor,
      );
      return false;
    }
    return true;
  }

  cornerLogo() {
    return CircleAvatar(
      radius: 58,
      child: ClipOval(
        child: Image.asset(
          'assets/logo.png',
          fit: BoxFit.contain,
          height: 114,
          width: 114,
        ),
      ),
    );
  }

  logo() {
    return Image.asset(
      'assets/app_logo.png',
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    );
  }

  signinButton(context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0,
          vertical: fixPadding,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () async {
            SharedPreferences prefs = await _prefs;
            phoneNumber = (prefs.getString('settings_phoneUser') ?? '');

            if (phoneNumber != '') {
              currentIndex = 0;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BottomBar()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
              );
            }
          },
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.2),
                  spreadRadius: 2.5,
                  blurRadius: 2.5,
                ),
              ],
            ),
            child: Text(
              'Увійти',
              style: whiteColor20BoldTextStyle,
            ),
          ),
        ),
      ),
    );
  }

  signupButton(context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0,
          vertical: fixPadding,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUp()),
          ),
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              'Реєстрація',
              style: darkBlueColor20BoldTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
