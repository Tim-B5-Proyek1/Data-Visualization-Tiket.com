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
  final List<Widget> _imageHeader = const [
    ImageHeaderItemWidget(pathImage: "assets/jpeg/mountain.jpeg"),
    ImageHeaderItemWidget(pathImage: "assets/jpeg/beach.jpeg"),
    ImageHeaderItemWidget(pathImage: "assets/jpeg/city.jpeg"),
    ImageHeaderItemWidget(pathImage: "assets/jpeg/florest.jpeg"),
  ];
  List<Widget> get imageHeader => _imageHeader;
  final List<Widget> _imageMemberTeam = const [
    TeamMemberCardWidget(member: "astria"),
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
    if (value == "Batik Air") {
      _pathPlaneImage = "assets/png/batik-air-plane.png";
      notifyListeners();
    } else if (value == "Citilink") {
      _pathPlaneImage = "assets/jpg/citilink-plane.jpg";
      notifyListeners();
    } else if (value == "Lion Air") {
      _pathPlaneImage = "assets/jpg/lion-air-plane.jpg";
      notifyListeners();
    } else if (value == "Garuda Indonesia") {
      _pathPlaneImage = "assets/jpeg/garuda-indonesia-plane.jpeg";
      notifyListeners();
    } else if (value == "Pelita Air") {
      _pathPlaneImage = "assets/jpg/pelita-air-plane.jpg";
      notifyListeners();
    } else if (value == "Nam Air") {
      _pathPlaneImage = "assets/jpg/nam-air-plane.jpg";
      notifyListeners();
    } else if (value == "Super Air Jet") {
      _pathPlaneImage = "assets/jpg/super-air-jet-plane.jpg";
      notifyListeners();
    } else {
      _pathPlaneImage = "assets/png/airplane.png";
      notifyListeners();
    }
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
