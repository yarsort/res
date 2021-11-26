import 'package:tehnotop/constants/screens.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  String _currentMessage;

  final messageList = [
    {
      'message': 'Hello',
      'isMe': true,
    },
    {
      'message': 'How much time?',
      'isMe': true,
    },
    {
      'message': 'On my way ma\'m.\nWill reach in 10 mins.',
      'isMe': false,
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'George Anderson',
              style: darkBlueColor18SemiBoldTextStyle,
            ),
            Text(
              'Delivery man',
              style: greyColor14MediumTextStyle,
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heightSpace,
          heightSpace,
          messagesList(),
          textField(),
        ],
      ),
    );
  }

  messagesList() {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        itemCount: messageList.length,
        itemBuilder: (context, index) {
          final item = messageList[index];
          return Row(
            mainAxisAlignment:
                item['isMe'] ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: fixPadding * 2.0),
                padding: EdgeInsets.symmetric(
                  horizontal: fixPadding * 2.5,
                  vertical: fixPadding,
                ),
                decoration: BoxDecoration(
                  color: item['isMe'] ? whiteColor : lightBlueColor,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: greyColor.withOpacity(0.1),
                      spreadRadius: 2.5,
                      blurRadius: 2.5,
                    ),
                  ],
                ),
                child: Text(
                  item['message'],
                  style: darkBlueColor13RegularTextStyle,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  textField() {
    var mes = {
      'message': _currentMessage,
      'isMe': true,
    };
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding,
      ),
      child: Row(
        children: [
          Icon(
            Icons.add,
            size: 20,
            color: Colors.blue,
          ),
          widthSpace,
          Icon(
            Icons.camera_alt_outlined,
            size: 15,
            color: greyColor,
          ),
          widthSpace,
          widthSpace,
          Expanded(
            child: Container(
              height: 45.0,
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: greyColor.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _currentMessage = value;
                  });
                },
                controller: messageController,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          InkWell(
            onTap: () {
              messageController.clear();
              setState(() {
                messageList.add(mes);
              });
            },
            child: Icon(
              Icons.near_me_outlined,
              size: 15,
              color: Colors.blue,
            ),
          ),
          widthSpace,
          Icon(
            Icons.mic,
            size: 15,
            color: greyColor,
          ),
        ],
      ),
    );
  }
}
