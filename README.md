# proxy

The **Proxy Design Pattern** is a structural design pattern that provides a surrogate or placeholder for another object to control access to it. This pattern is particularly useful when you need to add an additional layer of functionality to an object without modifying its original code. Common use cases include lazy initialization, access control, logging, and caching.

## Key Concepts of Proxy Design Pattern

1. **Subject Interface**: An interface common to both the Real Subject and the Proxy. It defines the operations that can be performed.

2. **Real Subject**: The actual object that performs the core functionality.

3. **Proxy**: The surrogate that controls access to the Real Subject. It implements the same interface as the Real Subject and adds additional behavior.

## When to Use Proxy Pattern

- **Access Control**: Restrict access to certain functionalities or resources.
- **Lazy Initialization**: Delay the creation of expensive objects until they are needed.
- **Logging and Auditing**: Keep track of requests and operations performed on the Real Subject.
- **Caching**: Store results of expensive operations to improve performance.

## Example: Blocking Access to Certain Websites Using Proxy in Dart

Let's create a simple example where we have a `NetworkService` that fetches data from websites. We'll implement a `ProxyNetworkService` that controls access to certain blocked websites.

### Step 1: Define the Subject Interface

```dart
// network_service.dart

abstract class NetworkService {
  Future<String> fetchData(String url);
}
```

### Step 2: Implement the Real Subject

```dart
// real_network_service.dart

import 'network_service.dart';
import 'dart:async';

class RealNetworkService implements NetworkService {
  @override
  Future<String> fetchData(String url) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));
    return 'Data from $url';
  }
}
```

### Step 3: Implement the Proxy

```dart
// proxy_network_service.dart

import 'network_service.dart';
import 'real_network_service.dart';
import 'dart:async';

class ProxyNetworkService implements NetworkService {
  final RealNetworkService _realService = RealNetworkService();
  final List<String> _blockedSites = [
    'http://blockedsite.com',
    'http://anotherblocked.com',
  ];

  @override
  Future<String> fetchData(String url) async {
    if (_isBlocked(url)) {
      return 'Access to $url is blocked.';
    } else {
      return await _realService.fetchData(url);
    }
  }

  bool _isBlocked(String url) {
    return _blockedSites.contains(url.toLowerCase());
  }
}
```

### Step 4: Using the Proxy in Your Application

```dart
// main.dart

import 'proxy_network_service.dart';
import 'network_service.dart';

void main() async {
  NetworkService networkService = ProxyNetworkService();

  List<String> urlsToFetch = [
    'http://example.com',
    'http://blockedsite.com',
    'http://anotherblocked.com',
    'http://dartlang.org',
  ];

  for (String url in urlsToFetch) {
    String result = await networkService.fetchData(url);
    print(result);
  }
}
```

### Step 5: Running the Application

When you run the `main.dart`, the output will be:

```
Data from http://example.com
Access to http://blockedsite.com is blocked.
Access to http://anotherblocked.com is blocked.
Data from http://dartlang.org
```

## Explanation

1. **Subject Interface (`NetworkService`)**: Defines the `fetchData` method that both the real service and the proxy will implement.

2. **Real Subject (`RealNetworkService`)**: Implements the actual data fetching logic. In this example, it simulates a network delay and returns data from the provided URL.

3. **Proxy (`ProxyNetworkService`)**:
   - Contains a list of blocked sites.
   - Implements the same `fetchData` method.
   - Before delegating the request to the real service, it checks if the URL is in the blocked list.
   - If the site is blocked, it returns an access denied message instead of fetching the data.

4. **Client (`main.dart`)**:
   - Uses the `ProxyNetworkService` to fetch data from a list of URLs.
   - The proxy ensures that access to blocked sites is restricted.

## Advantages of Using Proxy Pattern in This Scenario

- **Access Control**: Easily manage and update the list of blocked sites without modifying the real network service.
- **Separation of Concerns**: Keeps the blocking logic separate from the actual data fetching logic.
- **Flexibility**: Additional proxy functionalities (e.g., logging, caching) can be added without altering the real service.

## Conclusion

The Proxy Design Pattern is a powerful tool for controlling access to objects and adding additional layers of functionality. In the Dart example above, the proxy effectively manages access to certain websites, demonstrating how this pattern can be applied to real-world scenarios.
