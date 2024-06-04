import 'package:data_visualization_b5/widgets/image_header_item_widget.dart';
import 'package:data_visualization_b5/widgets/team_member_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LandingProvider with ChangeNotifier {
  int _currentPageIndexHeader = 0;
  int get currentPageIndexHeader => _currentPageIndexHeader;
  int _currentPageIndexTeamMember = 0;
  int get currentPageIndexTeamMember => _currentPageIndexTeamMember;
  String _pathPlaneImage = "";
  String get pathPlaneImage => _pathPlaneImage;
  String _pathAirlineSVG = "";
  String get pathAirlineSVG => _pathAirlineSVG;
  final List<Widget> _imageHeader = const [
    ImageHeaderItemWidget(
      pathImage: "assets/jpeg/mountain.jpeg",
      caption: "Visualisasi Data Tiket.com\noleh B5",
    ),
    ImageHeaderItemWidget(
      pathImage: "assets/jpeg/beach.jpeg",
      caption: "Sangat Interaktif",
    ),
    ImageHeaderItemWidget(
      pathImage: "assets/jpeg/city.jpeg",
      caption: "Pastinya Informatif",
    ),
    ImageHeaderItemWidget(
      pathImage: "assets/jpeg/florest.jpeg",
      caption: "Dan Responsif",
    ),
  ];
  List<Widget> get imageHeader => _imageHeader;
  final List<Widget> _imageMemberTeam = const [
    TeamMemberCardWidget(member: "astria-revisi"),
    TeamMemberCardWidget(member: "fanja"),
    TeamMemberCardWidget(member: "jelang"),
    TeamMemberCardWidget(member: "ikis"),
    TeamMemberCardWidget(member: "upiw"),
  ];
  List<Widget> get imageMemberTeam => _imageMemberTeam;
  String? _currentDateFormatted;
  String? get currentDateFormatted => _currentDateFormatted;
  String? _selectedDateFormatted;
  String? get selectedDateFormatted => _selectedDateFormatted;
  String? _selectedAirline;
  String? get selectedAirline => _selectedAirline;

  setPathPlaneImage(String value) {
    switch (value) {
      case "Batik Air Indonesia":
        _pathPlaneImage = "assets/png/batik-air-plane.png";
        break;
      case "Citilink":
        _pathPlaneImage = "assets/jpg/citilink-plane.jpg";
        break;
      case "Lion Air":
        _pathPlaneImage = "assets/jpg/lion-air-plane.jpg";
        break;
      case "Garuda Indonesia":
        _pathPlaneImage = "assets/jpeg/garuda-indonesia-plane.jpeg";
        break;
      case "Pelita Air":
        _pathPlaneImage = "assets/jpg/pelita-air-plane.jpg";
        break;
      case "Nam Air":
        _pathPlaneImage = "assets/jpg/nam-air-plane.jpg";
        break;
      case "Super Air Jet":
        _pathPlaneImage = "assets/jpg/super-air-jet-plane.jpg";
        break;
      default:
        _pathPlaneImage = "assets/png/airplane.png";
        break;
    }
    notifyListeners();
  }

  setAvatarAirlines() {
    switch (_selectedAirline) {
      case "Batik Air Indonesia":
        _pathAirlineSVG = "batik-air";
        break;
      case "Citilink":
        _pathAirlineSVG = "citilink";
        break;
      case "Lion Air":
        _pathAirlineSVG = "lion-air";
        break;
      case "Garuda Indonesia":
        _pathAirlineSVG = "garuda-indonesia";
        break;
      case "Pelita Air":
        _pathAirlineSVG = "pelita-air";
        break;
      case "Nam Air":
        _pathAirlineSVG = "nam-air";
        break;
      case "Super Air Jet":
        _pathAirlineSVG = "super-air-jet";
        break;
      default:
        _pathAirlineSVG = "batik-air";
        break;
    }
    notifyListeners();
  }

  setCurrentPageIndexHeader(int value) {
    _currentPageIndexHeader = value;
    notifyListeners();
  }

  setCurrentPageIndexTeamMember(int value) {
    _currentPageIndexTeamMember = value;
    notifyListeners();
  }

  setSelectedAirline(String value) {
    _selectedAirline = value;
    notifyListeners();
  }

  setCurrentDate() {
    var formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _currentDateFormatted = formattedDate;
    notifyListeners();
  }

  setSelectedDate(DateTime? value) {
    var formattedDate = DateFormat('yyyy-MM-dd').format(value!);
    _selectedDateFormatted = formattedDate;
    notifyListeners();
  }
}
