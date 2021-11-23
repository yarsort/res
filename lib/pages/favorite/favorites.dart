import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tehnotop/pages/screen.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final favoriteList = [
    {
      'image': 'assets/restaurants_logo/logo1.png',
      'name': 'Marine Rise Restaurant',
      'rating': '4.3',
      'foodType': 'Fast food,Italian,Chinese',
      'distance': '2.5',
      'address': '1124, Church Street, New york, USA',
      'favoriteType': 'restaurant',
    },
    {
      'image': 'assets/food/food12.png',
      'name': 'Veg Sandwich',
      'price': '\$6.00',
      'description': 'Sauce tomato, mozzarella etc.',
      'favoriteType': 'food'
    },
    {
      'image': 'assets/food/food21.png',
      'name': 'Veg Frankie',
      'price': '\$10.00',
      'description': 'Sauce tomato, mozzarella etc.',
      'favoriteType': 'food'
    },
    {
      'image': 'assets/food/food17.png',
      'name': 'Margherite Pizza',
      'price': '\$12.00',
      'description': 'Sauce tomato, mozzarella etc.',
      'favoriteType': 'food'
    },
    {
      'image': 'assets/restaurants_logo/logo3.png',
      'name': 'Sevan Star Restaurant',
      'rating': '4.0',
      'foodType': 'Fast food,Italian,Chinese',
      'distance': '3.50',
      'address': '1124, Church Street, New york, USA',
      'favoriteType': 'restaurant'
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
          'Favorites',
          style: darkBlueColor18SemiBoldTextStyle,
        ),
      ),
      body: favoriteList.isNotEmpty ? favoritesList() : noFavorite(),
    );
  }

  noFavorite() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            color: greyColor,
            size: 60.0,
          ),
          Text(
            'No items in favorite',
            style: greyColor14MediumTextStyle,
          ),
        ],
      ),
    );
  }

  favoritesList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: favoriteList.length,
      itemBuilder: (context, index) {
        final item = favoriteList[index];
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: [
            Padding(
              padding: EdgeInsets.only(bottom: fixPadding, top: fixPadding),
              child: IconSlideAction(
                caption: 'Видалити',
                color: primaryColor,
                icon: Icons.delete,
                onTap: () {
                  setState(() {
                    favoriteList.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Позиція видалена з Улюбленого.'),
                  ));
                },
              ),
            ),
          ],
          child: Padding(
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Color(0xffe6e6e6),
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item['name'],
                                        style: darkBlueColor14SemiBoldTextStyle,
                                      ),
                                      item['favoriteType'] == 'food'
                                          ? Container()
                                          : Row(
                                              children: [
                                                Text(
                                                  item['rating'],
                                                  style:
                                                      primaryColor13SemiBoldTextStyle,
                                                ),
                                                widthSpace,
                                                Icon(
                                                  Icons.star,
                                                  color: primaryColor,
                                                  size: 15,
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                  Text(
                                    item['favoriteType'] == 'food'
                                        ? item['description']
                                        : item['foodType'],
                                    style: greyColor14MediumTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      item['favoriteType'] == 'food'
                          ? Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.topCenter,
                                margin:
                                    EdgeInsets.only(bottom: fixPadding * 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['price'],
                                      textAlign: TextAlign.end,
                                      style: primaryColor13SemiBoldTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  item['favoriteType'] == 'food'
                      ? Container()
                      : Column(
                          children: [
                            heightSpace,
                            Row(
                              children: [
                                widthSpace,
                                widthSpace,
                                Icon(
                                  Icons.location_on,
                                  color: primaryColor,
                                  size: 15,
                                ),
                                widthSpace,
                                Text(
                                  '${item['distance']} km',
                                  style: greyColor13MediumTextStyle,
                                ),
                                widthSpace,
                                verticalDivider(),
                                widthSpace,
                                Text(
                                  item['address'],
                                  style: greyColor13MediumTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  verticalDivider() {
    return Container(
      color: greyColor,
      height: 11.0,
      width: 1.5,
    );
  }
}
