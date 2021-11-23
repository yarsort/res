import 'package:tehnotop/pages/screen.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var notificationList = [
    // {
    //   'image': 'assets/notification/notification1.png',
    //   'title': 'Your order is almost here...',
    //   'description':
    //       'Meet your deliver valet at the door and collect your oredr...',
    //   'date': '22 mar',
    // },
    // {
    //   'image': 'assets/notification/notification1.png',
    //   'title': 'Shivansh is your pizza hut valet today!',
    //   'description': 'He is on his way to delievr your order.',
    //   'date': '22 mar',
    // },
    // {
    //   'image': 'assets/notification/notification2.png',
    //   'title': 'Slow and steady wins nothing!',
    //   'description': 'That’s why w delivered your order in 15 mins. Enjoy...',
    //   'date': '21 mar',
    // },
    // {
    //   'image': 'assets/notification/notification3.png',
    //   'title': 'Your order is almost here...',
    //   'description':
    //       'Meet your deliver valet at the door and collect your oredr...',
    //   'date': '19 mar',
    // },
    // {
    //   'image': 'assets/notification/notification4.png',
    //   'title': 'Shivansh is your MC donald\'s valet today!',
    //   'description': 'He is on his way to delievr your order.',
    //   'date': '15 mar',
    // },
    // {
    //   'image': 'assets/notification/notification2.png',
    //   'title': 'Slow and steady wins nothing!',
    //   'description': 'That’s why w delivered your order in 15 mins. Enjoy...',
    //   'date': '12 mar',
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Нагадування',
          style: darkBlueColor18SemiBoldTextStyle,
        ),
      ),
      body: notificationList.length == 0
          ? noNotifications()
          : notificationsList(),
    );
  }

  noNotifications() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off,
            color: greyColor,
            size: 60.0,
          ),
          Text(
            'Нагадувань немає',
            style: greyColor14MediumTextStyle,
          ),
        ],
      ),
    );
  }

  notificationsList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: notificationList.length,
      itemBuilder: (context, index) {
        final item = notificationList[index];
        return Dismissible(
          key: Key('$item'),
          background: Container(
              margin: EdgeInsets.only(top: fixPadding, bottom: fixPadding),
              color: primaryColor),
          onDismissed: (direction) {
            setState(() {
              notificationList.removeAt(index);
            });
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${item['title']} dismissed")));
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              fixPadding * 2.0,
              fixPadding,
              fixPadding * 2.0,
              fixPadding,
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(
                fixPadding,
                fixPadding,
                fixPadding,
                3.0,
              ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  heightSpace,
                  Row(
                    children: [
                      Container(
                        height: 55.0,
                        width: 55.0,
                        decoration: BoxDecoration(
                          color: Color(0xffE5E5E5),
                          borderRadius: BorderRadius.circular(10.0),
                          image:
                              DecorationImage(image: AssetImage(item['image'])),
                        ),
                      ),
                      widthSpace,
                      widthSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: blackColor11RegularTextStyle,
                            ),
                            Text(
                              item['description'],
                              style: blackColor11RegularTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    item['date'],
                    textAlign: TextAlign.end,
                    style: primaryColor11MediumItalicTextStyle,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
