import 'package:tehnotop/constants/screens.dart';
import 'package:tehnotop/widget/column_builder.dart';

class SelectPaymentMethod extends StatefulWidget {
  @override
  _SelectPaymentMethodState createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  String isSelected = 'Credit card/Debit card';

  final paymentMethodList = [
    {
      'image': 'assets/paymentMethod/wallet.png',
      'method': 'Wallet',
    },
    {
      'image': 'assets/paymentMethod/card.png',
      'method': 'Credit card/Debit card',
    },
    {
      'image': 'assets/paymentMethod/cash.png',
      'method': 'Cash on delivery',
    },
    {
      'image': 'assets/paymentMethod/paypal.png',
      'method': 'Paypal',
    },
    {
      'image': 'assets/paymentMethod/payUmoney.png',
      'method': 'PayUmoney',
    },
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
          'Select Payment Method',
          style: darkBlueColor18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          paymentMethod(),
        ],
      ),
      bottomNavigationBar: checkoutButton(),
    );
  }

  paymentMethod() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: fixPadding * 1.5,
        vertical: fixPadding * 2.0,
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
        children: [
          Text(
            'How\'d you like to pay?',
            style: darkBlueColor16SemiBoldTextStyle,
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          ColumnBuilder(
            itemCount: paymentMethodList.length,
            itemBuilder: (context, index) {
              final item = paymentMethodList[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelected = item['method'];
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: fixPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: primaryColor),
                                ),
                                child: isSelected == item['method']
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                      )
                                    : Container(),
                              ),
                              widthSpace,
                              widthSpace,
                              widthSpace,
                              widthSpace,
                              Text(
                                item['method'],
                                style: darkBlueColor15MediumTextStyle,
                              ),
                            ],
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(item['image']),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  index == paymentMethodList.length - 1
                      ? Container()
                      : divider(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: fixPadding),
      color: darkBlueColor.withOpacity(0.2),
      height: 1.0,
      width: double.infinity,
    );
  }

  checkoutButton() {
    return Container(
      height: 125,
      padding: EdgeInsets.all(fixPadding * 2.0),
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount Payable',
                style: darkBlueColor20SemiBoldTextStyle,
              ),
              Text(
                '\$32.00',
                style: darkBlueColor20SemiBoldTextStyle,
              ),
            ],
          ),
          heightSpace,
          heightSpace,
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderDone()),
            ),
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
                'Proceed To Checkout',
                style: whiteColor20BoldTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
