import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tehnotop/constants/screens.dart';
import 'package:tehnotop/widget/column_builder.dart';

class OrderItemsInformation extends StatefulWidget {
  final OrderFromBase order;

  const OrderItemsInformation(this.order) : super();

  @override
  _OrderItemsInformationState createState() => _OrderItemsInformationState();
}

class _OrderItemsInformationState extends State<OrderItemsInformation> {

  bool _loading = false;
  String phoneNumber;
  String uuidOrder;

  final orderStatusList = [
    {
      'icon': 'assets/icons/done.png',
      'status': 'Order Placed',
      'time': '4:00 pm',
    },
    {
      'icon': 'assets/icons/restaurant_icon.png',
      'status': 'Preparing',
      'time': '4:05 pm',
    },
    {
      'icon': 'assets/icons/ready.png',
      'status': 'Order Ready',
      'time': '4:25 pm',
    },
    {
      'icon': 'assets/icons/transist.png',
      'status': 'In Transist',
      'time': '',
    },
    {
      'icon': 'assets/icons/delivered.png',
      'status': 'Delivered',
      'time': '',
    },
  ];

  @override
  void initState() {
    super.initState();
    uuidOrder = widget.order.docUID;
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    var bodyProgress = const Center(
        child: CircularProgressIndicator(
      value: null,
      color: primaryColor,
      strokeWidth: 4.0,
    ));

    var body = ListView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: [
        storeDetails(),
        orderItemsList(),
        // orderDelivery(),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        titleSpacing: 0.0,
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text('Деталі замовлення',
          style: whiteColor15SemiBoldTextStyle,
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: whiteColor,),
        ),
      ),
      body: _loading ? bodyProgress : body,
      bottomNavigationBar: closeOrderButton(context)
    );
  }

  shortDateToString(DateTime date) {
    var f = DateFormat('dd.MM.yyyy HH:mm:ss');
    return (f.format(date).toString());
  }

  sumOrderDoubleToString(double sum) {
    var f = NumberFormat("##0.00", "en_US");
    return (f.format(sum).toString());
  }

  _loadData() async {
    dynamic myResponse;

    setState(() {
      _loading = true;
    });

    try {
      const url = 'http://api-tehno.yarsoft.com.ua:35844/tehnotop/hs/app/v1/getdata';

      var jsonPost = '{"method":"get_client_order", '
          '"authorization":"38597848-s859-f588-g5568-1245986532sd", '
          '"uuid_order":"$uuidOrder", '
          '"phone":"$phoneNumber"}';

      const headersPost = {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, OPTIONS'
      };

      var response = await http
          .post(Uri.parse(url), headers: headersPost, body: jsonPost)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        return http.Response('Error', 500);
      });

      if (response.statusCode == 200) {
        myResponse = json.decode(response.body);

        // Если получили негативный результат от сервера, то прервем
        if (myResponse['result'] == false) {
          setState(() {
            _loading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Клієнта на сервері не знайдено! \n' +
                  myResponse['message'].toString()),
              duration: const Duration(seconds: 3)));
          return;
        }

        // Очистка списка полученных заказов
        globalListItemsOrder.clear();

        // Обход цикла заказов
        for (var order in myResponse['documents']) {
          // Обход цикла товаров заказа
          for (var docItem in order['docItems']) {

            // Запись в список заказов
            OrderItemFromBase newOrderItem = OrderItemFromBase.fromJson(docItem);

            globalListItemsOrder.add(newOrderItem);
          }
        }

        // Отладка :)
        debugPrint('Успешно! Загружено: ' +
            globalListItemsOrder.length.toString() +
            ' позиций заказа');

        setState(() {
          _loading = false;
        });

        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     behavior: SnackBarBehavior.floating,
        //     content: Text(myResponse['message'].toString()),
        //     duration: const Duration(seconds: 2)));
      } else {
        setState(() {
          _loading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
                'Доступ до серверу відсутній! \nКод помилки: ${response.statusCode}.'),
            duration: const Duration(seconds: 2)));
      }
    } catch (error) {
      debugPrint(error.toString());

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(myResponse['message'].toString()),
          duration: const Duration(seconds: 2)));

      setState(() {
        _loading = false;
      });
    }
  }

  statusList(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: orderStatusList.length,
        itemBuilder: (context, index) {
          final item = orderStatusList[index];
          return Padding(
            padding: EdgeInsets.fromLTRB(
              index == 0 ? fixPadding * 2.0 : 0.0,
              0.0,
              fixPadding * 2.0,
              0.0,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    item['icon'],
                    color: whiteColor,
                    height: 20,
                    width: 20,
                  ),
                ),
                heightSpace,
                Text(
                  item['status'],
                  style: darkBlueColor9MediumTextStyle,
                ),
                item['time'] != ''
                    ? Text(
                        item['time'],
                        style: primaryColorColor9MediumTextStyle,
                      )
                    : Container(
                        height: 3.0,
                        width: 3.0,
                        margin: EdgeInsets.only(top: 5.0),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  storeDetails() {
    return Container(
      margin: EdgeInsets.only(
          //top: fixPadding * 3.5,
          //bottom: fixPadding * 2.5,
          ),
      padding: EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding * 1.5,
      ),
      color: lightBlueColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            '№ замовлення: ${widget.order.docNumber}',
            style: darkBlueColor13SemiBoldTextStyle,
          ),
          SizedBox(height: 2),
          Text(
            'Місце видачі: ${widget.order.docStore}',
            style: greyColor11MediumTextStyle,
          ),
          SizedBox(height: 1),
          Text(
            'Нараховано бонусів: ${sumOrderDoubleToString(widget.order.docSumBonusPlus)} грн',
            style: greyColor11MediumTextStyle,
          ),
          SizedBox(height: 1),
          Text(
            'Списано бонусів: ${sumOrderDoubleToString(widget.order.docSumBonusMinus)} грн',
            style: greyColor11MediumTextStyle,
          ),

        ],
      ),
    );
  }

  orderInformation() {
    return Container(
      margin: EdgeInsets.all(fixPadding * 2.0),
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
            child: orderInformationRow(
              title: 'Назва',
              information1: 'К-сть',
              information2: 'Сума',
              style: darkBlueColor16SemiBoldTextStyle,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: fixPadding,
              vertical: fixPadding * 1.5,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                orderInformationRow(
                  title: 'Смартфон Xiaomi Note 10 5G 4/128GB NFC Green',
                  information1: '1',
                  information2: '6369.90',
                  style: darkBlueColor14MediumTextStyle,
                ),
                heightSpace,
                heightSpace,
                orderInformationRow(
                  title: 'Фреш смарт 12міс.',
                  information1: '1',
                  information2: '637.00',
                  style: darkBlueColor14MediumTextStyle,
                ),
                heightSpace,
                heightSpace,
                orderInformationRow(
                  title:
                      'Чохол Avantis Full Silicone case Xiaomi Redmi Note 10 5G Black',
                  information1: '1',
                  information2: '293.90',
                  style: darkBlueColor14MediumTextStyle,
                ),
                heightSpace,
                heightSpace,
                orderInformationRow(
                  title: 'Захисна плівка гідро Sunshine SS-057E Matte (Korea)',
                  information1: '1',
                  information2: '195.90',
                  style: darkBlueColor14MediumTextStyle,
                ),
                heightSpace,
                heightSpace,
                orderInformationRow(
                  title: 'Поклейка плотер',
                  information1: '1',
                  information2: '97.90',
                  style: darkBlueColor14MediumTextStyle,
                ),
                heightSpace,
                heightSpace,
                Divider(),
                orderInformationRow(
                  title: 'Сума замовлення',
                  information1: '',
                  information2: '7751.49',
                  style: darkBlueColor14MediumTextStyle,
                ),
                Divider(),
                orderInformationRow(
                  title: 'Доставка',
                  information1: '',
                  information2: '50.00',
                  style: greyColor14MediumTextStyle,
                ),
                Divider(),
                orderInformationRow(
                  title: 'Загалом',
                  information1: '',
                  information2: '7801.49',
                  style: primaryColor14MediumTextStyle,
                ),
                /*Padding(
                  padding: const EdgeInsets.only(
                    right: fixPadding * 1.5,
                    top: fixPadding * 1.5,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Service Tax: ',
                          style: greyColor11RegularTextStyle,
                        ),
                        TextSpan(
                          text: '\$2.50',
                          style: blackColor11RegularTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: fixPadding * 1.5,
                    top: 5.0,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Доставка: ',
                          style: greyColor11RegularTextStyle,
                        ),
                        TextSpan(
                          text: '\₴ 1.50',
                          style: blackColor11RegularTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: fixPadding * 1.5,
                    top: fixPadding * 1.5,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Загалом: ',
                          style: darkBlueColor12SemiBoldTextStyle,
                        ),
                        TextSpan(
                          text: '\₴ 32.00',
                          style: primaryColor12SemiBoldTextStyle,
                        )
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }

  orderItemsList() {
    return Container(
      margin: EdgeInsets.all(fixPadding * 2.0),
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
            child: orderInformationRow(
              title: 'Назва',
              information1: 'К-сть',
              information2: 'Сума',
              style: darkBlueColor16SemiBoldTextStyle,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: fixPadding,
              vertical: fixPadding * 1.5,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                ColumnBuilder(
                    itemCount: globalListItemsOrder.length,
                    itemBuilder: (context, index) {
                      final item = globalListItemsOrder[index];
                      return Column(children: [
                        orderInformationRow(
                            title: item.name,
                            information1: sumOrderDoubleToString(item.count),
                            information2: sumOrderDoubleToString(item.sum),
                            style: darkBlueColor14MediumTextStyle),
                        heightSpace,
                      ]
                      );
                    }
                ),
                Divider(),
                orderInformationRow(
                  title: 'Сума замовлення',
                  information1: '',
                  information2: sumOrderDoubleToString(widget.order.docSum),
                  style: primaryColor15SemiBoldTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  orderDelivery() {
    return Container(
      margin: EdgeInsets.all(fixPadding * 2.0),
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
            child: orderInformationRow(
              title: 'Назва',
              information1: 'К-сть',
              information2: 'Сума',
              style: darkBlueColor16SemiBoldTextStyle,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: fixPadding,
              vertical: fixPadding * 1.5,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                ColumnBuilder(
                    itemCount: globalListItemsOrder.length,
                    itemBuilder: (context, index) {
                      final item = globalListItemsOrder[index];
                      return Column(children: [
                        orderInformationRow(
                            title: item.name,
                            information1: sumOrderDoubleToString(item.count),
                            information2: sumOrderDoubleToString(item.sum),
                            style: darkBlueColor14MediumTextStyle),
                        heightSpace,
                      ]
                      );
                    }
                ),
                Divider(),
                orderInformationRow(
                  title: 'Сума замовлення',
                  information1: '',
                  information2: sumOrderDoubleToString(widget.order.docSum),
                  style: primaryColor15SemiBoldTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  orderInformationRow({title, information1, information2, style}) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Text(
            title,
            style: style,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            information1,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            information2,
            textAlign: TextAlign.right,
            style: style,
          ),
        ),
      ],
    );
  }

  closeOrderButton(context) {
    return Padding(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () => Navigator.pop(context),
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
            'Закрити',
            style: whiteColor20BoldTextStyle,
          ),
        ),
      ),
    );
  }
}
