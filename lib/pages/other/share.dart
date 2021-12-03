import 'package:tehnotop/constants/screens.dart';

class ShareAndEarn extends StatefulWidget {
  @override
  _ShareAndEarnState createState() => _ShareAndEarnState();
}

class _ShareAndEarnState extends State<ShareAndEarn> {
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
          'Share & Earn',
          style: darkBlueColor18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        children: [
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          image(),
          heightSpace,
          heightSpace,
          heightSpace,
          details(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          inviteCode(),
        ],
      ),
      bottomNavigationBar: shareButton(),
    );
  }

  image() {
    return Image.asset(
      'assets/gift.png',
      height: 110.0,
      width: 110.0,
    );
  }

  details() {
    return Text(
      'share your code with your friends to give them 2 free deliveries, valid for 14 days on order above \$25.00. When they place their first order, you’ll get \$10.00 off products, valid for 14 days on orders above \$25.00.',
      textAlign: TextAlign.center,
      style: greyColor11RegularTextStyle,
    );
  }

  inviteCode() {
    return Column(
      children: [
        Text(
          'Share Your Invite Code',
          textAlign: TextAlign.center,
          style: darkBlueColor15SemiBoldTextStyle,
        ),
        heightSpace,
        heightSpace,
        heightSpace,
        Container(
          padding: EdgeInsets.all(fixPadding),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextField(
            controller: TextEditingController(text: '4CGTY56PO'),
            cursorColor: primaryColor,
            style: darkBlueColor15MediumTextStyle,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: UnderlineInputBorder(borderSide: BorderSide.none),
              suffix: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.copy,
                  color: primaryColor,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  shareButton() {
    return Padding(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () => Navigator.pop(context),
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
            'Share',
            style: whiteColor20BoldTextStyle,
          ),
        ),
      ),
    );
  }
}
