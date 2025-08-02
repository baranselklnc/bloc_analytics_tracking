import 'package:bloc/bloc.dart';
import '../services/analytics_service.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/shop/bloc/shop_bloc.dart';

class AppBlocObserver extends BlocObserver {
  final AnalyticsService analytics;

  AppBlocObserver(this.analytics);

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    
    // Event türüne göre özelleştirilmiş loglama
    if (event is LoginPressed) {
      analytics.logLogin(method: 'email');
    } else if (event is SignUpPressed) {
      analytics.logSignUp(method: 'email');
    } else if (event is AddToCartPressed) {
      analytics.logAddToCart(
        itemId: event.itemId,
        itemName: event.itemName,
        price: event.price,
      );
    } else if (event is PurchasePressed) {
      analytics.logPurchase(
        transactionId: event.transactionId,
        value: event.value,
        currency: event.currency,
      );
    } else if (event is ViewProductPressed) {
      analytics.logEvent(
        'view_product',
        parameters: {
          'product_id': event.productId,
          'product_name': event.productName,
        },
      );
    } else {
      // Genel event loglama
      analytics.logEvent(event.runtimeType.toString());
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    
    // State değişikliklerini de loglayabiliriz
    analytics.logEvent(
      'state_transition',
      parameters: {
        'bloc': bloc.runtimeType.toString(),
        'from': transition.currentState.runtimeType.toString(),
        'to': transition.nextState.runtimeType.toString(),
      },
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    
    // Hataları da loglayalım
    analytics.logEvent(
      'bloc_error',
      parameters: {
        'bloc': bloc.runtimeType.toString(),
        'error': error.toString(),
      },
    );
  }
} 