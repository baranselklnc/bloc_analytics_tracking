import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC Analytics Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Icon(
              Icons.analytics,
              size: 80.w,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 24.h),
            Text(
              'BLoC ile Firebase Analytics',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Text(
              'Bu demo, BLoC mimarisi ile Firebase Analytics entegrasyonunu göstermektedir. Tüm kullanıcı etkileşimleri otomatik olarak loglanır.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.go('/login'),
                icon: const Icon(Icons.login),
                label: const Text('Giriş Sayfası'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => context.go('/shop'),
                icon: const Icon(Icons.shopping_cart),
                label: const Text('E-Ticaret Sayfası'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => context.go('/analytics'),
                icon: const Icon(Icons.analytics),
                label: const Text('Analytics Logları'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
              ),
            ),
            SizedBox(height: 32.h),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    Text(
                      'Demo Özellikleri',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 16.h),
                    _buildFeatureItem(
                      context,
                      '✅ Merkezi Event Loglama',
                      'Tüm BLoC event\'leri otomatik olarak loglanır',
                    ),
                    _buildFeatureItem(
                      context,
                      '✅ Parametre Desteği',
                      'Event\'lere özel parametreler eklenebilir',
                    ),
                    _buildFeatureItem(
                      context,
                      '✅ Test Edilebilir',
                      'Mock servis ile test ortamında izole edilebilir',
                    ),
                    _buildFeatureItem(
                      context,
                      '✅ Temiz Kod',
                      'UI\'da hiç analytics kodu yok',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 