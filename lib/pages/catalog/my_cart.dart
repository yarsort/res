import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:tehnotop/constants/screens.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  String dropdownValue1;
  double totalSum = 0.0;
  double totalPay = 0.0;
  double serviceTax = 0.0;
  double deliveryCharge = 0.0;

  List<Item> listItems = [];

  @override
  void initState() {
    super.initState();

    globalListItemsBasket.clear();
    fillTestData();
    calculateTotal();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var body = ListView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: [
        cartList(),
        subTotal(),
        checkoutButton(),
      ],
    );


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        titleSpacing: 0.0,
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text('Кошик',
          style: whiteColor15SemiBoldTextStyle,
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: whiteColor,),
        ),
      ),
      body: globalListItemsBasket.length == 0
          ? noCartList()
          : body,
    );
  }

  fillTestData() {

    if (globalListItemsBasket.isEmpty) {
      //Для тестирования заказов
      var countOrder = 5;
      var price = 14999.0;

      while (countOrder != 0) {
        // Запись в список заказов
        Item tempItem = Item(
            uuid: '2345234 234t 234 234 53',
            code: countOrder.toString(),
            article: 'UA23466',
            name: 'Телевизор SAMSUNG UE55AU7100UXUA ' + countOrder.toString(),
            price: price,
            sum: (countOrder * price).toDouble(),
            count: countOrder,
            unit: 'шт',
            image:
            'https://randompicturegenerator.com/img/car-generator/g312a1db9dd11930ce7698981e6f1353258fa24ff7faae68e148ffdd4b16d18e958e78de6751cd7df595657572cb372c9_640.jpg',
            sumBonus: 0.0);

        globalListItemsBasket.add(tempItem);
        countOrder--;
      }
    }
  }

  calculateTotal() async {
    totalSum = 0.0;
    totalPay = 0.0;

    for (var item in globalListItemsBasket) {
      totalSum = totalSum + item.sum;
      totalPay = totalPay + item.sum;
    }

    setState(() {
      totalPay = totalPay + serviceTax;
      totalPay = totalPay + deliveryCharge;
    });
  }

  sumOrderDoubleToString(double sum) {
    var f = NumberFormat("##0.00", "en_US");
    return (f.format(sum).toString());
  }

  cartList() {
    return ColumnBuilder(
      itemCount: globalListItemsBasket.length,
      itemBuilder: (context, index) {
        final item = globalListItemsBasket[index];
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              secondaryActions: [
                Padding(
                  padding: EdgeInsets.only(bottom: fixPadding, top: fixPadding),
                  child: Row(
                    children: [
                      IconSlideAction(
                        caption: 'Info',
                        color: primaryColor,
                        icon: Icons.info,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => ParticularItem(
                                tag: globalListItemsBasket[index],
                              ),
                            ),
                          );
                        },
                      ),
                      // IconSlideAction(
                      //   caption: 'Видалити',
                      //   color: primaryColor,
                      //   icon: Icons.delete,
                      //   onTap: () {
                      //     setState(() {
                      //       globalListItemsBasket.removeAt(index);
                      //     });
                      //     calculateTotal();
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
              child: Container(
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
                                    item.name,
                                    style: darkBlueColor14SemiBoldTextStyle,
                                  ),
                                  heightSpace,
                                  Text(
                                    'Код: ' + item.code,
                                    style: greyColor12MediumTextStyle,
                                  ),
                                  Text(
                                    'Артикул: ' + item.article,
                                    style: greyColor12MediumTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://i.eldorado.ua/goods_images/1038962/7516717-1637327149.jpg",
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
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
                                '₴' + sumOrderDoubleToString(item.sum),
                                style: primaryColor13SemiBoldTextStyle,
                              ),
                              widthSpace,
                            ],
                          ),
                          Row(
                            children: [
                              widthSpace,
                              widthSpace,
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    globalListItemsBasket.removeAt(index);
                                  });
                                  calculateTotal();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Icon(
                                    Icons.delete_outline,
                                    size: 12,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                              widthSpace,
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    globalListItemsBasket[index].count == 1
                                        ? globalListItemsBasket[index].count = 1
                                        : globalListItemsBasket[index].count -= 1;
                                    globalListItemsBasket[index].sum =
                                        globalListItemsBasket[index].count *
                                            globalListItemsBasket[index].price;
                                  });
                                  calculateTotal();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: darkBlueColor,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 12,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                              widthSpace,
                              widthSpace,
                              Text(
                                item.count.toString(),
                                style: darkBlueColor13SemiBoldTextStyle,
                              ),
                              widthSpace,
                              widthSpace,
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    var tempIndex = globalListItemsBasket.indexOf(item);
                                    globalListItemsBasket[tempIndex].count += 1;
                                    globalListItemsBasket[tempIndex].sum =
                                        globalListItemsBasket[tempIndex].count *
                                            globalListItemsBasket[tempIndex].price;
                                  });
                                  calculateTotal();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: darkBlueColor,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 12,
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
              ),
            );
          },
        );
      },
    );
  }

  noCartList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.remove_shopping_cart,
            color: greyColor,
            size: 60.0,
          ),
          heightSpace,
          Text(
            'Кошик порожній',
            style: greyColor14MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          SizedBox(
            width: 300,
            height: 100,
            child: Text(
              'Для наповнення кошика в майбутньому Ви зможете скористатись каталогом товарів та послуг.',
              style: greyColor12MediumTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  subTotal() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding,
        fixPadding * 2.0,
        fixPadding,
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
              title: 'Загальна сума',
              amount: totalSum,
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
                  title: 'Доставка',
                  amount: deliveryCharge,
                  style: darkBlueColor15MediumTextStyle,
                ),
                heightSpace,
                heightSpace,
                subTotalRow(
                  title: 'До сплати',
                  amount: totalPay,
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
          sumOrderDoubleToString(amount),
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
            'Перейти до оплати',
            style: whiteColor20BoldTextStyle,
          ),
        ),
      ),
    );
  }
}
