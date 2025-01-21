import 'package:proxy/subject.dart';

class RealInternet implements Internet {
  @override
  void connectTo(String website) {
    print("Connecting to $website...");
  }
}
