import 'package:tehnotop/pages/screen.dart';

class ParticularItem extends StatefulWidget {
  final tag;
  final image;
  final name;
  final price;
  final foodType;

  const ParticularItem(
      {Key key,
      this.image = 'assets/food/food11.png',
      this.name = 'Chicken italiano cheezy periperi pizza',
      this.price = '14.99',
      this.foodType = 'NonVeg',
      this.tag})
      : super(key: key);
  @override
  _ParticularItemState createState() => _ParticularItemState();
}

class _ParticularItemState extends State<ParticularItem> {
  double height;
  int add = 1;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: nestedScrollView(),
      bottomNavigationBar: addOrderBottomBar(),
    );
  }

  nestedScrollView() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: height * 0.11,
            elevation: 0.0,
            floating: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios),
              color: whiteColor,
            ),
            flexibleSpace: Hero(
              tag: widget.tag,
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.price}\$',
                      style: whiteColor18BoldTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: ListView(
        padding: EdgeInsets.all(fixPadding * 2.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: fixPadding * 9.0),
                  child: title(widget.name),
                ),
              ),
              foodTypeIcon(),
            ],
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          description(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.dolore magna aliqua...'),
          heightSpace,
          heightSpace,
          heightSpace,
          title('Offers'),
          heightSpace,
          heightSpace,
          description(
              'Buy 2 pizza and get 1 medium size burger free with free home delivery!!'),
          addNoteTextField(),
        ],
      ),
    );
  }

  title(String title) {
    return Text(
      title,
      style: darkBlueColor16SemiBoldTextStyle,
    );
  }

  description(String description) {
    return Text(
      description,
      style: greyColor11RegularTextStyle,
    );
  }

  foodTypeIcon() {
    return Container(
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: widget.foodType == 'Veg' ? Colors.green : Colors.red,
        ),
      ),
      child: Container(
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
          color: widget.foodType == 'Veg' ? Colors.green : Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  addNoteTextField() {
    return TextField(
      cursorColor: primaryColor,
      style: darkBlueColor12SemiBoldTextStyle,
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Add a note (Extra souce,no olive oil etc...)',
        hintStyle: darkBlueColor12MediumTextStyle,
        border: UnderlineInputBorder(borderSide: BorderSide(color: greyColor)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: greyColor)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: greyColor)),
      ),
    );
  }

  addOrderBottomBar() {
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                add == 0 ? add = 0 : add -= 1;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5.0),
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
            add.toString(),
            style: darkBlueColor16MediumTextStyle,
          ),
          widthSpace,
          widthSpace,
          InkWell(
            onTap: () {
              setState(() {
                add += 1;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Icon(
                Icons.add,
                size: 12,
                color: whiteColor,
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          widthSpace,
          widthSpace,
          widthSpace,
          widthSpace,
          Expanded(
            child: Container(
              height: 50.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    blurRadius: 2.5,
                    spreadRadius: 2.5,
                  ),
                ],
              ),
              child: Text(
                'Add  to Order',
                style: whiteColor20BoldTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
