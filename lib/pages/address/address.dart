import 'package:res/constants/screens.dart';
import 'package:res/widget/column_builder.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  String isSelected = 'Home';

  final addressList = [
    {
      'name': 'Дім',
      'address':
          '444, Grove Avenue, Golden Tower Near City Part, Washington  DC,United States Of America',
      'phoneNumber': '+19 1234567890',
    },
    {
      'name': 'Офіс',
      'address':
          'B 441, Old city town, Leminton street Near City Part, Washington DC,United States Of America',
      'phoneNumber': '+19 1234567890',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        titleSpacing: 0.0,
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text('Адреси доставки',
          style: whiteColor15SemiBoldTextStyle,
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: whiteColor,),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          address(),
          addNewAddress(),
        ],
      ),
    );
  }

  address() {
    return ColumnBuilder(
      itemCount: addressList.length,
      itemBuilder: (context, index) {
        final item = addressList[index];
        return Padding(
          padding: EdgeInsets.fromLTRB(
            fixPadding * 1.0,
            fixPadding,
            fixPadding * 2.0,
            fixPadding * 1.0,
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                isSelected = item['name'];
              });
            },
            child: Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['name'],
                          style: darkBlueColor16SemiBoldTextStyle,
                        ),
                        Container(
                          height: 15,
                          width: 15,
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(color: primaryColor),
                          ),
                          child: isSelected == item['name']
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : Container(),
                        ),
                      ],
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['address'],
                          style: darkBlueColor13RegularTextStyle,
                        ),
                        heightSpace,
                        Text(
                          item['phoneNumber'],
                          style: darkBlueColor13SemiBoldTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  addNewAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding,
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddAddress()),
        ),
        child: Container(
          padding: EdgeInsets.all(fixPadding),
          decoration: BoxDecoration(
            color: greyColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Добавити нову адресу',
                style: darkBlueColor16SemiBoldTextStyle,
              ),
              Container(
                height: 15,
                width: 15,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  size: 12,
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
