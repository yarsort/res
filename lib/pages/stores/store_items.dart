import 'package:tehnotop/constants/screens.dart';

class RestaurantItems extends StatefulWidget {
  @override
  _RestaurantItemsState createState() => _RestaurantItemsState();
}

class _RestaurantItemsState extends State<RestaurantItems> {
  double height;
  String isSelected = 'Fast food';
  bool isTap1 = false;
  bool isTap2 = false;
  bool isTap3 = false;

  final menuList = [
    {'foodType': 'Fast food'},
    {'foodType': 'Starter'},
    {'foodType': 'Main Course'},
    {'foodType': 'Dessert'},
  ];

  final fastFoodList = [
    {
      'image': 'assets/food/food12.png',
      'name': 'Veg Sandwich',
      'price': '6.00',
      'customise': 'Customise',
    },
    {
      'image': 'assets/food/food16.png',
      'name': 'Veg Frankie',
      'price': '10.00',
      'customise': '',
    },
    {
      'image': 'assets/food/food17.png',
      'name': 'Margherite Pizza',
      'price': '12.00',
      'customise': 'Customise',
    },
    {
      'image': 'assets/food/food13.png',
      'name': 'Burger',
      'price': '12.00',
      'customise': '',
    },
    {
      'image': 'assets/food/food18.png',
      'name': 'Veg Cheese Sandwich',
      'price': '10.00',
      'customise': 'Customise',
    },
    {
      'image': 'assets/food/food19.png',
      'name': 'Crust Gourmet Pizza',
      'price': '15.00',
      'customise': 'Customise',
    },
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          heightSpace,
          heightSpace,
          menu(),
          heightSpace,
          fastFoodsList(),
        ],
      ),
    );
  }

  menu() {
    return Container(
      height: height * 0.04,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menuList.length,
        itemBuilder: (context, index) {
          final item = menuList[index];
          return Padding(
            padding: EdgeInsets.fromLTRB(
                index == 0 ? fixPadding * 2.0 : fixPadding, 0.0, 0.0, 0.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(15.0),
              onTap: () {
                setState(() {
                  isSelected = item['foodType'];
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: fixPadding),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected == item['foodType']
                      ? lightBlueColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  item['foodType'],
                  style: TextStyle(
                    color: isSelected == item['foodType']
                        ? darkBlueColor
                        : greyColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  fastFoodsList() {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: fastFoodList.length,
        itemBuilder: (context, index) {
          final item = fastFoodList[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(
              fixPadding * 2.0,
              fixPadding,
              fixPadding * 2.0,
              fixPadding,
            ),
            child: Container(
              padding: EdgeInsets.all(fixPadding),
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
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: AssetImage(item['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  widthSpace,
                  widthSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          overflow: TextOverflow.ellipsis,
                          style: darkBlueColor15SemiBoldTextStyle,
                        ),
                        heightSpace,
                        Text(
                          '\$${item['price']}',
                          style: darkBlueColor13SemiBoldTextStyle,
                        ),
                        heightSpace,
                        item['customise'] == 'Customise'
                            ? Text(
                                item['customise'],
                                style: primaryColor14MediumTextStyle,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 45),
                      InkWell(
                        onTap: () {
                          item['customise'] == 'Customise'
                              ? customiseDialog(item['name'], item['price'])
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddToCart()),
                                );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: fixPadding * 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            'Add',
                            style: primaryColor16SemiBoldTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  customiseDialog(String name, price) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: fixPadding * 5.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Wrap(
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: fixPadding * 1.5, vertical: fixPadding),
                        decoration: BoxDecoration(
                          color: greyColor.withOpacity(0.2),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: darkBlueColor16SemiBoldTextStyle,
                                  ),
                                  heightSpace,
                                  Text(
                                    '\$$price',
                                    style: darkBlueColor15MediumTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddToCart()),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5.0,
                                  horizontal: fixPadding * 2.0,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  'Add',
                                  style: primaryColor16SemiBoldTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(fixPadding * 1.5),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isTap1 = !isTap1;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20.0,
                                        width: 20.0,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: isTap1
                                              ? primaryColor
                                              : Colors.transparent,
                                          border:
                                              Border.all(color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                        ),
                                        child: isTap1
                                            ? Icon(
                                                Icons.done,
                                                color: whiteColor,
                                                size: 15,
                                              )
                                            : Container(),
                                      ),
                                      widthSpace,
                                      widthSpace,
                                      widthSpace,
                                      Text(
                                        'Extra Cheese',
                                        style: darkBlueColor15SemiBoldTextStyle,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '\$3.00',
                                    style: darkBlueColor15SemiBoldTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            heightSpace,
                            heightSpace,
                            heightSpace,
                            heightSpace,
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isTap2 = !isTap2;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20.0,
                                        width: 20.0,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: isTap2
                                              ? primaryColor
                                              : Colors.transparent,
                                          border:
                                              Border.all(color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                        ),
                                        child: isTap2
                                            ? Icon(
                                                Icons.done,
                                                color: whiteColor,
                                                size: 15,
                                              )
                                            : Container(),
                                      ),
                                      widthSpace,
                                      widthSpace,
                                      widthSpace,
                                      Text(
                                        'Extra Mayonnaise',
                                        style: darkBlueColor15SemiBoldTextStyle,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '\$2.00',
                                    style: darkBlueColor15SemiBoldTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            heightSpace,
                            heightSpace,
                            heightSpace,
                            heightSpace,
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isTap3 = !isTap3;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20.0,
                                        width: 20.0,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: isTap3
                                              ? primaryColor
                                              : Colors.transparent,
                                          border:
                                              Border.all(color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                        ),
                                        child: isTap3
                                            ? Icon(
                                                Icons.done,
                                                color: whiteColor,
                                                size: 15,
                                              )
                                            : Container(),
                                      ),
                                      widthSpace,
                                      widthSpace,
                                      widthSpace,
                                      Text(
                                        'Extra Veggies',
                                        style: darkBlueColor15SemiBoldTextStyle,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '\$1.50',
                                    style: darkBlueColor15SemiBoldTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
