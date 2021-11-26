import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:tehnotop/constants/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _loading = false;

  String phoneNumber = '';
  int codeSMS = 0;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  bool visible = false;
  double width;

  _readSettings() async {
    SharedPreferences prefs = await _prefs;
    setState(() {
      nameController.text = (prefs.getString('settings_nameUser') ?? '');
      phoneNumberController.text =
      (prefs.getString('settings_phoneUser') ?? '');
      emailController.text = (prefs.getString('settings_emailUser') ?? '');
    });
  }

  _saveSettings() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      prefs.setString("settings_nameUser", nameController.text);
      prefs.setString("settings_phoneUser", phoneNumberController.text);
      prefs.setString("settings_emailUser", emailController.text);
    });
  }

  _sendSMS() async {
    return true;

    var phoneNumber = phoneNumberController.text;

    // Если нет номера телефона, то нечего проверять!
    if (phoneNumber.isEmpty) {
      return;
    }

    if (_loading) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      var rng = Random();
      codeSMS = rng.nextInt(9000) + 1000;
      var startTime = 'AUTO';                                                  // отправить немедленно или ставим дату и время  в формате
      var endTime = 'AUTO';
      var lifetime = 12;
      var rate = 1;
      var source = 'PA.UA';
      var recipient = phoneNumber.toString();
      var text = 'Ваш код підтвердження: $codeSMS';
      var description = 'PA.UA';
      const url = 'http://sms-fly.ua/api/api.php';

      // Шифрование параметров авторизация для отправки СМС
      var credentials = "380932044125:13971397z";
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String encodedLoginPassword = stringToBase64.encode(credentials);

      var myXML = '';
      myXML = myXML + "<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n";
      myXML = myXML + "<request>\r\n";
      myXML = myXML + "<operation>SENDSMS</operation>\r\n";
      myXML = myXML + "	<message start_time=\"$startTime\" end_time=\"$endTime\" lifetime=\"$lifetime\" rate=\"$rate\" desc=\"$description\" source=\"$source\">\"\r\n";
      myXML = myXML + "	<body>$text</body>\r\n";
      myXML = myXML + "	<recipient>$recipient</recipient>\r\n";
      myXML = myXML + "</message>\r\n";
      myXML = myXML + "</request>";

      var headersPost = {
        'Authorization': 'Basic $encodedLoginPassword',
        'Content-Type': 'text/xml',
        'Accept': 'text/xml',
        'Access-Control-Allow-Methods': 'POST, OPTIONS'
      };

      var response =
      await http.post(Uri.parse(url), headers: headersPost, body: myXML);

      // Если получили позитивный результат от сервера, то продолжим
      if (response.statusCode == 200) {

        var bodyResponse = response.body;
        if (bodyResponse.contains('state code="ACCEPT"')) {
          setState(() {
            _loading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('СМС відправлено!'),
              duration: Duration(seconds: 3)));

        }else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Не вірно сформовано СМС!'),
              duration: Duration(seconds: 3)));
        }
      } else {

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Помилка відправки СМС! Сервіс недоступний!'),
            duration: Duration(seconds: 3)));

        // Запись
        setState(() {
          _loading = false;
        });

        return false;
      }

    } catch (error) {

      // Отладка
      debugPrint(error.toString());

      setState(() {
        _loading = false;
      });

      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _readSettings();
  }

  @override
  void dispose() {
    //phoneNumberController.dispose();
    //phoneNumberController.dispose();
    //emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SizedBox(
        height: screenHeight - keyboardHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              cornerImage(),
              heightSpace,
              heightSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding,
                        fixPadding * 2.0, fixPadding * 2.0),
                    child: Text(
                      'Реєстрація покупця',
                      style: darkBlueColor22BoldTextStyle,
                    ),
                  ),
                ],
              ),
              userNameTextField(),
              emailTextField(),
              phoneNumberTextField(),
              const SizedBox(height: 200),
              //passwordTextField(),
              //Text('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: signupButton(),
    );
  }

  userNameTextField() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding,
        fixPadding * 2.0,
        fixPadding,
      ),
      padding: EdgeInsets.all(fixPadding * 1.5),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.1),
            spreadRadius: 2.5,
            blurRadius: 2.5,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.person_outline,
            color: greyColor,
            size: 20,
          ),
          widthSpace,
          Expanded(
            child: TextField(
              cursorColor: primaryColor,
              controller: nameController,
              style: greyColor16MediumTextStyle,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintStyle: greyColor16MediumTextStyle,
                hintText: 'Прізвище та ім\'я',
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  emailTextField() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding,
        fixPadding * 2.0,
        fixPadding,
      ),
      padding: EdgeInsets.all(fixPadding * 1.5),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.1),
            spreadRadius: 2.5,
            blurRadius: 2.5,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.email_outlined,
            color: greyColor,
            size: 20,
          ),
          widthSpace,
          Expanded(
            child: TextField(
              cursorColor: primaryColor,
              controller: emailController,
              style: greyColor16MediumTextStyle,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintStyle: greyColor16MediumTextStyle,
                hintText: 'Email',
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  phoneNumberTextField() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding,
        fixPadding * 2.0,
        fixPadding,
      ),
      padding: EdgeInsets.all(fixPadding * 1.5),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.1),
            spreadRadius: 2.5,
            blurRadius: 2.5,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.phone_android_outlined,
            color: greyColor,
            size: 20,
          ),
          widthSpace,
          Expanded(
            child: TextField(
              cursorColor: primaryColor,
              controller: phoneNumberController,
              style: greyColor16MediumTextStyle,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintStyle: greyColor16MediumTextStyle,
                hintText: 'Номер телефону',
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  passwordTextField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding,
        fixPadding * 2.0,
        fixPadding,
      ),
      child: Container(
        padding: EdgeInsets.all(fixPadding * 1.5),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: greyColor.withOpacity(0.1),
              spreadRadius: 2.5,
              blurRadius: 2.5,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.lock_outline,
              color: greyColor,
              size: 20,
            ),
            widthSpace,
            Expanded(
              child: TextField(
                obscureText: !visible,
                cursorColor: primaryColor,
                style: greyColor16MediumTextStyle,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintStyle: greyColor16MediumTextStyle,
                  hintText: 'Пароль',
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  visible = !visible;
                });
              },
              child: Icon(
                visible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: greyColor,
                size: 15,
              ),
            ),
            widthSpace,
          ],
        ),
      ),
    );
  }

  signupButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding * 1.5,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () async {
          await _saveSettings();
          if (await _sendSMS() == true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Otp(phoneNumber,codeSMS.toString())));
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
            'Зареєструватися',
            style: whiteColor20BoldTextStyle,
          ),
        ),
      ),
    );
  }

  divider() {
    return Expanded(
      child: Container(
        color: greyColor,
        height: 1.0,
      ),
    );
  }

  cornerImage() {
    return Image.asset(
      'assets/logo.png',
      height: 100.0,
      width: 100.0,
      fit: BoxFit.none,
    );
  }
}
