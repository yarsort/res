import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tehnotop/constants/screens.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String nameUser = '';
  String phoneUser = '';
  String emailUser = '';
  File image;

  _readSettings() async {
    SharedPreferences prefs = await _prefs;
    setState(() {
      nameUser = (prefs.getString('settings_nameUser') ?? '');
      phoneUser = (prefs.getString('settings_phoneUser') ?? 'Заповніть Ваші реквізити');
      emailUser = (prefs.getString('settings_emailUser') ?? '');
    });
  }

  @override
  void initState() {
    super.initState();
    _readSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        titleSpacing: 0.0,
        centerTitle: true,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Профіль',
          style: whiteColor15SemiBoldTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          heightSpace,
          heightSpace,
          heightSpace,
          userDetails(),
          heightSpace,
          profileDetails(
            child: Column(
              children: [
                profileDetailsRow(
                  ontap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentMethod()),
                  ),
                  icon: Icons.credit_card,
                  title: 'Payments',
                  color: darkBlueColor,
                ),
                profileDetailsRow(
                  ontap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeliveryMethod()),
                  ),
                  icon: Icons.location_on_outlined,
                  title: 'Delivery address',
                  color: darkBlueColor,
                ),
                // profileDetailsRow(
                //   ontap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => ShareAndEarn()),
                //   ),
                //   icon: 'assets/icons/share.png',
                //   title: 'Поділитися бонусами',
                //   color: darkBlueColor,
                // ),
              ],
            ),
          ),
          profileDetails(
            child: Column(
              children: [
                profileDetailsRow(
                  ontap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notifications()),
                  ),
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  color: darkBlueColor,
                ),
                profileDetailsRow(
                  ontap: () {
                    currentIndex = 1;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomBar()),
                    );
                  },
                  icon: Icons.list_alt,
                  title: 'Orders',
                  color: darkBlueColor,
                ),
                profileDetailsRow(
                  ontap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  ),
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  color: darkBlueColor,
                ),
                profileDetailsRow(
                  ontap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Support()),
                  ),
                  icon: Icons.help_outline_outlined,
                  title: 'Support',
                  color: darkBlueColor,
                ),
              ],
            ),
          ),
          profileDetails(
            child: profileDetailsRow(
              ontap: () => deleteAccountDialog(),
              icon: Icons.logout,
              title: 'Delete account',
              color: Colors.red,
            ),
          ),
          profileDetails(
            child: profileDetailsRow(
              ontap: () => logoutDialog(),
              icon: Icons.logout,
              title: 'Exit',
              color: darkBlueColor,
            ),
          ),
        ],
      ),
    );
  }

  profilePick() {
    return Center(
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PersonalInformation()),
        ),
        child: CircleAvatar(
          radius: 30,
          child: ClipOval(
            child: Image.file(image, width: 300, height: 300),
          ),
        ),
      ),
    );
  }

  profilePickDefault() {
    return Center(
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PersonalInformation()),
        ),
        child: Hero(
          tag: 'profilePick',
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  userDetails() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding,
        fixPadding * 2.0,
        fixPadding,
      ),
      child: InkWell(
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInformation()));
          await _readSettings();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                //image != null ? profilePick() : profilePickDefault(),
                profilePickDefault(),
                widthSpace,
                widthSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$nameUser',
                      style: darkBlueColor15SemiBoldTextStyle,
                    ),
                    Text(
                      '$phoneUser',
                      style: greyColor13MediumTextStyle,
                    ),
                    Text(
                      '$emailUser',
                      style: greyColor13MediumTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInformation()));
                await _readSettings();
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                color: greyColor,
                size: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  profileDetails({Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: fixPadding,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.1),
            spreadRadius: 2.5,
            blurRadius: 2.5,
          ),
        ],
      ),
      child: child,
    );
  }

  profileDetailsRow({Function ontap, IconData icon, String title, Color color}) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: fixPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                widthSpace,
                widthSpace,
                widthSpace,
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: greyColor,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }

  _deleteAccount() async {
    SharedPreferences prefs = await _prefs;
    var phoneNumber = prefs.getString('settings_phoneUser');

    dynamic myResponse;

    try {
      const url = 'http://api-tehno.yarsoft.com.ua:35844/tehnotop/hs/app/v1/getdata';

      var jsonPost = '{"method":"get_delete_customer", '
          '"authorization":"38597848-s859-f588-g5568-1245986532sd", '
          '"phone":"$phoneNumber"}';

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

        /// Clear all data about client and reset this app
        await _saveSettings();
        Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen()));

      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Доступ до серверу відсутній! \nКод помилки: ${response.statusCode}.'),
            duration: const Duration(seconds: 2)));
      }
    } catch (error) {
      debugPrint(error.toString());

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(myResponse['message'].toString()),
          duration: const Duration(seconds: 2)));
    }
  }

  _saveSettings() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      prefs.setString("settings_nameUser", '');
      prefs.setString("settings_phoneUser", '');
      prefs.setString("settings_emailUser", '');
    });
  }

  title(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding * 2.0,
        fixPadding * 2.0,
        fixPadding,
      ),
      child: Text(
        title,
        style: darkBlueColor17SemiBoldTextStyle,
      ),
    );
  }

  logoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          insetPadding: EdgeInsets.symmetric(horizontal: fixPadding * 5.0),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(fixPadding * 1.5),
                child: Column(
                  children: [
                    Text(
                      'Ви дійсно хочете завершити роботу?',
                      style: darkBlueColor15SemiBoldTextStyle,
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(fixPadding),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'Відміна',
                                style: primaryColor15BoldTextStyle,
                              ),
                            ),
                          ),
                        ),
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              await _saveSettings();

                              Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen()));
                            },
                            child: Container(
                              padding: EdgeInsets.all(fixPadding),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'Вихід',
                                style: whiteColor15BoldTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  deleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          insetPadding: EdgeInsets.symmetric(horizontal: fixPadding * 5.0),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(fixPadding * 1.5),
                child: Column(
                  children: [
                    Text('Ви дійсно хочете видалити аккаунт?', style: darkBlueColor15SemiBoldTextStyle),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(fixPadding),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'Відміна',
                                style: primaryColor15BoldTextStyle,
                              ),
                            ),
                          ),
                        ),
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              await _deleteAccount();
                            },
                            child: Container(
                              padding: EdgeInsets.all(fixPadding),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'Видалити',
                                style: whiteColor15BoldTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
