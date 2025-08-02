import 'package:firebase_analytics/firebase_analytics.dart';

abstract class AnalyticsService {
  void logEvent(String name, {Map<String, dynamic>? parameters});
  void logLogin({String? method});
  void logSignUp({String? method});
  void logAddToCart({String? itemId, String? itemName, double? price});
  void logPurchase({String? transactionId, double? value, String? currency});
}

class FirebaseAnalyticsService implements AnalyticsService {
  @override
  void logEvent(String name, {Map<String, dynamic>? parameters}) {
    // Gerçek Firebase Analytics entegrasyonu
    FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: parameters,
    );
    
    // Debug için print (production'da kaldırılabilir)
    print('📊 Analytics Event: $name');
    if (parameters != null) {
      print('📊 Parameters: $parameters');
    }
  }

  @override
  void logLogin({String? method}) {
    logEvent('login', parameters: {
      'method': method ?? 'email',
    });
  }

  @override
  void logSignUp({String? method}) {
    logEvent('sign_up', parameters: {
      'method': method ?? 'email',
    });
  }

  @override
  void logAddToCart({String? itemId, String? itemName, double? price}) {
    logEvent('add_to_cart', parameters: {
      'item_id': itemId,
      'item_name': itemName,
      'price': price,
    });
  }

  @override
  void logPurchase({String? transactionId, double? value, String? currency}) {
    logEvent('purchase', parameters: {
      'transaction_id': transactionId,
      'value': value,
      'currency': currency ?? 'TRY',
    });
  }
}

class MockAnalyticsService implements AnalyticsService {
  final List<Map<String, dynamic>> _events = [];

  List<Map<String, dynamic>> get events => _events;

  @override
  void logEvent(String name, {Map<String, dynamic>? parameters}) {
    _events.add({
      'name': name,
      'parameters': parameters,
      'timestamp': DateTime.now(),
    });
    print('🧪 Mock Analytics Event: $name');
    if (parameters != null) {
      print('🧪 Parameters: $parameters');
    }
  }

  @override
  void logLogin({String? method}) {
    logEvent('login', parameters: {
      'method': method ?? 'email',
    });
  }

  @override
  void logSignUp({String? method}) {
    logEvent('sign_up', parameters: {
      'method': method ?? 'email',
    });
  }

  @override
  void logAddToCart({String? itemId, String? itemName, double? price}) {
    logEvent('add_to_cart', parameters: {
      'item_id': itemId,
      'item_name': itemName,
      'price': price,
    });
  }

  @override
  void logPurchase({String? transactionId, double? value, String? currency}) {
    logEvent('purchase', parameters: {
      'transaction_id': transactionId,
      'value': value,
      'currency': currency ?? 'TRY',
    });
  }

  void clearEvents() {
    _events.clear();
  }
} 