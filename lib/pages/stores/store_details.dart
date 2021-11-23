import 'package:tehnotop/pages/screen.dart';
import 'package:tehnotop/widget/column_builder.dart';

class RestaurantDetails extends StatefulWidget {
  final tag;

  const RestaurantDetails({Key key, this.tag}) : super(key: key);

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  double height;
  double width;
  bool isFavorite = false;
  bool isTap1 = false;
  bool isTap2 = false;
  bool isTap3 = false;

  final popularList = [
    {
      'image': 'assets/food/food12.png',
      'foodName': 'Veg Cheese Sandwich',
      'price': '7.00'
    },
    {
      'image': 'assets/food/food16.png',
      'foodName': 'Veg Frankie',
      'price': '6.00'
    },
  ];

  final reviewList = [
    {
      'image': 'assets/users/user1.png',
      'name': 'George Smith',
      'date': 'June 25, 2020',
      'rating': 4,
      'review':
          'Marine rise restaurant sit amet, consectetur adipiscing elit, sed do eiusmod tempor rise sit.....',
    },
    {
      'image': 'assets/users/user2.png',
      'name': 'Grecy John',
      'date': 'June 28, 2020',
      'rating': 3,
      'review':
          'Marine rise restaurant sit amet, consectetur adipiscing elit, sed do eiusmod tempor rise sit.....',
    },
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/food/food15.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: height,
            padding: EdgeInsets.only(top: fixPadding * 7.0),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                restaurantDetails(),
                title('Most Popular'),
                popularFoodList(),
                title('What People Says'),
                reviewsList(),
                orderNow(),
              ],
            ),
          ),
          backArrow(),
          favoriteAndShareButton(),
        ],
      ),
    );
  }

  backArrow() {
    return Positioned(
      top: 60.0,
      left: 20.0,
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios),
        color: whiteColor,
      ),
    );
  }

  favoriteAndShareButton() {
    return Positioned(
      top: 60.0,
      right: 20.0,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: whiteColor,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
            color: whiteColor,
          ),
        ],
      ),
    );
  }

  restaurantDetails() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(
            fixPadding * 2.0,
            fixPadding * 3.2,
            fixPadding * 2.0,
            0.0,
          ),
          decoration: BoxDecoration(
            color: lightBlueColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                  fixPadding * 1.5,
                  fixPadding,
                  fixPadding,
                  fixPadding,
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      color: greyColor.withOpacity(0.12),
                      spreadRadius: 2.5,
                      blurRadius: 2.5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 70),
                        widthSpace,
                        widthSpace,
                        Expanded(
                          child: Text(
                            'Marine Rise Restaurant',
                            overflow: TextOverflow.fade,
                            style: darkBlueColor14SemiBoldTextStyle,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          '4.3',
                          style: primaryColor15SemiBoldTextStyle,
                        ),
                        widthSpace,
                        Icon(
                          Icons.star_rounded,
                          color: primaryColor,
                          size: 18,
                        ),
                      ],
                    ),
                    heightSpace,
                    Text(
                      'Fast food, Italian, Chinese',
                      style: greyColor14MediumTextStyle,
                    ),
                    heightSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: primaryColor,
                          size: 16,
                        ),
                        widthSpace,
                        Text(
                          '2.5 km',
                          style: greyColor13MediumTextStyle,
                        ),
                        widthSpace,
                        verticalDivider(greyColor),
                        widthSpace,
                        Expanded(
                          child: Text(
                            '1124,Church Street, New york, USA',
                            overflow: TextOverflow.ellipsis,
                            style: greyColor13MediumTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(fixPadding * 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Restaurant',
                      style: darkBlueColor14SemiBoldTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: fixPadding * 2.0),
                      child: Text(
                        'Marine rise restaurant sit amet, consectetur adipiscing elit, sed do eiusmod tempor rise sit incididunt labore et dolore....',
                        style: greyColor11RegularTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0.0,
          left: 35.0,
          child: Hero(
            tag: widget.tag,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                image: DecorationImage(
                  image: AssetImage('assets/restaurants_logo/food8.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  title(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding * 2.5,
        fixPadding * 2.0,
        fixPadding * 1.5,
      ),
      child: Text(
        title,
        style: darkBlueColor17SemiBoldTextStyle,
      ),
    );
  }

  popularFoodList() {
    return Container(
      height: height * 0.143,
      child: ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemCount: popularList.length,
        itemBuilder: (context, index) {
          final item = popularList[index];
          return Padding(
            padding: EdgeInsets.fromLTRB(
              index == 0 ? fixPadding * 2.0 : 0.0,
              0.0,
              fixPadding * 1.5,
              0.0,
            ),
            child: InkWell(
              onTap: () => customiseDialog(item['foodName'], item['price']),
              child: Card(
                color: lightBlueColor,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.10,
                        width: width * 0.51,
                        child: Image.asset(
                          item['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: fixPadding,
                          vertical: 5.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item['foodName'],
                              style: darkBlueColor12SemiBoldTextStyle,
                            ),
                            widthSpace,
                            verticalDivider(darkBlueColor),
                            widthSpace,
                            Text(
                              '\$${item['price']}',
                              style: primaryColor11SemiBoldTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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

  reviewsList() {
    return ColumnBuilder(
      itemCount: reviewList.length,
      itemBuilder: (context, index) {
        final item = reviewList[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0,
            0.0,
            fixPadding * 2.0,
            fixPadding * 2.0,
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(
              fixPadding * 1.5,
              fixPadding / 2,
              fixPadding / 2,
              fixPadding * 1.5,
            ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ratingStars(item['rating']),
                            ],
                          ),
                          Text(
                            item['name'],
                            style: darkBlueColor14SemiBoldTextStyle,
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            item['date'],
                            style: greyColor11MediumTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                heightSpace,
                Text(
                  item['review'],
                  style: greyColor11MediumTextStyle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ratingStars(int rating) {
    return Row(
      children: [
        (rating == 5 ||
                rating == 4 ||
                rating == 3 ||
                rating == 2 ||
                rating == 1)
            ? Icon(Icons.star_rounded, color: primaryColor, size: 16)
            : Icon(Icons.star_rounded, color: greyColor, size: 16),
        (rating == 5 || rating == 4 || rating == 3 || rating == 2)
            ? Icon(Icons.star_rounded, color: primaryColor, size: 16)
            : Icon(Icons.star_rounded, color: greyColor, size: 16),
        (rating == 5 || rating == 4 || rating == 3)
            ? Icon(Icons.star_rounded, color: primaryColor, size: 16)
            : Icon(Icons.star_rounded, color: greyColor, size: 16),
        (rating == 5 || rating == 4)
            ? Icon(Icons.star_rounded, color: primaryColor, size: 16)
            : Icon(Icons.star_rounded, color: greyColor, size: 16),
        (rating == 5)
            ? Icon(Icons.star_rounded, color: primaryColor, size: 16)
            : Icon(Icons.star_rounded, color: greyColor, size: 16),
      ],
    );
  }

  orderNow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding,
        fixPadding * 2.0,
        fixPadding * 2.0,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RestaurantItems()),
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
            'Order Food Now',
            style: whiteColor20BoldTextStyle,
          ),
        ),
      ),
    );
  }

  verticalDivider(Color color) {
    return Container(
      color: color,
      height: 11.0,
      width: 1.5,
    );
  }
}
