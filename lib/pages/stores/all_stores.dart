import 'package:tehnotop/pages/screen.dart';

class AllStore extends StatelessWidget {

  final storeList = constStoreList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Магазини',
          style: darkBlueColor18SemiBoldTextStyle,
        ),
      ),
      body: storeListView(),
    );
  }

  storeListView() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: storeList.length,
      itemBuilder: (context, index) {
        final item = storeList[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0,
            fixPadding,
            fixPadding * 2.0,
            fixPadding,
          ),
          child: InkWell(
            // onTap: () => Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         RestaurantDetails(tag: storeList[index]),
            //   ),
            // ),
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
                      Hero(
                        tag: storeList[index],
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Color(0xffe6e6e6),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Icon(Icons.storefront,
                            size: 25,
                            color: primaryColor,),
                        ),
                      ),
                      widthSpace,
                      widthSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['name'],
                                  style: darkBlueColor13SemiBoldTextStyle,
                                ),
                                Row(
                                  children: [
                                    Text(item['type'],
                                      style: primaryColor12SemiBoldTextStyle,
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
                              '${item['ratedPeopleCount']} людини порадили',
                              style: greyColor13MediumTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  heightSpace,
                  Row(
                    children: [
                      widthSpace,
                      widthSpace,
                      Icon(
                        Icons.location_on,
                        color: darkBlueColor,
                        size: 15,
                      ),
                      widthSpace,
                      Expanded(
                        child: Text(
                          item['address'],
                          style: greyColor12MediumTextStyle,
                        ),
                      ),
                    ],
                  ),
                  heightSpace,
                  Row(
                    children: [
                      widthSpace,
                      widthSpace,
                      Icon(
                        Icons.system_security_update_good,
                        color: darkBlueColor,
                        size: 15,
                      ),
                      widthSpace,
                      Expanded(
                        child: Text(
                          item['phoneNumber'],
                          style: greyColor12MediumTextStyle,
                        ),
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
