import 'package:res/constants/screens.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  String isSelected = 'Дім';
  final addressTypeList = [
    {
      'image': 'assets/address_type/home.png',
      'addressType': 'Дім',
    },
    {
      'image': 'assets/address_type/office.png',
      'addressType': 'Офіс',
    },
    {
      'image': 'assets/address_type/other.png',
      'addressType': 'Інше',
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
          'Нова адреса',
          style: darkBlueColor18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          deliverToTextField(),
          mobileNumberTextField(),
          pincodeTextField(),
          houseNumberTextField(),
          streetNameTextField(),
          addressType(),
        ],
      ),
      bottomNavigationBar: addButton(),
    );
  }

  deliverToTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding,
        fixPadding * 2.0,
        fixPadding * 1.2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Отримувач',
            style: darkBlueColor14SemiBoldTextStyle,
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(fixPadding * 1.3),
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
            child: TextField(
              cursorColor: primaryColor,
              style: darkBlueColor14MediumTextStyle,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: 'Наприклад, John Doe',
                hintStyle: greyColor13MediumTextStyle,
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          Text(
            'Доставка буде оформлена на це ім\'я',
            style: greyColor11MediumTextStyle,
          ),
        ],
      ),
    );
  }

  mobileNumberTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding * 1.2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Номер телефону',
            style: darkBlueColor14SemiBoldTextStyle,
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(fixPadding * 1.3),
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
            child: TextField(
              cursorColor: primaryColor,
              style: darkBlueColor14MediumTextStyle,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: 'Наприклад, +380988547870',
                hintStyle: greyColor13MediumTextStyle,
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          Text(
            'Для спілкування з менеджером продажів',
            style: greyColor11MediumTextStyle,
          ),
        ],
      ),
    );
  }

  pincodeTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding * 1.2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Індекс',
            style: darkBlueColor14SemiBoldTextStyle,
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(fixPadding * 1.3),
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
            child: TextField(
              cursorColor: primaryColor,
              style: darkBlueColor14MediumTextStyle,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: 'Наприклад, 123654',
                hintStyle: greyColor13MediumTextStyle,
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  houseNumberTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding * 1.2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '№ будівлі або квартири',
            style: darkBlueColor14SemiBoldTextStyle,
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(fixPadding * 1.3),
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
            child: TextField(
              cursorColor: primaryColor,
              style: darkBlueColor14MediumTextStyle,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: 'Наприклад, дім 25',
                hintStyle: greyColor13MediumTextStyle,
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  streetNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding * 1.2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Вулиця',
            style: darkBlueColor14SemiBoldTextStyle,
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(fixPadding * 1.3),
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
            child: TextField(
              cursorColor: primaryColor,
              style: darkBlueColor14MediumTextStyle,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: 'Наприклад, Шевченка',
                hintStyle: greyColor13MediumTextStyle,
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addressType() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: fixPadding * 1.2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2.0,
            ),
            child: Text(
              'Тип адреси',
              style: darkBlueColor14SemiBoldTextStyle,
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: addressTypeList.length,
              itemBuilder: (context, index) {
                final item = addressTypeList[index];
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    index == 0 ? fixPadding * 2.0 : 0.0,
                    0.0,
                    index == addressTypeList.length - 1
                        ? fixPadding * 2.0
                        : fixPadding,
                    0.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isSelected = item['addressType'];
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0,
                        vertical: fixPadding,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected == item['addressType']
                            ? darkBlueColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: darkBlueColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            item['image'],
                            height: 22,
                            width: 22,
                          ),
                          widthSpace,
                          Text(
                            item['addressType'],
                            style: TextStyle(
                              color: isSelected == item['addressType']
                                  ? whiteColor
                                  : darkBlueColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  addButton() {
    return Padding(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          Navigator.pop(context);
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
            'Зберегти',
            style: whiteColor20BoldTextStyle,
          ),
        ),
      ),
    );
  }
}
