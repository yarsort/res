import 'package:flutter/cupertino.dart';
import 'package:res/constants/screens.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {

  @override
  void initState() {
    super.initState();
  }

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
          'Підтримка',
          style: darkBlueColor17SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        children: [

        ],
      ),
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
