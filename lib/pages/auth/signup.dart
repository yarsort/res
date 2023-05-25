import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:res/constants/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:res/pages/system.dart';

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
      //prefs.setString("settings_phoneUser", phoneNumberController.text);
      prefs.setString("settings_emailUser", emailController.text);
    });
  }

  _sendSMS() async {

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
      var source = 'TEHNOTOP';
      var recipient = phoneNumber.toString();
      var text = 'Код підтвердження додатку: $codeSMS.';
      var description = 'TEHNOTOP';
      const url = 'http://sms-fly.ua/api/api.php';

      // Шифрование параметров авторизация для отправки СМС
      var credentials = "380677400202:lovege74";
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

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('СМС відправлено!'),
              duration: Duration(seconds: 3)));

          // Запись
          setState(() {
            _loading = false;
          });

          return true;
        }else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Не вірно сформовано СМС!'),
              duration: Duration(seconds: 3)));

          // Запись
          setState(() {
            _loading = false;
          });

          return false;
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
    final double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final double keyboardHeight = MediaQuery
        .of(context)
        .viewInsets
        .bottom;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        titleSpacing: 0.0,
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text('Реєстрація',
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
      body: SizedBox(
        height: screenHeight - keyboardHeight,
        child: SingleChildScrollView(
          child: Column(
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
              userNameTextField(),
              phoneNumberTextField(),
              emailTextField(),

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
    return Column(
      children: [
        Container(
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
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
            fixPadding * 2.0,
            0,
            fixPadding * 2.0,
            fixPadding,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(' * Не обов\'язково, але ми зможемо відправляти Вам '
                    'спеціальні бонусні купони для ще більшої економії.',
                    style: greyColor13RegularTextStyle,
                    textAlign: TextAlign.start),
              ),
            ],
          ),
        ),
      ],
    );
  }

  phoneNumberTextField() {
    return Column(
      children: [
        Container(
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
              Text('+38', style:greyColor16MediumTextStyle),
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
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
            fixPadding * 2.0,
            0,
            fixPadding * 2.0,
            fixPadding,
          ),
          child: Row(
            children: [
              Text(
                ' * Вкажіть Ваш номер телефону в повному форматі.',
                style: greyColor13RegularTextStyle,
                textAlign: TextAlign.start,
              ),
              // Text(
              //   '  Наприклад, 0982223344',
              //   style: greyColor13RegularTextStyle,
              //   textAlign: TextAlign.start,
              // ),
            ],
          ),
        ),
      ],
    );
  }

  passwordTextField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        0,
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

  checkExistCustomer() async {
    dynamic myResponse;

    var phoneNumberFromController = phoneNumberController.text;

    try {
      const url = connectUrl;

      var jsonPost = '{"method":"get_customer_exist", '
          '"authorization":"38597848-s859-f588-g5568-1245986532sd", '
          '"phone":"$phoneNumberFromController"}';

      const headersPost = {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, OPTIONS'
      };

      var response = await http
          .post(Uri.parse(url), headers: headersPost, body: jsonPost)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        return http.Response('Error', 500);
      });

      if (response.statusCode == 200) {
        myResponse = json.decode(response.body);

        // Если получили негативный результат от сервера, то прервем
        if (myResponse['result'] == false) {
          showScaffoldMessage(context,'Помилка обробки даних!');
          return false;
        }

        if (myResponse['contragent'] != '') {
          return true;
        } else {
          return true;
        }

      } else {
        showScaffoldMessage(context,'Доступ до серверу відсутній! \nКод помилки: ${response.statusCode}.');
        return true;
      }
    } catch (error) {
      debugPrint(error.toString());

      showScaffoldMessage(context,myResponse['message'].toString());

      return true;
    }
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
          if (nameController.text.isEmpty) {
            showScaffoldMessage(context, 'Прізвище та ім\'я вказано не вірно!');
            return;
          }

          if (phoneNumberController.text.isEmpty) {
            showScaffoldMessage(context, 'Номер вказано не вірно!');
            return;
          }

          final c = <String>[];
          if (phoneNumberController.text.length < 10) c.add(
              'Номер занадто короткий. \nПовинен мати не менше 10 символів.');
          if (phoneNumberController.text.length > 12) c.add(
              'Номер занадто довгий. \nПовинен мати не більше 12 символів.');

          String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
          RegExp regExp = RegExp(pattern);
          if (!regExp.hasMatch(phoneNumberController.text)) {
            c.add('Номер вказано не вірно.');
          }

          // При достаточной длине массива сообщим пользователю список ошибок
          if (c.length != 0) {
            showScaffoldMessage(context, c.join('\n'));
            return;
          }

          //Проверка наличия номера телефона в базе данных
          var existCustomer = await checkExistCustomer();
          if (!existCustomer) {

            showScaffoldMessage(context,'Покупець вже існує! Вам залишилось авторизуватися.');

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SignIn()));

            return;
          }

          // Переадресуем на другую страницу проверки
          var result = await _sendSMS();

          _saveSettings(); // Запишем имя и почту

          if (result) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Otp(phoneNumberController.text, codeSMS.toString())));
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