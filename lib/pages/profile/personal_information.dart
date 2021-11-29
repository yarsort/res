import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tehnotop/constants/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInformation extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  File image;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final nameController = TextEditingController();
  final changeNameController = TextEditingController();
  final passwordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final changePhoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final changeEmailController = TextEditingController();

  _readSettings() async {
    SharedPreferences prefs = await _prefs;
    setState(() {
      nameController.text = (prefs.getString('settings_nameUser') ?? '');
      passwordController.text = (prefs.getString('settings_passwordUser') ?? '');
      phoneNumberController.text = (prefs.getString('settings_phoneUser') ?? '');
      emailController.text = (prefs.getString('settings_emailUser') ?? '');
    });
  }

  _saveSettings() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      prefs.setString("settings_nameUser", nameController.text);
      prefs.setString("settings_passwordUser", passwordController.text);
      prefs.setString("settings_phoneUser", phoneNumberController.text);
      prefs.setString("settings_emailUser", emailController.text);
    });
  }

  @override
  void initState() {
    super.initState();
    _readSettings();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          heightSpace,
          heightSpace,
          //image != null ? profilePick() : profilePickDefault(),
          profilePickDefault(),
          nameTextField(),
          //passwordTextField(),
          phoneNumberTextField(),
          emailTextField(),
        ],
      ),
      bottomNavigationBar: saveButton(),
    );
  }

  Widget loadImage() {
      return Image.file(image,
        width: 160,
        height: 160);
  }

  profilePick() {
    return Stack(
      children: [
        Center(
          child: InkWell(
            onTap: () => changeProfilePick(),
            child: CircleAvatar(
              radius: 60,
              child: ClipOval(
                child: Image.file(image,
                    width: 300 ,
                    height: 300),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 1.0,
          right: 110.0,
          child: InkWell(
            onTap: () => changeProfilePick(),
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: whiteColor,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  profilePickDefault() {
    return Stack(
      children: [
        Center(
          child: InkWell(
            onTap: () => changeProfilePick(),
            child: Hero(
              tag: 'profilePick',
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  changeProfilePick() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: bgColor,
          child: Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(fixPadding),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: fixPadding),
                      child: Text(
                        'Виберіть фото',
                        textAlign: TextAlign.center,
                        style: darkBlueColor14SemiBoldTextStyle,
                      ),
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    InkWell(
                      onTap: () async {

                        // final picker = ImagePicker();
                        // Directory directory = await getApplicationDocumentsDirectory();
                        //
                        // String path = directory.path;
                        //
                        // if (path == '') {
                        //   throw MissingPlatformDirectoryException(
                        //       'Доступ до каталогу програми заборонено!');
                        // }
                        //
                        // final XFile pickedImage = await picker.pickImage(source: ImageSource.camera);
                        //
                        // if (pickedImage == null) return;
                        //
                        // File tmpFile = File(pickedImage.path);
                        // tmpFile = await tmpFile.copy('$path/avatar.jpg');
                        //
                        // final SharedPreferences prefs = await _prefs;
                        // prefs.setString("settings_avatarUser", tmpFile.path);
                        //
                        // constAvatarUserPath = tmpFile.path;
                        //
                        // setState(() {
                        //   image = tmpFile;
                        // });

                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.camera_alt,
                              color: darkBlueColor,
                              size: 18.0,
                            ),
                            widthSpace,
                            widthSpace,
                            Text(
                              'Камера',
                              style: darkBlueColor13SemiBoldTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // final picker = ImagePicker();
                        // final Directory path = await getApplicationDocumentsDirectory();
                        //
                        // if (path == null) {
                        //   throw MissingPlatformDirectoryException(
                        //       'Доступ до каталогу програми заборонено!');
                        // }
                        //
                        // final XFile pickedImage = await picker.pickImage(source: ImageSource.gallery);
                        //
                        // if (pickedImage == null) return;
                        //
                        // File tmpFile = File(pickedImage.path);
                        // tmpFile = await tmpFile.copy('$path/avatar.png');
                        //
                        // setState(() {
                        //   image = tmpFile;
                        // });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.photo_library,
                              color: darkBlueColor,
                              size: 18.0,
                            ),
                            widthSpace,
                            widthSpace,
                            Text(
                              'Фото з "Галереї"',
                              style: darkBlueColor13SemiBoldTextStyle,
                            ),
                          ],
                        ),
                      ),
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

  nameTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding * 4.0,
        fixPadding * 2.0,
        fixPadding * 2.0,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () => changeName(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: fixPadding, vertical: 5.0),
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
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'ПІБ',
                  style: greyColor14SemiBoldTextStyle,
                ),
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  cursorColor: primaryColor,
                  enabled: false,
                  controller: nameController,
                  style: darkBlueColor14SemiBoldTextStyle,
                  decoration: InputDecoration(
                    isDense: true,
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: greyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  changeName() {
    showDialog(
      context: context,
      builder: (context) {
        changeNameController.text = nameController.text;
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
                      'Зміна прізвища та імені',
                      style: darkBlueColor15SemiBoldTextStyle,
                    ),
                    heightSpace,
                    heightSpace,
                    TextField(
                      cursorColor: primaryColor,
                      controller: changeNameController,
                      style: greyColor14SemiBoldTextStyle,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        isDense: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                      ),
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
                                'Відміна',
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
                            onTap: () {
                              Navigator.pop(context);
                              nameController.text = changeNameController.text;
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
                                'Зберегти',
                                style: whiteColor15BoldTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  passwordTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding,
        fixPadding * 2.0,
        fixPadding * 2.0,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () => changePassword(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: fixPadding, vertical: 5.0),
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
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Пароль',
                  style: greyColor14SemiBoldTextStyle,
                ),
              ),
              Expanded(
                flex: 4,
                child: TextField(
                  enabled: false,
                  controller: passwordController,
                  obscureText: true,
                  style: darkBlueColor14SemiBoldTextStyle,
                  decoration: InputDecoration(
                    isDense: true,
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: greyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  changePassword() {
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
                      'Зміна пароля',
                      style: darkBlueColor15SemiBoldTextStyle,
                    ),
                    heightSpace,
                    heightSpace,
                    TextField(
                      obscureText: true,
                      controller: oldPasswordController,
                      cursorColor: primaryColor,
                      style: greyColor14SemiBoldTextStyle,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Старий пароль',
                        hintStyle: greyColor14SemiBoldTextStyle,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                      ),
                    ),
                    heightSpace,
                    TextField(
                      obscureText: true,
                      controller: newPasswordController,
                      cursorColor: primaryColor,
                      style: greyColor14SemiBoldTextStyle,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Новий пароль',
                        hintStyle: greyColor14SemiBoldTextStyle,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                      ),
                    ),
                    heightSpace,
                    TextField(
                      obscureText: true,
                      controller: confirmPasswordController,
                      cursorColor: primaryColor,
                      style: greyColor14SemiBoldTextStyle,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Підтвердження',
                        hintStyle: greyColor14SemiBoldTextStyle,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                      ),
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
                            onTap: () {
                              oldPasswordController.clear();
                              newPasswordController.clear();
                              confirmPasswordController.clear();
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(fixPadding),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'Відміна',
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
                            onTap: () {
                              if (newPasswordController.text ==
                                      confirmPasswordController.text &&
                                  oldPasswordController.text ==
                                      passwordController.text) {
                                passwordController.text =
                                    confirmPasswordController.text;
                                Navigator.of(context).pop();
                              }
                              oldPasswordController.clear();
                              newPasswordController.clear();
                              confirmPasswordController.clear();
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
                                'Зберегти',
                                style: whiteColor15BoldTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  phoneNumberTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding,
        fixPadding * 2.0,
        fixPadding * 2.0,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () => changePhoneNumber(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: fixPadding, vertical: 5.0),
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
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Телефон',
                  style: greyColor14SemiBoldTextStyle,
                ),
              ),
              Expanded(
                flex: 4,
                child: TextField(
                  enabled: false,
                  controller: phoneNumberController,
                  style: darkBlueColor14SemiBoldTextStyle,
                  decoration: InputDecoration(
                    isDense: true,
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: greyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  changePhoneNumber() {
    showDialog(
      context: context,
      builder: (context) {
        changePhoneNumberController.text = phoneNumberController.text;
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
                      'Зміна номеру телефону',
                      style: darkBlueColor15SemiBoldTextStyle,
                    ),
                    heightSpace,
                    heightSpace,
                    TextField(
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.phone,
                      controller: changePhoneNumberController,
                      style: greyColor14SemiBoldTextStyle,
                      decoration: InputDecoration(
                        isDense: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                      ),
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
                                'Відміна',
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
                            onTap: () {
                              Navigator.pop(context);
                              phoneNumberController.text =
                                  changePhoneNumberController.text;
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
                                'Зберегти',
                                style: whiteColor15BoldTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  emailTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding,
        fixPadding * 2.0,
        fixPadding * 2.0,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () => changeEmail(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: fixPadding, vertical: 5.0),
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
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Email',
                  style: greyColor14SemiBoldTextStyle,
                ),
              ),
              Expanded(
                flex: 4,
                child: TextField(
                  enabled: false,
                  controller: emailController,
                  style: darkBlueColor14SemiBoldTextStyle,
                  decoration: InputDecoration(
                    isDense: true,
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: greyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  changeEmail() {
    showDialog(
      context: context,
      builder: (context) {
        changeEmailController.text = emailController.text;
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
                      'Зміна Email',
                      style: darkBlueColor15SemiBoldTextStyle,
                    ),
                    heightSpace,
                    heightSpace,
                    TextField(
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.emailAddress,
                      controller: changeEmailController,
                      style: greyColor14SemiBoldTextStyle,
                      decoration: InputDecoration(
                        isDense: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                      ),
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
                                'Відміна',
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
                            onTap: () {
                              Navigator.pop(context);
                              emailController.text = changeEmailController.text;
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
                                'Зберегти',
                                style: whiteColor15BoldTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  saveButton() {
    return Padding(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          _saveSettings();
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
