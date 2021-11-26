import 'package:tehnotop/constants/screens.dart';
import 'package:tehnotop/widget/column_builder.dart';

class DeliveryMethod extends StatefulWidget {
  @override
  _DeliveryMethodState createState() => _DeliveryMethodState();
}

class _DeliveryMethodState extends State<DeliveryMethod> {
  String isSelected = 'Самовивіз';

  final deliveryMethodList = [
    {
      'image': 'assets/address_type/office.png',
      'method': 'Самовивіз',
    },
    {
      'image': 'assets/address_type/other.png',
      'method': 'Доставка по області',
    },
    {
      'image': 'assets/address_type/office.png',
      'method': 'Доставка "Нова пошта"',
    },
    {
      'image': 'assets/address_type/office.png',
      'method': 'Доставка "Укрпошта"',
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
          'Доступні способи доставки',
          style: darkBlueColor18SemiBoldTextStyle,
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
            'Ви можете скористатися:',
            style: darkBlueColor16SemiBoldTextStyle,
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          ColumnBuilder(
            itemCount: deliveryMethodList.length,
            itemBuilder: (context, index) {
              final item = deliveryMethodList[index];
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: fixPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              item['method'],
                              style: darkBlueColor15MediumTextStyle,
                            ),
                          ],
                        ),
                        Icon(Icons.local_shipping, color: primaryColor,),
                      ],
                    ),
                  ),
                  index == deliveryMethodList.length - 1
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
}
