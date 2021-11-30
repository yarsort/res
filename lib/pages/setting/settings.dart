import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tehnotop/constants/screens.dart';
import 'package:tehnotop/pages/setting/policy.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool notification = false;
  bool location = true;

  _readSettings() async {
    SharedPreferences prefs = await _prefs;
    setState(() {
      notification = (prefs.getBool('settings_notification') ?? false);
      location = (prefs.getBool('settings_location') ?? false);
    });
  }

  _saveSettings() async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      prefs.setBool("settings_notification", notification);
      prefs.setBool("settings_location", location);
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: whiteColor,),
        ),
        title: Text(
          'Налаштування',
          style: whiteColor15SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        children: [
          notifications(),
          heightSpace,
          heightSpace,
          heightSpace,
          titleWithOnTap(title: 'Очистити кеш',
              onTap: () async {
                DefaultCacheManager().emptyCache();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text('Кеш додатку очищено'),
                    duration: const Duration(seconds: 2)));
          }),
          heightSpace,
          heightSpace,
          heightSpace,
          shareLocation(),
          heightSpace,
          heightSpace,
          heightSpace,
          titleWithOnTap(
              title: 'Політика компанії ',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Policy()),
                );
              }),
        ],
      ),
    );
  }

  notifications() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title('Нагадування'),
        Transform.scale(
          scale: 0.7,
          child: Container(
            child: CupertinoSwitch(
              activeColor: primaryColor,
              value: notification,
              onChanged: (bool value) {
                setState(() {
                  notification = value;
                });
                _saveSettings();
              },
            ),
          ),
        ),
      ],
    );
  }

  shareLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title('Дозвіл на відправку геопозиції'),
        Transform.scale(
          scale: 0.7,
          child: Container(
            child: CupertinoSwitch(
              activeColor: primaryColor,
              value: location,
              onChanged: (bool value) {
                setState(() {
                  location = value;
                });
                _saveSettings();
              },
            ),
          ),
        ),
      ],
    );
  }

  title(String title) {
    return Text(
      title,
      style: darkBlueColor14SemiBoldTextStyle,
    );
  }

  titleWithOnTap({String title, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: darkBlueColor14SemiBoldTextStyle,
      ),
    );
  }
}
