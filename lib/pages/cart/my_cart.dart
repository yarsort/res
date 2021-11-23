import 'package:tehnotop/pages/screen.dart';
import 'package:tehnotop/widget/column_builder.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  int add = 1;
  String dropdownValue1;
  double serviceTax = 2.50;
  double deliveryCharge = 1.50;

  final foodList = [
    {
      'image': 'assets/food/food20.png',
      'name': 'Veg Sandwich',
      'time': '25 min',
      'price': 6.00,
    },
    {
      'image': 'assets/food/food21.png',
      'name': 'Veg Frankie',
      'time': '35 min',
      'price': 10.00,
    },
    {
      'image': 'assets/food/food22.png',
      'name': 'Margherite Pizza',
      'time': '23 min',
      'price': 12.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My Cart',
          style: darkBlueColor18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          cartList(),
          subTotal(),
          checkoutButton(),
        ],
      ),
    );
  }

  cartList() {
    return ColumnBuilder(
      itemCount: foodList.length,
      itemBuilder: (context, index) {
        final item = foodList[index];
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              margin: EdgeInsets.fromLTRB(
                fixPadding * 2.0,
                fixPadding,
                fixPadding * 2.0,
                fixPadding,
              ),
              decoration: BoxDecoration(
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
                  Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.all(fixPadding),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: darkBlueColor16SemiBoldTextStyle,
                                ),
                                heightSpace,
                                Text(
                                  item['time'],
                                  style: darkBlueColor14SemiBoldTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 75,
                            child: Image.asset(
                              item['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(fixPadding),
                    decoration: BoxDecoration(
                      color: lightBlueColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Size',
                              style: darkBlueColor12SemiBoldTextStyle,
                            ),
                            widthSpace,
                            widthSpace,
                            widthSpace,
                            widthSpace,
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                elevation: 0,
                                isDense: true,
                                hint: Text(
                                  'Medium',
                                  style: primaryColor12MediumTextStyle,
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: primaryColor,
                                  size: 22,
                                ),
                                value: dropdownValue1,
                                style: primaryColor12MediumTextStyle,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue1 = newValue;
                                  });
                                },
                                items: <String>[
                                  'Medium',
                                  'Small',
                                  'Large',
                                  'Extra Large',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '\$${item['price']}',
                              style: darkBlueColor13SemiBoldTextStyle,
                            ),
                            widthSpace,
                            widthSpace,
                            widthSpace,
                            InkWell(
                              onTap: () {
                                setState(() {
                                  add == 1 ? add = 1 : add -= 1;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: darkBlueColor,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: 10,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                            widthSpace,
                            widthSpace,
                            Text(
                              add.toString(),
                              style: darkBlueColor13SemiBoldTextStyle,
                            ),
                            widthSpace,
                            widthSpace,
                            InkWell(
                              onTap: () {
                                setState(() {
                                  add += 1;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: darkBlueColor,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 10,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  subTotal() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding * 2.5,
        fixPadding * 2.0,
        fixPadding * 2.0,
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
          Container(
            padding: EdgeInsets.all(fixPadding),
            decoration: BoxDecoration(
              color: greyColor.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            child: subTotalRow(
              title: 'Sub Total',
              amount: '28.00',
              style: darkBlueColor16SemiBoldTextStyle,
            ),
          ),
          Container(
            padding: EdgeInsets.all(fixPadding),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                subTotalRow(
                  title: 'Service Tax',
                  amount: serviceTax,
                  style: darkBlueColor15MediumTextStyle,
                ),
                heightSpace,
                heightSpace,
                subTotalRow(
                  title: 'Delivery Charge',
                  amount: deliveryCharge,
                  style: darkBlueColor15MediumTextStyle,
                ),
                heightSpace,
                heightSpace,
                subTotalRow(
                  title: 'Amount Payable',
                  amount: 0.0,
                  style: primaryColor15SemiBoldTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  subTotalRow({title, TextStyle style, amount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: style,
        ),
        Text(
          '\$${amount.toString()}',
          style: style,
        ),
      ],
    );
  }

  checkoutButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding * 1.5,
        fixPadding * 2.0,
        fixPadding * 2.0,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SelectAddress()),
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
    );
  }
}
