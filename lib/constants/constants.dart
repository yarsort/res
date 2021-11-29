import 'package:flutter/material.dart';
import 'dart:io';
import 'model.dart';

// Основные цвета программы
const Color primaryColor = Color.fromRGBO(255, 85, 0, 1.0);
const Color bgColor = Color(0xffF0F1F8);
const Color lightBlueColor = Color(0xffDEE2EB);
const Color darkBlueColor = Color(0xff022e4c);
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
const Color greyColor = Colors.grey;

// Отступы
const double fixPadding = 10.0;

// Разделение блоков
const SizedBox heightSpace = SizedBox(height: 5.0);
const SizedBox widthSpace = SizedBox(width: 5.0);

// Список бонусов покупателя
List<Bonus> globalListBonuses = [];

// Список заказов покупателя
List<OrderFromBase> globalListOrders = [];

// Список позиций заказа покупателя
List<OrderItemFromBase> globalListItemsOrder = [];

// Список позиций списка желаний
List<Item> globalListItemsFavourite = [];

// Список позиций корзины покупателя
List<Item> globalListItemsBasket = [];

// Тело картинки аватара покупателя в настройках. Не используеться пока-что...
File constImageAvatar;

// Путь к файлу аватара покупателя в настройках
var constAvatarUserPath = '';

// Штрихкод бонусной карты
var constBarcodeUser = '';

// Имя покупателя
var constNameUser = '';

// Номер телефона
var constPhoneNumber = '';

// Дата последнего обновления бонусов на форме
var dateLastUpdatingBonus = DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              DateTime.now().hour,
              DateTime.now().minute,
              DateTime.now().second);

// Дата следующего обновления бонусов на форме
var dateFutureUpdatingBonus = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute+5); // Плюс 5 минут для автоматического обновления

// Дата последнего обновления списка заказов на форме
var dateLastUpdatingOrders = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
    DateTime.now().second);

// Дата следующего обновления списка заказов на форме
var dateFutureUpdatingOrders = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute+5); // Плюс 5 минут для автоматического обновления

TextStyle darkBlueColor24SemiBoldTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 24,
  fontWeight: FontWeight.w600,
);

TextStyle darkBlueColor22BoldTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 22,
  fontWeight: FontWeight.w700,
);

TextStyle primaryColor22SemiBoldTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

TextStyle whiteColor20BoldTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 20,
  fontWeight: FontWeight.w700,
);

TextStyle darkBlueColor20BoldTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 20,
  fontWeight: FontWeight.w700,
);

TextStyle darkBlueColor20SemiBoldTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

TextStyle whiteColor18BoldTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

TextStyle darkBlueColor18SemiBoldTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

TextStyle darkBlueColor18MediumTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

TextStyle darkBlueColor17SemiBoldTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 17,
  fontWeight: FontWeight.w600,
);

TextStyle primaryColor18SemiBoldTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

TextStyle primaryColor16SemiBoldTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

TextStyle darkBlueColor16SemiBoldTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

TextStyle darkBlueColor16MediumTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

TextStyle greyColor22SemiBoldTextStyle = TextStyle(
  color: greyColor,
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

TextStyle greyColor17SemiBoldTextStyle = TextStyle(
  color: greyColor,
  fontSize: 17,
  fontWeight: FontWeight.w600,
);

TextStyle greyColor16SemiBoldTextStyle = TextStyle(
  color: greyColor,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

TextStyle greyColor16MediumTextStyle = TextStyle(
  color: greyColor,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

TextStyle greyColor16RegularTextStyle = TextStyle(
  color: greyColor,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

TextStyle greyColor15SemiBoldTextStyle = TextStyle(
  color: greyColor,
  fontSize: 15,
  fontWeight: FontWeight.w600,
);

TextStyle greyColor15MediumTextStyle = TextStyle(
  color: greyColor,
  fontSize: 15,
  fontWeight: FontWeight.w500,
);

TextStyle whiteColor15BoldTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 15,
  fontWeight: FontWeight.w700,
);

TextStyle whiteColor17BoldTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 17,
  fontWeight: FontWeight.w700,
);

TextStyle darkBlueColor15SemiBoldTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 15,
  fontWeight: FontWeight.w600,
);

TextStyle darkBlueColor15MediumTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 15,
  fontWeight: FontWeight.w500,
);

TextStyle primaryColor15SemiBoldTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 15,
  fontWeight: FontWeight.w600,
);

TextStyle primaryColor15BoldTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 15,
  fontWeight: FontWeight.w700,
);

TextStyle greyColor14MediumTextStyle = TextStyle(
  color: greyColor,
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

TextStyle greyColor14SemiBoldTextStyle = TextStyle(
  color: greyColor,
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

TextStyle darkBlueColor11SemiBoldTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 11,
  fontWeight: FontWeight.w600,
);

TextStyle darkBlueColor13SemiBoldTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 13,
  fontWeight: FontWeight.w600,
);

TextStyle darkBlueColor13MediumTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

TextStyle primaryColor12SemiBoldTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

TextStyle darkBlueColor12SemiBoldTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

TextStyle darkBlueColor12MediumTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

TextStyle greyColor13MediumTextStyle = TextStyle(
  color: greyColor,
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

TextStyle greyColor12MediumTextStyle = TextStyle(
  color: greyColor,
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

TextStyle greyColor11MediumTextStyle = TextStyle(
  color: greyColor,
  fontSize: 11,
  fontWeight: FontWeight.w500,
);

TextStyle darkBlueColor14MediumTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

TextStyle darkBlueColor14SemiBoldTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

TextStyle primaryColor13SemiBoldTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 13,
  fontWeight: FontWeight.w600,
);

TextStyle primaryColor14MediumTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

TextStyle primaryColor12MediumTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

TextStyle darkBlueColor13RegularTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 13,
  fontWeight: FontWeight.w400,
);

TextStyle greyColor13RegularTextStyle = TextStyle(
  color: greyColor,
  fontSize: 13,
  fontWeight: FontWeight.w400,
);

TextStyle greyColor11RegularTextStyle = TextStyle(
  color: greyColor,
  fontSize: 11,
  fontWeight: FontWeight.w400,
);

TextStyle blackColor11RegularTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 11,
  fontWeight: FontWeight.w400,
);

TextStyle primaryColor11SemiBoldTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 11,
  fontWeight: FontWeight.w600,
);

TextStyle primaryColor11MediumItalicTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 11,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.w500,
);

TextStyle greyColor10SemiBoldTextStyle = TextStyle(
  color: greyColor,
  fontSize: 10,
  fontWeight: FontWeight.w600,
);

TextStyle greyColor10MediumTextStyle = TextStyle(
  color: greyColor,
  fontSize: 10,
  fontWeight: FontWeight.w500,
);

TextStyle darkBlueColor9MediumTextStyle = TextStyle(
  color: darkBlueColor,
  fontSize: 9,
  fontWeight: FontWeight.w500,
);

TextStyle primaryColorColor9MediumTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 9,
  fontWeight: FontWeight.w500,
);

final constStoreList = [
  {
    'name': 'Магазин в місті Бершадь',
    'rating': '5.0',
    'ratedPeopleCount': '950',
    'address': 'Україна, м. Бершадь, вул. Юрія Коваленка 8',
    'phoneNumber': '+38(096)-208-59-59',
    'type': 'Новий',
  },
  {
    'name': 'Магазин в місті Калинівка',
    'rating': '5.0',
    'ratedPeopleCount': '698',
    'address': 'Україна, м. Калинівка, вул. Незалежності 42б',
    'phoneNumber': '+38(098)-323-30-30',
    'type': '',
  },
  {
    'name': 'Магазин в місті Козятин',
    'rating': '5.0',
    'ratedPeopleCount': '487',
    'address': 'Україна, м. Козятин, вул. Грушевського 23а',
    'phoneNumber': '+38(068)-605-95-90',
    'type': '',
  },
  {
    'name': 'Магазин в місті Липовець',
    'rating': '5.0',
    'ratedPeopleCount': '780',
    'address': 'Україна, м. Липовець, вул. Василя Липківського 32а',
    'phoneNumber': '+38(096)-045-75-75',
    'type': '',
  },
  {
    'name': 'Магазин в місті Хмільник',
    'rating': '5.0',
    'ratedPeopleCount': '950',
    'address': 'Україна, м. Хмільник, вул. Сиротюка 4',
    'phoneNumber': '+38(098)-808-08-90',
    'type': '',
  },
  {
    'name': 'Магазин в місті Немирів',
    'rating': '5.0',
    'ratedPeopleCount': '950',
    'address': 'Україна, м. Немирів, вул. Горького 88',
    'phoneNumber': '+38(096)-650-43-43',
    'type': '',
  },
  {
    'name': 'Магазин в місті Гайсин',
    'rating': '5.0',
    'ratedPeopleCount': '950',
    'address': 'Україна, м. Гайсин, вул. Івана Франка 80',
    'phoneNumber': '+38(096)-625-27-27',
    'type': '',
  },
  {
    'name': 'Магазин в місті Тульчин',
    'rating': '5.0',
    'ratedPeopleCount': '950',
    'address': 'Україна, м. Тульчин, вул. Миколи Леонтовича 60',
    'phoneNumber': '+38(098)-835-06-06',
    'type': '',
  },
  {
    'name': 'Магазин в місті Ладижин',
    'rating': '5.0',
    'ratedPeopleCount': '950',
    'address': 'Україна, м. Ладижин,  вул. Будівельників 15. (ТЦ Європейський. 1 поверх)',
    'phoneNumber': '+38(096)-235-17-17',
    'type': '',
  },

];