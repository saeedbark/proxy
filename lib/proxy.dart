import 'package:proxy/real_object.dart';
import 'package:proxy/subject.dart';

class ProxyInternet implements Internet {
  final RealInternet _realInternet = RealInternet();
  final List<String> _blockedSites = ["blockedsite.com", "example.com"];

  @override
  void connectTo(String website) {
    if (_blockedSites.contains(website.toLowerCase())) {
      print("Access to $website is blocked!");
    } else {
      _realInternet.connectTo(website);
    }
  }
}
