import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/di/service_locator.dart';
import 'core/bloc/app_bloc_observer.dart';
import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase'i opsiyonel olarak initialize et
  try {
    await Firebase.initializeApp();
    print('✅ Firebase başarıyla initialize edildi');
  } catch (e) {
    print('⚠️ Firebase initialize edilemedi: $e');
    print('📱 Mock Analytics servisi kullanılacak');
  }
  
  // Dependency injection kurulumu
  setupServiceLocator();
  
  // BLoC Observer kurulumu
  Bloc.observer = getIt<AppBlocObserver>();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X tasarım boyutu
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'BLoC Analytics Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
