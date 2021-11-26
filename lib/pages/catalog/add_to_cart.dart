import 'package:tehnotop/constants/screens.dart';
import 'package:tehnotop/widget/column_builder.dart';

class AddToCart extends StatefulWidget {
  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int add = 1;
  int totalItem;
  int price;
  int sPrice;
  double totalAmount = 0.0;
  String dropdownValue1;
  String dropdownValue2;
  String dropdownValue3;
  final foodList = [
    {
      'image': 'assets/food/food20.png',
      'name': 'Veg Sandwich',
      'description': 'Sauce tomato, mozzarella,  chilly etc.',
      'time': '25 min',
      'price': 6,
    },
    {
      'image': 'assets/food/food21.png',
      'name': 'Veg Frankie',
      'description': 'Sauce tomato, mozzarella,  chilly etc.',
      'time': '35 min',
      'price': 10.00,
    },
    {
      'image': 'assets/food/food22.png',
      'name': 'Margherite Pizza',
      'description': 'Sauce tomato, mozzarella,  chilly etc.',
      'time': '23 min',
      'price': 12.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    totalItem = foodList.length;
    price = foodList[0]['price'];
    amount();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Marine Rise Restaurant',
          style: darkBlueColor18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          foodsList(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          itemCount(),
        ],
      ),
      bottomNavigationBar: viewCartButton(),
    );
  }

  foodsList() {
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: darkBlueColor16SemiBoldTextStyle,
                                ),
                                heightSpace,
                                Text(
                                  item['description'],
                                  overflow: TextOverflow.fade,
                                  style: greyColor14MediumTextStyle,
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
                            height: 85,
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

  itemCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: fixPadding),
              child: Image.asset(
                'assets/icons/cart.png',
                height: 28,
                width: 28,
              ),
            ),
            Positioned(
              left: 9.0,
              top: 0.0,
              child: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  totalItem.toString(),
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        widthSpace,
        widthSpace,
        widthSpace,
        Text(
          '${totalItem.toString()} items',
          style: darkBlueColor14SemiBoldTextStyle,
        ),
        widthSpace,
        verticalDivider(),
        widthSpace,
        Text(
          '\$$totalAmount',
          style: darkBlueColor14SemiBoldTextStyle,
        ),
      ],
    );
  }

  amount() {
    for (var i = 0; i < foodList.length; i++) {
      setState(() {
        totalAmount = totalAmount + foodList[i]['price'];
      });
    }
  }

  verticalDivider() {
    return Container(
      color: darkBlueColor,
      height: 13.0,
      width: 1.5,
    );
  }

  viewCartButton() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          currentIndex = 1;
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
            'View Cart',
            style: whiteColor20BoldTextStyle,
          ),
        ),
      ),
    );
  }
}
