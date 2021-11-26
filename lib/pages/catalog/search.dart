import 'package:tehnotop/constants/screens.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isTap1 = false;
  bool isTap2 = false;
  bool isTap3 = false;
  double height;

  final popularItemList = [
    {
      'image': 'assets/food/food12.png',
      'name': 'Veg Sandwich',
      'price': '6.00',
      'customise': 'Customise',
    },
    {
      'image': 'assets/food/food12.png',
      'name': 'Veg Sandwich',
      'price': '6.00',
      'customise': 'Customise',
    },
    {
      'image': 'assets/food/food12.png',
      'name': 'Veg Sandwich',
      'price': '6.00',
      'customise': 'Customise',
    },
    {
      'image': 'assets/food/food13.png',
      'name': 'Burger',
      'price': '12.00',
      'customise': '',
    },
    {
      'image': 'assets/food/food12.png',
      'name': 'Veg Sandwich',
      'price': '6.00',
      'customise': 'Customise',
    },
    {
      'image': 'assets/food/food13.png',
      'name': 'Burger',
      'price': '12.00',
      'customise': '',
    },
    {
      'image': 'assets/food/food13.png',
      'name': 'Burger',
      'price': '12.00',
      'customise': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          backArrow(),
          searchTextField(),
          title('Popular Items'),
          popularItemsList(),
        ],
      ),
    );
  }

  backArrow() {
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios),
        color: darkBlueColor,
      ),
    );
  }

  searchTextField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding,
        fixPadding * 2.0,
        fixPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
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
            child: TextField(
              cursorColor: primaryColor,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: greyColor,
                  size: 20,
                ),
                hintText: 'Fast food...',
                hintStyle: greyColor14MediumTextStyle,
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          Text(
            '(ex. pizza,abc restro, etc...)',
            style: greyColor10MediumTextStyle,
          ),
        ],
      ),
    );
  }

  title(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        5.0,
        fixPadding * 2.0,
        5.0,
      ),
      child: Text(
        title,
        style: darkBlueColor17SemiBoldTextStyle,
      ),
    );
  }

  popularItemsList() {
    return Container(
      height: height * 0.77,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: popularItemList.length,
        itemBuilder: (context, index) {
          final item = popularItemList[index];
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
