import 'package:data_visualization_b5/providers/landing_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

double defaultPadding = 20;
double defaultBorderRadius = 15;

// String baseAPIURL() {
//   return "https://data-b90c8-default-rtdb.firebaseio.com/scrapping/maskapai.json";
// }

String baseAPIURL() {
  return "https://data-b90c8-default-rtdb.firebaseio.com/scrapping/data.json";
}

Map<String, String> header(
  bool isNeedToken, {
  String? token,
}) {
  if (isNeedToken == true) {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  } else {
    return {
      'Accept': 'application/json',
    };
  }
}

showSnackBar(
  BuildContext context,
  String message,
  Color color,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        message,
        style: primaryTextStyle.copyWith(
          color: white,
        ),
      ),
    ),
  );
}

Map<String, String> headerMultipart(
  bool isNeedToken, {
  String? token,
}) {
  if (isNeedToken == true) {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };
  } else {
    return {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
    };
  }
}

String cuttedName(String name) {
  if (name.contains(" ")) {
    return name.substring(0, name.indexOf(" "));
  } else {
    return name;
  }
}

selectDate(BuildContext context, LandingProvider landingProvider) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    firstDate: DateTime.parse("2024-06-01 12:14:18.211"),
    lastDate: DateTime.parse("2025-06-01 12:14:18.211"),
    // DateTime.parse("2025"),
  );

  if (selectedDate != null) {
    landingProvider.setSelectedDate(selectedDate);
  }
}

String formatCurrency(var currency) {
  final initialData = NumberFormat("#,##0", "id");
  String currentData = initialData.format(currency);
  return currentData;
}

String formatWaktu(bool isTanggal, {DateTime? tanggal}) {
  final DateFormat formatterTanggal = DateFormat('dd MMMM yyyy', 'id');
  final DateFormat formatterJam = DateFormat('HH.mm');
  String formattedDate = "";

  if (isTanggal) {
    formattedDate =
        formatterTanggal.format(tanggal!.add(const Duration(hours: 7)));

    return formattedDate;
  } else {
    formattedDate = formatterJam.format(tanggal!.add(const Duration(hours: 7)));

    return formattedDate;
  }
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

bool keyboardIsOpen(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom != 0;
}

Color primaryColor = const Color(0xFF007CFF);
Color secondaryColor = const Color(0xFF35405A);
Color backgroundColor = const Color(0xFFF5F6FA);
Color sionYellowColor = const Color(0xffFFD600);
Color tertiary500 = const Color(0xFF2632ff);
Color tertiary400 = const Color(0xFF6569ff);
Color tertiary300 = const Color(0xFF9597FF);
Color grey700 = const Color(0xFF111114);
Color grey600 = const Color(0xFF2b2b30);
Color grey500 = const Color(0xFF4b4b53);
Color grey400 = const Color(0xFF6d6d75);
Color black = const Color(0xFF000000);
Color white = const Color(0xFFFFFFFF);

BoxShadow primaryShadow = BoxShadow(
  blurRadius: 5,
  color: grey400.withOpacity(0.3),
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: white,
  fontWeight: regular,
);

TextStyle secondaryTextStyle = GoogleFonts.poppins(
  color: black,
  fontWeight: regular,
);

TextStyle eduPelitaTextStyle = GoogleFonts.comfortaa(
  color: black,
  fontWeight: regular,
);
