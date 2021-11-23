import 'package:tehnotop/pages/screen.dart';
import 'package:tehnotop/widget/column_builder.dart';

class AddPaymentMethod extends StatefulWidget {
  @override
  _AddPaymentMethodState createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  String isSelected = 'card';
  String card = 'Visa card';
  String cardImage = 'assets/paymentMethod/visa.png';
  int selectedEmail = 0;
  bool addEmail = false;

  final paymentMethodList = [
    {'image': 'assets/paymentMethod/card_method.png', 'name': 'card'},
    {'image': 'assets/paymentMethod/paypal_method.png', 'name': 'paypal'},
    {'image': 'assets/paymentMethod/netBanking.png', 'name': 'netBanking'},
  ];

  final emaiAddressList = [
    {'email': 'paupal@mydomain.net'},
    {'email': 'sales@mydomain.net'},
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
          'Add New Payment Method',
          style: darkBlueColor18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          heightSpace,
          heightSpace,
          paymentMethodsList(),
          isSelected == 'card'
              ? cardDetails()
              : isSelected == 'paypal'
                  ? paypalDetails()
                  : netBankingDetails(),
        ],
      ),
      bottomNavigationBar: isSelected == 'paypal'
          ? addEmail
              ? addButton()
              : addEmailButton()
          : addButton(),
    );
  }

  paymentMethodsList() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: paymentMethodList.length,
        itemBuilder: (context, index) {
          final item = paymentMethodList[index];
          return Padding(
            padding: EdgeInsets.fromLTRB(
              index == 0 ? fixPadding * 2.0 : 0.0,
              0.0,
              index == paymentMethodList.length - 1
                  ? fixPadding * 2.0
                  : fixPadding,
              0.0,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelected = item['name'];
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: fixPadding * 4.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: isSelected == item['name']
                            ? primaryColor
                            : greyColor,
                      ),
                    ),
                    child: Image.asset(
                      item['image'],
                      color: isSelected == item['name']
                          ? primaryColor
                          : darkBlueColor,
                      height: 28,
                      width: 28,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  cardDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(fixPadding * 2.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: () => chooseCardType(),
            child: Container(
              height: 42.0,
              padding: EdgeInsets.all(fixPadding),
              alignment: Alignment.centerLeft,
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
                  Container(
                    height: 20,
                    width: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(cardImage),
                      ),
                    ),
                  ),
                  widthSpace,
                  Expanded(
                    child: Text(
                      card,
                      style: greyColor12MediumTextStyle,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: greyColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0,
            vertical: fixPadding,
          ),
          height: 42.0,
          padding: EdgeInsets.symmetric(horizontal: fixPadding * 1.5),
          alignment: Alignment.centerLeft,
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
          child: TextField(
            cursorColor: primaryColor,
            style: greyColor12MediumTextStyle,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: 'Card Number',
              hintStyle: greyColor12MediumTextStyle,
              border: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(fixPadding * 2.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 42.0,
                  padding: EdgeInsets.symmetric(horizontal: fixPadding * 1.5),
                  alignment: Alignment.centerLeft,
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
                  child: TextField(
                    cursorColor: primaryColor,
                    style: greyColor12MediumTextStyle,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Valid Thru',
                      hintStyle: greyColor12MediumTextStyle,
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
              widthSpace,
              widthSpace,
              widthSpace,
              Expanded(
                child: Container(
                  height: 42.0,
                  padding: EdgeInsets.symmetric(horizontal: fixPadding * 1.5),
                  alignment: Alignment.centerLeft,
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
                  child: TextField(
                    cursorColor: primaryColor,
                    style: greyColor12MediumTextStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'CVV',
                      hintStyle: greyColor12MediumTextStyle,
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  chooseCardType() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: bgColor,
          child: Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(fixPadding),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: fixPadding),
                      child: Text(
                        'Choose Card Type',
                        textAlign: TextAlign.center,
                        style: darkBlueColor14SemiBoldTextStyle,
                      ),
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          card = 'Visa card';
                          cardImage = 'assets/paymentMethod/visa.png';
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 20,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/paymentMethod/visa.png'),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            widthSpace,
                            widthSpace,
                            Text(
                              'Visa Card',
                              style: darkBlueColor14SemiBoldTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          card = 'Master card';
                          cardImage = 'assets/paymentMethod/mastercard.png';
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 20,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/paymentMethod/mastercard.png'),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            widthSpace,
                            widthSpace,
                            Text(
                              'Master Card',
                              style: darkBlueColor14SemiBoldTextStyle,
                            ),
                          ],
                        ),
                      ),
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

  paypalDetails() {
    return Column(
      children: [
        heightSpace,
        heightSpace,
        Text(
          'Add your paypal email address or add new one.\nThis need for  product delivery.',
          textAlign: TextAlign.center,
          style: greyColor10MediumTextStyle,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding * 3.5,
              fixPadding * 2.0, fixPadding * 2.0),
          padding: EdgeInsets.symmetric(
            horizontal: fixPadding,
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
          child: ColumnBuilder(
            itemCount: emaiAddressList.length,
            itemBuilder: (context, index) {
              final item = emaiAddressList[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedEmail = index;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: index == 0 ? 0.0 : fixPadding * 1.5),
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/paymentMethod/paypal.png'),
                              ),
                            ),
                          ),
                          widthSpace,
                          widthSpace,
                          Expanded(
                            child: Text(
                              item['email'],
                              style: darkBlueColor14MediumTextStyle,
                            ),
                          ),
                          Container(
                            height: 12,
                            width: 12,
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(color: primaryColor),
                            ),
                            child: selectedEmail == index
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  index == emaiAddressList.length - 1 ? Container() : divider(),
                ],
              );
            },
          ),
        ),
        addEmail
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
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
                child: TextField(
                  cursorColor: primaryColor,
                  style: greyColor12MediumTextStyle,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Add New Paypal Email Address',
                    hintStyle: greyColor12MediumTextStyle,
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  netBankingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        beneficiaryNameTextField(),
        bankNameTextField(),
        accountNumberTextField(),
        ifscCodeTextField(),
      ],
    );
  }

  beneficiaryNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding * 1.3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name of Beneficiary',
            style: darkBlueColor14SemiBoldTextStyle,
          ),
          heightSpace,
          heightSpace,
          Container(
            padding: EdgeInsets.all(fixPadding * 1.3),
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
            child: TextField(
              cursorColor: primaryColor,
              style: darkBlueColor14MediumTextStyle,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bankNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding * 1.3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name of Bank',
            style: darkBlueColor14SemiBoldTextStyle,
          ),
          heightSpace,
          heightSpace,
          Container(
            padding: EdgeInsets.all(fixPadding * 1.3),
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
            child: TextField(
              cursorColor: primaryColor,
              style: darkBlueColor14MediumTextStyle,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  accountNumberTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding * 1.3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Number',
            style: darkBlueColor14SemiBoldTextStyle,
          ),
          heightSpace,
          heightSpace,
          Container(
            padding: EdgeInsets.all(fixPadding * 1.3),
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
            child: TextField(
              keyboardType: TextInputType.number,
              cursorColor: primaryColor,
              style: darkBlueColor14MediumTextStyle,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ifscCodeTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding * 1.3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'IFSC Code',
            style: darkBlueColor14SemiBoldTextStyle,
          ),
          heightSpace,
          heightSpace,
          Container(
            padding: EdgeInsets.all(fixPadding * 1.3),
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
            child: TextField(
              cursorColor: primaryColor,
              style: darkBlueColor14MediumTextStyle,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  divider() {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      color: darkBlueColor.withOpacity(0.4),
      height: 1.0,
      width: double.infinity,
    );
  }

  addEmailButton() {
    return Padding(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          setState(() {
            addEmail = true;
          });
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
            'Add New Email Address',
            style: whiteColor20BoldTextStyle,
          ),
        ),
      ),
    );
  }

  addButton() {
    return Padding(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomBar()),
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
            'Add',
            style: whiteColor20BoldTextStyle,
          ),
        ),
      ),
    );
  }
}
