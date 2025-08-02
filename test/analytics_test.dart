import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_analytics_tracking/features/auth/bloc/auth_bloc.dart';
import 'package:bloc_analytics_tracking/features/shop/bloc/shop_bloc.dart';
import 'package:bloc_analytics_tracking/core/services/analytics_service.dart';

void main() {
  group('Analytics Integration Tests', () {
    group('AuthBloc Analytics Tests', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthSuccess] when LoginPressed is added and login is successful',
        build: () => AuthBloc(),
        act: (bloc) => bloc.add(const LoginPressed('test@example.com', 'password')),
        wait: const Duration(seconds: 2),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthSuccess>(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthFailure] when LoginPressed is added with invalid credentials',
        build: () => AuthBloc(),
        act: (bloc) => bloc.add(const LoginPressed('invalid@example.com', 'wrong')),
        wait: const Duration(seconds: 2),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthFailure>(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthSuccess] when SignUpPressed is added with valid data',
        build: () => AuthBloc(),
        act: (bloc) => bloc.add(const SignUpPressed('new@example.com', 'password123')),
        wait: const Duration(seconds: 2),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthSuccess>(),
        ],
      );
    });

    group('ShopBloc Analytics Tests', () {
      blocTest<ShopBloc, ShopState>(
        'emits [ShopLoading, ShopSuccess] when AddToCartPressed is added',
        build: () => ShopBloc(),
        act: (bloc) => bloc.add(const AddToCartPressed('product_1', 'Ürün 1', 99.99)),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          isA<ShopLoading>(),
          isA<ShopSuccess>(),
        ],
      );

      blocTest<ShopBloc, ShopState>(
        'emits [ShopLoading, ShopSuccess] when PurchasePressed is added',
        build: () => ShopBloc(),
        act: (bloc) => bloc.add(const PurchasePressed('transaction_123', 449.97, 'TRY')),
        wait: const Duration(seconds: 2),
        expect: () => [
          isA<ShopLoading>(),
          isA<ShopSuccess>(),
        ],
      );

      blocTest<ShopBloc, ShopState>(
        'emits [ShopLoading, ShopSuccess] when ViewProductPressed is added',
        build: () => ShopBloc(),
        act: (bloc) => bloc.add(const ViewProductPressed('product_1', 'Ürün 1')),
        wait: const Duration(milliseconds: 300),
        expect: () => [
          isA<ShopLoading>(),
          isA<ShopSuccess>(),
        ],
      );
    });

    group('MockAnalyticsService Tests', () {
      test('should log events and store them in memory', () {
        final mockService = MockAnalyticsService();
        
        // Event loglama
        mockService.logEvent('test_event', parameters: {'key': 'value'});
        mockService.logLogin(method: 'email');
        mockService.logAddToCart(itemId: 'product_1', itemName: 'Test Product', price: 99.99);
        
        // Events listesini kontrol et
        expect(mockService.events.length, 3);
        expect(mockService.events[0]['name'], 'test_event');
        expect(mockService.events[1]['name'], 'login');
        expect(mockService.events[2]['name'], 'add_to_cart');
      });

      test('should clear events when clearEvents is called', () {
        final mockService = MockAnalyticsService();
        
        mockService.logEvent('test_event');
        expect(mockService.events.length, 1);
        
        mockService.clearEvents();
        expect(mockService.events.length, 0);
      });
    });
  });
} 