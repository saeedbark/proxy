import 'package:proxy/proxy.dart';
import 'package:proxy/subject.dart';

void main() {
  Internet internet = ProxyInternet();

  // محاولات للاتصال بمواقع مختلفة
  internet.connectTo("google.com");     // مسموح
  internet.connectTo("blockedsite.com"); // محظور
  internet.connectTo("stackoverflow.com"); // مسموح
  internet.connectTo("example.com");     // محظور
}
