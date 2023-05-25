import 'package:res/constants/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String phoneNumber;
  int countOrders;

  List<Bonus> listBonuses = [];

  double height;
  double width;

  final offerList = [
    {'image': 'assets/offer_banner/app-ban001.png'},
    {'image': 'assets/offer_banner/app-ban002.png'},
  ];

  final storeList = [];

  @override
  void initState() {
    // Добавим первые 4 магазина из общего списка магазинов
    var i = 0;
    while (i <= 3) {
      storeList.add(constStoreList[i]);
      i++;
    }

    super.initState();

    // Грузим настройки приложения
    _loadDefaultBonus();
    _readSettings();

    // Автоматически обновляем только один раз при открытии или
    // через каждые 5 минут при переоткрытии окна
    if (globalListBonuses.isEmpty) {
      _loadData();
    }else{
      var diffDateSeconds = dateFutureUpdatingBonus.difference(DateTime.now()).inSeconds;
      if (diffDateSeconds < 0) {
        _loadData();
      }else{
        listBonuses = globalListBonuses;
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        titleSpacing: 0.0,
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text('ТЕХНОТОП',
          style: whiteColor15SemiBoldTextStyle,
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: whiteColor, size: 25,),
          tooltip: 'Головна',
          onPressed: () {
            currentIndex = 3;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomBar()),
            );
          },
        ),
        actions: [
          /*IconButton(
            icon: const Icon(Icons.shopping_cart, color: whiteColor),
            tooltip: 'Кошик',
            onPressed: () {

            },
          ),*/
        ],
      ),
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: () async {
          // Загрузка данных из базы
          _loadData();
        },
        child: ListView(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            titleFirst('Програма лояльності'),
            bonusListView(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title('Пропозиції'),
              ],
            ),
            offersListView(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title('Магазини'),
                InkWell(
                  onTap: () {
                    currentIndex = 2;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomBar()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: fixPadding * 2.0),
                    child: Text(
                      'Переглянути усі',
                      style: primaryColor12MediumTextStyle,
                    ),
                  ),
                ),
              ],
            ),
            storeListView(),
          ],
        ),
      ),
    );
  }

  sumOrderDoubleToString(double sum) {
    var f = NumberFormat("##0.00", "en_US");
    return (f.format(sum).toString());
  }

  _loadDefaultBonus() {
    if (listBonuses.length == 0) {
      Bonus newBonusActive = Bonus(
          name: 'Активні бонуси',
          sum: 0.00,
          type: 'active',
          activation: 'Термін дії невідомий');

      listBonuses.add(newBonusActive);

      Bonus newBonusPassive = Bonus(
          name: 'Пасивні бонуси',
          sum: 0.00,
          type: 'passive',
          activation: 'Дата активації невідома');

      listBonuses.add(newBonusPassive);
    }else{
      if(constBarcodeUser != '') {
        Bonus newBonusCard = Bonus(
            name: 'Картка клієнта',
            sum: 0.00,
            type: '',
            activation: '');
        listBonuses.add(newBonusCard);
      }
    }
  }

  _readSettings() async {
    SharedPreferences prefs = await _prefs;
    constPhoneNumber = (prefs.getString('settings_phoneUser') ?? '');
    constNameUser = prefs.getString('settings_nameUser');
  }

  _loadData() async {
    dynamic myResponse;

    SharedPreferences prefs = await _prefs;

    try {
      const url =
          'http://api-tehno.yarsoft.com.ua:35844/tehnotop/hs/app/v1/getdata';

      var jsonPost = '{"method":"get_client_data", '
          '"authorization":"38597848-s859-f588-g5568-1245986532sd", '
          '"phone":"$constPhoneNumber"}';

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

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Клієнта на сервері не знайдено! \n' +
                  myResponse['message'].toString()),
              duration: const Duration(seconds: 3)));
          return;
        }

        // Очистка списка полученных заказов
        listBonuses.clear();

       // Обход цикла заказов
        for (var itemBonus in myResponse['bonuses']) {
          // Запись в список заказов
          Bonus newBonus = Bonus.fromJson(itemBonus);

          listBonuses.add(newBonus);
        }

        // Установка бонусной карты при ее наличии
        constBarcodeUser = myResponse['cardCode'];

        // Запомним имя покупателя
        if(constNameUser == ''){

          constNameUser = myResponse['contragent'];
          prefs.setString("settings_nameUser", constNameUser);
        }

        // Отладка :)
        debugPrint('Успешно! Загружено: '+listBonuses.length.toString() +' значений');

        dateLastUpdatingBonus = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute,
            DateTime.now().second);

        dateFutureUpdatingBonus = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute+1);

        setState(() {
          _loadDefaultBonus();
        });

        globalListBonuses = listBonuses;

      } else {

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
    }
  }

  bonusListView() {
    return Container(
      height: height * 0.15,
      child: ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemCount: listBonuses.length,
        itemBuilder: (context, index) {
          final item = listBonuses[index];

          // Если есть штрихкод бонусной карты, то выведем её
          if (index == 2 && constBarcodeUser != '') {
            return barcodeView();

          // Если нет штрихкода бонусной карты, то ничего не выводим
          } else if (index == 2 && constBarcodeUser == ''){
            return null;

          // Выводим суммы активных и пассивных бонусов
          }else {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                  index == 0 ? fixPadding * 2.0 : fixPadding,
                  0.0,
                  index == listBonuses.length - 1 ? fixPadding * 2.0 : fixPadding,
                  0.0),
              child: Container(
                //color: whiteColor,
                height: height * 0.15,
                width: 220,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  /*image: DecorationImage(
                    image: AssetImage(item['image']),
                    fit: BoxFit.cover,
                  ),*/
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.card_giftcard,
                          color: item.type == 'active' ? primaryColor : greyColor,
                          size: 40,
                        ),
                      ],
                    ),
                    widthSpace,
                    widthSpace,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(item.name,
                          style: item.type == 'active' ? darkBlueColor17SemiBoldTextStyle : greyColor17SemiBoldTextStyle,),
                        heightSpace,
                        Text(sumOrderDoubleToString(item.sum),
                          style: item.type == 'active' ? primaryColor22SemiBoldTextStyle : greyColor22SemiBoldTextStyle,),
                        heightSpace,
                        Text(item.activation,
                          style: item.type == 'active' ? darkBlueColor12MediumTextStyle : greyColor12MediumTextStyle,),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  titleFirst(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding * 2.0,
        fixPadding * 2.0,
        fixPadding * 2.0,
      ),
      child: Text(
        title,
        style: darkBlueColor17SemiBoldTextStyle,
      ),
    );
  }

  title(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding * 2.0,
        fixPadding * 2.0,
        fixPadding,
      ),
      child: Text(
        title,
        style: darkBlueColor17SemiBoldTextStyle,
      ),
    );
  }

  barcodeView() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          fixPadding * 2.0,
          0.0,
          fixPadding * 2.0,
          0.0),
      child: Container(
        //color: whiteColor,
        height: height * 0.2,
        width: width * 0.9,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          /*image: DecorationImage(
                  image: AssetImage(item['image']),
                  fit: BoxFit.cover,
                ),*/
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: BarcodeWidget(
                drawText: false,
                color: darkBlueColor,
                barcode: Barcode.ean13(), // Barcode type and settings
                data: constBarcodeUser, // Content
                width: width * 0.75,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }

  offersListView() {
    return Container(
      height: height * 0.15,
      child: ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemCount: offerList.length,
        itemBuilder: (context, index) {
          final item = offerList[index];
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? fixPadding * 2.0 : 0.0,
              right: index == offerList.length - 1
                  ? fixPadding * 2.0
                  : fixPadding * 1.5,
            ),
            child: InkWell(
              /*onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ParticularItem(
                    tag: offerList[index],
                  ),
                ),
              ),*/
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                height: height * 0.10,
                width: width * 0.62,
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
                child: Hero(
                  tag: offerList[index],
                  child: Image.asset(
                    item['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  callDialog(context, item) {
    var tel = item['phoneNumber'].replaceAll('+', '');
    tel = tel.replaceAll(')', '');
    tel = tel.replaceAll('(', '');
    tel = tel.replaceAll('-', '');

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: bgColor,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          insetPadding: EdgeInsets.symmetric(horizontal: fixPadding * 5.0),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(fixPadding * 1.5),
                child: Column(
                  children: [
                    Text(
                      'Зателефонувати в магазин? \n \n'
                          '${item['address']} \n \n'
                          '${item['phoneNumber']}',
                      style: darkBlueColor15SemiBoldTextStyle,
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(fixPadding),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'Ні',
                                style: primaryColor15BoldTextStyle,
                              ),
                            ),
                          ),
                        ),
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final Uri uriTel = Uri(
                                scheme: 'tel',
                                path: tel,
                              );
                              await launchUrl(uriTel);
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(fixPadding),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'Так',
                                style: whiteColor15BoldTextStyle,
                              ),
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
  }

  storeListView() {
    return ColumnBuilder(
      itemCount: storeList.length,
      itemBuilder: (context, index) {
        final item = storeList[index];
        return Padding(
          padding: EdgeInsets.fromLTRB(
              fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding * 2.0),
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
                          padding: EdgeInsets.all(5.0),
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
                                  style: primaryColor12SemiBoldTextStyle,
                                ),
                                Row(
                                  children: [
                                    Text(item['type'],
                                      style: greyColor12MediumTextStyle,
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
                            // Text(
                            //   '${item['ratedPeopleCount']} людини порадили',
                            //   style: greyColor13MediumTextStyle,
                            // ),
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
                          style: darkBlueColor12MediumTextStyle,
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
                        child: GestureDetector(
                          onTap: () async {
                            callDialog(context, item);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item['phoneNumber'],
                                style: darkBlueColor12MediumTextStyle,
                              ),
                              Text(
                                'Зателефонувати',
                                style: greyColor12MediumTextStyle,
                              ),

                            ],
                          ),
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

}

// Класс для отображения списка товаров
Widget createListView(List items) {
  return new ListView(
      shrinkWrap: true,
      primary: false,
      children: items.map((productInfo) {
        return ListTile(
          leading: Tab(icon: Image.network('http://127.0.0.1:8080${productInfo.img}')),
          title: Text(productInfo.name),
          subtitle: Text('Цена: ${productInfo.price}'),
        );
      }).toList());
}
