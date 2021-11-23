import 'dart:convert';
export 'package:tehnotop/constants/model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tehnotop/pages/screen.dart';
import 'package:tehnotop/widget/column_builder.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<Order> listOrders = [];
  bool _loading = false;
  String phoneNumber;

  @override
  void initState() {
    super.initState();
    _readSettings();

    // Автоматически обновляем только один раз при открытии или
    // через каждые 5 минут при переоткрытии окна
    if (constListOrders.isEmpty) {
      _loadData();
    }else{
      var diffDateSeconds = dateFutureUpdatingOrders.difference(DateTime.now()).inSeconds;
      if (diffDateSeconds < 0) {
        _loadData();
      }else{
        listOrders = constListOrders;
      }
    }
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
      physics: BouncingScrollPhysics(),
      children: [
        //title('Виконані замовлення'),
        Text(
          'Останнє оновлення списку: ${fullDateToString(dateLastUpdatingOrders)}',
          style: greyColor10MediumTextStyle,
          textAlign: TextAlign.center,
        ),
        processOrdersList(),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Замовлення',
          style: darkBlueColor18SemiBoldTextStyle,
        ),
      ),
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: () async {
          // Загрузка данных из базы
          _loadData();
        },
        child: _loading
            ? bodyProgress
            : listOrders.length == 0
                ? noOrders()
                : body,
      ),
    );
  }

  shortDateToString(DateTime date) {
    var f = DateFormat('dd.MM.yyyy');
    return (f.format(date).toString());
  }

  fullDateToString(DateTime date) {
    var f = DateFormat('dd.MM.yyyy HH:mm:ss');
    return (f.format(date).toString());
  }

  shortTimeToString(DateTime date) {
    var f = DateFormat('HH:mm:ss');
    return (f.format(date).toString());
  }

  sumOrderDoubleToString(double sum) {
    var f = NumberFormat("##0.00", "en_US");
    return (f.format(sum).toString());
  }

  _readSettings() async {
    SharedPreferences prefs = await _prefs;

    phoneNumber = (prefs.getString('settings_phoneUser') ?? '');
  }

  _loadData() async {
    dynamic myResponse;

    setState(() {
      _loading = true;
    });

    SharedPreferences prefs = await _prefs;
    phoneNumber = await (prefs.getString('settings_phoneUser') ?? '');

    try {
      const url = 'http://195.34.205.251:35844/tehnotop/hs/app/v1/getdata';

      var jsonPost = '{"method":"get_client_orders", '
          '"authorization":"38597848-s859-f588-g5568-1245986532sd", '
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
        listOrders.clear();

        // Для тестирования заказов
        // var countOrder = 0;
        // while (countOrder != 0 ){
        //   // Запись в список заказов
        //   Order newOrderTemp1 = Order(
        //       '2345234 234t 234 234 53',
        //       'Stryzhakov Yaroslav',
        //       '10.11.2021 19:50:37',
        //       'New',
        //       '2345234 234t 234 234 53',
        //       'GF-091023',
        //       'Yaroslav',
        //       '1256.00',
        //       double.parse('120.00'),
        //       double.parse('20.00'),
        //       'Магазин м. Козятин',
        //       int.parse('1236'));
        //
        //   listOrders.add(newOrderTemp1);
        //   countOrder--;
        // }

        // Обход цикла заказов
        for (var order in myResponse['documents']) {
          // Запись в список заказов
          Order newOrder = Order.fromJson(order);
          listOrders.add(newOrder);
        }

        dateLastUpdatingOrders = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute,
            DateTime.now().second);

        dateFutureUpdatingOrders = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute+1);

        constListOrders = listOrders;

        // Отладка :)
        debugPrint('Успешно! Загружено: '+listOrders.length.toString() +' значений');

        setState(() {
          _loading = false;
        });

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

  noOrders() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.list_alt,
            color: greyColor,
            size: 60.0,
          ),
          Text(
            'Замовлень немає',
            style: greyColor14MediumTextStyle,
          ),
        ],
      ),
    );
  }

  title(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding,
      ),
      child: Text(
        title,
        style: greyColor16SemiBoldTextStyle,
      ),
    );
  }

  processOrdersList() {
    return ColumnBuilder(
      itemCount: listOrders.length,
      itemBuilder: (context, index) {
        final item = listOrders[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0,
            fixPadding,
            fixPadding * 2.0,
            fixPadding,
          ),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderItemsInformation(item)),
            ),
            child: Container(
              padding: EdgeInsets.all(fixPadding),
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      shortDateToString(item.docDate),
                                      style: darkBlueColor14SemiBoldTextStyle,
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      shortTimeToString(item.docDate),
                                      style: greyColor11MediumTextStyle,
                                    ),
                                  ],
                                ),
                                heightSpace,
                                Text(
                                  item.docStore,
                                  style: greyColor11MediumTextStyle,
                                ),
                                SizedBox(height: 1),
                                Text(
                                  '№ замовлення: ${item.docNumber}',
                                  style: greyColor11MediumTextStyle,
                                ),
                                SizedBox(height: 1),
                                Text(
                                  'Кількість товарів: ${item.docItemsCount.toString()} поз.',
                                  style: greyColor11MediumTextStyle,
                                ),
                                SizedBox(height: 1),
                                Text(
                                  'Нараховано бонусів: ${sumOrderDoubleToString(item.docSumBonusPlus)} грн',
                                  style: greyColor11MediumTextStyle,
                                ),
                                SizedBox(height: 1),
                                Text(
                                  'Списано бонусів: ${sumOrderDoubleToString(item.docSumBonusMinus)} грн',
                                  style: greyColor11MediumTextStyle,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '₴' + sumOrderDoubleToString(item.docSum),
                                  style: primaryColor15SemiBoldTextStyle,
                                ),
                                heightSpace,
                                Text(
                                  'Нараховано бонусів',
                                  style: greyColor10MediumTextStyle,
                                ),
                                Text(
                                  '\₴${sumOrderDoubleToString(item.docSumBonusPlus)}',
                                  style: primaryColor13SemiBoldTextStyle,
                                ),
                                heightSpace,
                                Text(
                                  'Списано бонусів',
                                  style: greyColor10MediumTextStyle,
                                ),
                                Text(
                                  '\₴${sumOrderDoubleToString(item.docSumBonusMinus)}',
                                  style: darkBlueColor13SemiBoldTextStyle,
                                ),
                              ],
                            )
                          ],
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

  divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding),
      color: greyColor,
      height: 38.0,
      width: 1.5,
    );
  }
}
