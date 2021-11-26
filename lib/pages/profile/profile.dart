import 'dart:io';
import 'package:tehnotop/constants/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        automaticallyImplyLeading: false,
        title: Text(
          'Профіль',
          style: darkBlueColor18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          userDetails(),
          profileDetails(
            child: Column(
              children: [
                profileDetailsRow(
                  ontap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentMethod()),
                      ),
                  icon: Icons.credit_card,
                  title: 'Способи оплати',
                  color: darkBlueColor,
                ),
                profileDetailsRow(
                  ontap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeliveryMethod()),
                  ),
                  icon: Icons.place,
                  title: 'Адреси доставки',
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
                  ontap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notifications()),
                      ),
                  icon: Icons.notifications,
                  title: 'Нагадування',
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
                  title: 'Замовлення',
                  color: darkBlueColor,
                ),
                profileDetailsRow(
                  ontap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyCart()),
                      ),
                  icon: Icons.shopping_cart,
                  title: 'Кошик покупок',
                  color: darkBlueColor,
                ),
                profileDetailsRow(
                  ontap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Settings()),
                      ),
                  icon: Icons.settings,
                  title: 'Налаштування',
                  color: darkBlueColor,
                ),
                profileDetailsRow(
                  ontap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Support()),
                      ),
                  icon: Icons.help_center,
                  title: 'Підтримка',
                  color: darkBlueColor,
                ),
              ],
            ),
          ),
          profileDetails(
            child: profileDetailsRow(
              ontap: () => logoutDialog(),
              icon: Icons.logout,
              title: 'Вихід',
              color: primaryColor,
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
            child: Image.file(image,
                width: 300 ,
                height: 300),
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
        fixPadding * 2.0,
      ),
      child: InkWell(
        onTap: () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PersonalInformation()),
            ),
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
              onPressed: () =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonalInformation())),
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

  _saveSettings() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      prefs.setString("settings_nameUser", '');
      prefs.setString("settings_phoneUser", '');
      prefs.setString("settings_emailUser", '');
    });
  }

  logoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: bgColor,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SplashScreen()));
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
}
