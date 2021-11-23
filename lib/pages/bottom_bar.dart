import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:tehnotop/pages/screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

int currentIndex = 0;

class _BottomBarState extends State<BottomBar> {
  DateTime currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
        /*child: (currentIndex == 0)
            ? Home()
            : (currentIndex == 1)
                ? MyCart()
                : (currentIndex == 2)
                    ? MyOrders()
                    : Profile(),*/
        child: (currentIndex == 0)
            ? Home()
            : (currentIndex == 1)
                ? MyOrders()
                : (currentIndex == 2)
                    ? AllStore()
                    : Profile(),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: BottomNavyBar(
          showElevation: true,
          containerHeight: 20,
          selectedIndex: currentIndex,
          onItemSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home,
                size: 25,
                color: currentIndex == 0 ? primaryColor : darkBlueColor,
              ),
              title: Text(
                '   Головна',
                style: TextStyle(color: primaryColor),
              ),
              activeColor: primaryColor.withOpacity(0.1),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.list_alt,
                size: 25,
                color: currentIndex == 1 ? primaryColor : darkBlueColor,
              ),
              title: Text(
                '   Покупки',
                style: TextStyle(color: primaryColor),
              ),
              activeColor: primaryColor.withOpacity(0.1),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.store,
                size: 27,
                color: currentIndex == 2 ? primaryColor : darkBlueColor,
              ),
              title: Text(
                '  Магазини',
                style: TextStyle(color: primaryColor),
              ),
              activeColor: primaryColor.withOpacity(0.1),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.account_circle,
                size: 25,
                color: currentIndex == 3 ? primaryColor : darkBlueColor,
              ),
              title: Text(
                '   Профіль',
                style: TextStyle(color: primaryColor),
              ),
              activeColor: primaryColor.withOpacity(0.1),
            ),
          ],
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
}
