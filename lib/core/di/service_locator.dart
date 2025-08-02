import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import '../services/analytics_service.dart';
import '../bloc/app_bloc_observer.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Analytics Service - Firebase varsa gerçek, yoksa mock kullan
  try {
    // Firebase'in initialize edilip edilmediğini kontrol et
    Firebase.app();
    getIt.registerLazySingleton<AnalyticsService>(
      () => FirebaseAnalyticsService(),
    );
    print('📊 Firebase Analytics servisi kullanılıyor');
  } catch (e) {
    getIt.registerLazySingleton<AnalyticsService>(
      () => MockAnalyticsService(),
    );
    print('🧪 Mock Analytics servisi kullanılıyor');
  }

  // BLoC Observer
  getIt.registerLazySingleton<AppBlocObserver>(
    () => AppBlocObserver(getIt<AnalyticsService>()),
  );
}

// Test ortamı için mock servisleri kaydetme
void setupMockServices() {
  getIt.reset();
  
  getIt.registerLazySingleton<AnalyticsService>(
    () => MockAnalyticsService(),
  );

  getIt.registerLazySingleton<AppBlocObserver>(
    () => AppBlocObserver(getIt<AnalyticsService>()),
  );
} 