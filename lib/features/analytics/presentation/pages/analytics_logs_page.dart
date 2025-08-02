import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/analytics_service.dart';

class AnalyticsLogsPage extends StatefulWidget {
  const AnalyticsLogsPage({super.key});

  @override
  State<AnalyticsLogsPage> createState() => _AnalyticsLogsPageState();
}

class _AnalyticsLogsPageState extends State<AnalyticsLogsPage> {
  final List<String> _logs = [];
  late final MockAnalyticsService _mockService;

  @override
  void initState() {
    super.initState();
    _mockService = MockAnalyticsService();
    _addLog('Analytics Logs sayfası açıldı');
  }

  void _addLog(String message) {
    setState(() {
      _logs.add('${DateTime.now().toString().substring(11, 19)}: $message');
    });
  }

  void _testAnalyticsEvents() {
    _addLog('Test analytics event\'leri başlatılıyor...');
    
    // Test event'leri
    _mockService.logEvent('test_event', parameters: {'test': 'value'});
    _addLog('📊 Test event loglandı');
    
    _mockService.logLogin(method: 'email');
    _addLog('📊 Login event loglandı');
    
    _mockService.logAddToCart(
      itemId: 'test_product',
      itemName: 'Test Ürün',
      price: 99.99,
    );
    _addLog('📊 Add to cart event loglandı');
    
    _mockService.logPurchase(
      transactionId: 'test_transaction',
      value: 199.98,
      currency: 'TRY',
    );
    _addLog('📊 Purchase event loglandı');
  }

  void _clearLogs() {
    setState(() {
      _logs.clear();
      _mockService.clearEvents();
    });
    _addLog('Loglar temizlendi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Logları'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _clearLogs,
            icon: const Icon(Icons.clear_all),
            tooltip: 'Logları Temizle',
          ),
        ],
      ),
      body: Column(
        children: [
          // Kontrol paneli
          Container(
            padding: EdgeInsets.all(16.w),
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Column(
              children: [
                Text(
                  'Analytics Test Paneli',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _testAnalyticsEvents,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Test Event\'leri'),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => context.go('/'),
                        icon: const Icon(Icons.home),
                        label: const Text('Ana Sayfa'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Log listesi
          Expanded(
            child: _logs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.analytics_outlined,
                          size: 64.w,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Henüz log yok',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Test event\'lerini çalıştırarak logları görebilirsiniz',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: _logs.length,
                    itemBuilder: (context, index) {
                      final log = _logs[index];
                      final isAnalyticsEvent = log.contains('📊');
                      
                      return Card(
                        margin: EdgeInsets.only(bottom: 8.h),
                        color: isAnalyticsEvent
                            ? Colors.blue.withOpacity(0.1)
                            : null,
                        child: ListTile(
                          leading: Icon(
                            isAnalyticsEvent ? Icons.analytics : Icons.info,
                            color: isAnalyticsEvent ? Colors.blue : Colors.grey,
                          ),
                          title: Text(
                            log,
                            style: TextStyle(
                              fontWeight: isAnalyticsEvent
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          
          // İstatistikler
          if (_logs.isNotEmpty)
            Container(
              padding: EdgeInsets.all(16.w),
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Toplam Log: ${_logs.length}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    'Analytics Event: ${_logs.where((log) => log.contains('📊')).length}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.blue,
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