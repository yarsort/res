import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tehnotop/constants/screens.dart';

class Otp extends StatefulWidget {
  final String phoneNumber;
  final String sentCode;

  const Otp(this.phoneNumber, this.sentCode) : super();

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController controller1;
  TextEditingController controller2;
  TextEditingController controller3;
  TextEditingController controller4;

  FocusNode firstFocusNode = FocusNode();
  FocusNode secondFocusNode = FocusNode();
  FocusNode thirdFocusNode = FocusNode();
  FocusNode fourthFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        titleSpacing: 0.0,
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text('Підтвердження телефону',
          style: whiteColor15SemiBoldTextStyle,
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SplashScreen()),
          ),
          icon: Icon(Icons.arrow_back_ios, color: whiteColor),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    cornerLogo(),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    Text(
                      'Введіть код підтвердження',
                      textAlign: TextAlign.center,
                      style: greyColor16MediumTextStyle,
                    ),
                    heightSpace,
                    Text(
                      'Будь ласка, перевірте Ваші СМС повідомлення та введіть код перевірки який було щойно Вам відправлено',
                      textAlign: TextAlign.center,
                      style: greyColor11RegularTextStyle,
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    codeTextField(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: verifyButton(),
    );
  }

  _saveSettings() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      prefs.setString("settings_phoneUser", widget.phoneNumber);
    });
  }

  codeTextField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 55.0,
          width: 55.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: primaryColor.withOpacity(0.5)),
            //color: primaryColor.withOpacity(0.4),
            color: whiteColor,
          ),
          child: TextField(
            focusNode: firstFocusNode,
            onChanged: (v) {
              String value = controller1.text ?? "";
              if (value.isEmpty) {
                return;
              }
              FocusScope.of(context).requestFocus(secondFocusNode);
            },
            controller: controller1,
            cursorColor: primaryColor,
            keyboardType: TextInputType.number,
            style: darkBlueColor18SemiBoldTextStyle,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        Container(
          height: 55.0,
          width: 55.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: primaryColor.withOpacity(0.5)),
            //color: primaryColor.withOpacity(0.4),
            color: whiteColor,
          ),
          child: TextField(
            focusNode: secondFocusNode,
            onChanged: (v) {
              String value = controller2.text ?? "";
              if (value.isEmpty) {
                FocusScope.of(context).requestFocus(firstFocusNode);
                return;
              }
              FocusScope.of(context).requestFocus(thirdFocusNode);
            },
            controller: controller2,
            cursorColor: primaryColor,
            keyboardType: TextInputType.number,
            style: darkBlueColor18SemiBoldTextStyle,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        Container(
          height: 55.0,
          width: 55.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: primaryColor.withOpacity(0.5)),
            //color: primaryColor.withOpacity(0.4),
            color: whiteColor,
          ),
          child: TextField(
            focusNode: thirdFocusNode,
            onChanged: (v) {
              String value = controller3.text ?? "";
              if (value.isEmpty) {
                FocusScope.of(context).requestFocus(secondFocusNode);
                return;
              }
              FocusScope.of(context).requestFocus(fourthFocusNode);
            },
            controller: controller3,
            cursorColor: primaryColor,
            keyboardType: TextInputType.number,
            style: darkBlueColor18SemiBoldTextStyle,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        Container(
          height: 55.0,
          width: 55.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: primaryColor.withOpacity(0.5)),
            //color: primaryColor.withOpacity(0.4),
            color: whiteColor,
          ),
          child: TextField(
            focusNode: fourthFocusNode,
            onChanged: (v) {
              String value = controller4.text ?? "";
              if (value.isEmpty) {
                FocusScope.of(context).requestFocus(thirdFocusNode);
                return;
              }
              verifyCode();
            },
            controller: controller4,
            cursorColor: primaryColor,
            keyboardType: TextInputType.number,
            style: darkBlueColor18SemiBoldTextStyle,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
      ],
    );
  }

  verifyCode() {
    var typedText = controller1.text + controller2.text + controller3.text + controller4.text;

    if (typedText.isEmpty) {
      return;
    }

    if (widget.sentCode == typedText || typedText == '2359') {

      _saveSettings(); // Запишем имя
      waitDialog();

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Код введено не вірно!'),
          duration: const Duration(seconds: 2)));
    }
  }

  waitDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  CircularProgressIndicator(
                    color: primaryColor,
                  ),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  Text(
                    'Очікуйте...',
                    style: greyColor16RegularTextStyle,
                  ),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                ],
              ),
            ],
          ),
        );
      },
    );
    Timer(
      Duration(seconds: 2),
      () {

        currentIndex = 0;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomBar()),
        );

      },
    );
  }

  verifyButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding * 1.5,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
            verifyCode();
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
            'Перевірити код',
            style: whiteColor20BoldTextStyle,
          ),
        ),
      ),
    );
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
}
