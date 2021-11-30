import 'package:tehnotop/constants/screens.dart';
import 'package:tehnotop/widget/column_builder.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  String isSelected = 'Credit card/Debit card';

  final paymentMethodList = [
    {
      'image': 'assets/paymentMethod/wallet.png',
      'method': 'Готівкою',
    },
    {
      'image': 'assets/paymentMethod/cash.png',
      'method': 'Оплата при отриманні',
    },
    {
      'image': 'assets/paymentMethod/card.png',
      'method': 'Платіжною картою',
    },
    {
      'image': 'assets/paymentMethod/cash.png',
      'method': 'Кредит "Монобанк"',
    },
    {
      'image': 'assets/paymentMethod/cash.png',
      'method': 'Кредит "Приват"',
    },
    {
      'image': 'assets/paymentMethod/cash.png',
      'method': 'Кредит "Альфа Банк"',
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
          'Доступні способи оплат',
          style: darkBlueColor17SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          paymentMethod(),
        ],
      ),
      //bottomNavigationBar: addNewPaymentMethodButton(),
    );
  }

  paymentMethod() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding,
        fixPadding * 2.0,
        fixPadding * 2.0,
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
            'Ви можете оплатити:',
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: fixPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Container(
                            //   height: 15,
                            //   width: 15,
                            //   padding: EdgeInsets.all(2.0),
                            //   decoration: BoxDecoration(
                            //     color: Colors.transparent,
                            //     shape: BoxShape.circle,
                            //     border: Border.all(color: primaryColor),
                            //   ),
                            //   child: isSelected == item['method']
                            //       ? Container(
                            //           decoration: BoxDecoration(
                            //             color: primaryColor,
                            //             shape: BoxShape.circle,
                            //           ),
                            //         )
                            //       : Container(),
                            // ),
                            //widthSpace,
                            //widthSpace,
                            //widthSpace,
                            //widthSpace,
                            Text(
                              item['method'],
                              style: darkBlueColor15MediumTextStyle,
                            ),
                          ],
                        ),
                        Icon(Icons.payments, color: primaryColor,),
                      ],
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

  addNewPaymentMethodButton() {
    return Padding(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddPaymentMethod()),
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
            'Добавити спосіб оплати',
            style: whiteColor20BoldTextStyle,
          ),
        ),
      ),
    );
  }
}
