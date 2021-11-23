import 'package:tehnotop/pages/screen.dart';

class OrderDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          image(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          Text(
            'Hey, Samantha',
            textAlign: TextAlign.center,
            style: darkBlueColor24SemiBoldTextStyle,
          ),
          heightSpace,
          heightSpace,
          Text(
            'Your order is placed!!!',
            textAlign: TextAlign.center,
            style: darkBlueColor18MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          Text(
            'Thanks for  choosing us for\ndelivering your foods.',
            textAlign: TextAlign.center,
            style: greyColor11MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          Text(
            'You can check your order status\nin my order section.',
            textAlign: TextAlign.center,
            style: greyColor11MediumTextStyle,
          ),
          orderDetails(),
          myOrderButton(context),
        ],
      ),
    );
  }

  image() {
    return Image.asset(
      'assets/delivery_boy.png',
      height: 250,
      width: 250,
    );
  }

  orderDetails() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding * 3.5,
        fixPadding * 2.0,
        fixPadding * 2.0,
      ),
      padding: EdgeInsets.all(fixPadding * 1.5),
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
      child: Column(
        children: [
          orderDetailRow(title: 'Your order number', detail: 'CCA123654'),
          heightSpace,
          heightSpace,
          heightSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery address',
                style: darkBlueColor14SemiBoldTextStyle,
              ),
              heightSpace,
              Padding(
                padding: const EdgeInsets.only(right: fixPadding * 12.0),
                child: Text(
                  'B 441, Old city town, Leminton street Near City Part, Washington DC,United States Of America',
                  style: greyColor10SemiBoldTextStyle,
                ),
              ),
            ],
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          orderDetailRow(title: 'Amount Payable', detail: '\$32.00'),
          heightSpace,
          heightSpace,
          heightSpace,
          orderDetailRow(title: 'Amount Pay via', detail: 'Cash on delivery'),
        ],
      ),
    );
  }

  orderDetailRow({title, detail}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: darkBlueColor14SemiBoldTextStyle,
        ),
        Text(
          detail,
          style: darkBlueColor14SemiBoldTextStyle,
        ),
      ],
    );
  }

  myOrderButton(context) {
    return Padding(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          currentIndex = 2;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomBar()),
          );
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
            'My Orders',
            style: whiteColor20BoldTextStyle,
          ),
        ),
      ),
    );
  }
}
