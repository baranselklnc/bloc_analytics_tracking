# BLoC Analytics Tracking

Bu proje, Medium'daki [ Flutter'da Firebase Analytics ile BLoC Event Takibi ](https://medium.com/@baranselklnc/flutterda-firebase-analytics-ile-bloc-event-takibi-bdba47d74b3a)  makalem için oluşturulmuş bir demo uygulamasıdır.

##  Proje Amacı

Bu demo, makalede detaylı olarak açıklanan **BLoC mimarisi ile Firebase Analytics entegrasyonunun avantajlarını** pratik olarak göstermek için oluşturulmuştur. Asıl odak noktası UI tasarımı değil, **BLoC event'leri ile analytics arasındaki doğal uyum** ve bu yaklaşımın sağladığı avantajlardır:

- **Event Bazlı Yapının Doğal Uyumu**: BLoC event'leri ile Firebase Analytics event'lerinin mükemmel eşleşmesi
- **Merkezi Event Loglama**: Tüm BLoC event'leri otomatik olarak analytics'e gönderilir
- **Temiz Kod**: UI'da hiç analytics kodu bulunmaz, tüm loglama BLoC Observer'da merkezi olarak yapılır
- **Test Edilebilirlik**: Mock servis ile test ortamında analytics izole edilebilir
- **Sürdürülebilirlik**: Tek bir yerden tüm analytics mantığı yönetilir

##  Proje Yapısı

```
lib/
├── core/
│   ├── bloc/
│   │   └── app_bloc_observer.dart      # Merkezi analytics loglama
│   ├── di/
│   │   └── service_locator.dart        # Dependency injection
│   ├── routing/
│   │   └── app_router.dart             # GoRouter yapılandırması
│   └── services/
│       └── analytics_service.dart      # Analytics servis soyutlaması
├── features/
│   ├── auth/
│   │   ├── bloc/
│   │   │   └── auth_bloc.dart          # Authentication BLoC
│   │   └── presentation/
│   │       └── pages/
│   │           └── login_page.dart     # Login sayfası
│   ├── home/
│   │   └── presentation/
│   │       └── pages/
│   │           └── home_page.dart      # Ana sayfa
│   └── shop/
│       ├── bloc/
│       │   └── shop_bloc.dart          # E-ticaret BLoC
│       └── presentation/
│           └── pages/
│               └── shop_page.dart      # E-ticaret sayfası
└── main.dart                           # Ana uygulama dosyası
```

##  Özellikler

### 1. Merkezi Analytics Loglama
- `AppBlocObserver` ile tüm BLoC event'leri otomatik olarak loglanır
- Event türüne göre özelleştirilmiş parametreler
- State geçişleri ve hatalar da loglanır

### 2. Servis Soyutlaması
- `AnalyticsService` abstract sınıfı ile test edilebilirlik
- `FirebaseAnalyticsService` ve `MockAnalyticsService` implementasyonları
- Dependency injection ile kolay servis değiştirme

### 3. Temiz Mimari
- BLoC pattern ile state management
- GoRouter ile navigation
- GetIt ile dependency injection
- Responsive design için flutter_screenutil

### 4. Test Edilebilirlik
- Mock servis ile test ortamında izole edilebilir
- BLoC testleri ile event'lerin doğru çalıştığını doğrulama
- Analytics çağrılarının doğru yapıldığını test etme

##  Demo Sayfaları

**Not**: Bu sayfalar sadece BLoC event'lerini tetiklemek ve analytics entegrasyonunu göstermek için oluşturulmuştur. UI tasarımı ikincil öneme sahiptir.

### Ana Sayfa
- Proje hakkında bilgi
- Demo sayfalarına yönlendirme
- BLoC Analytics entegrasyonu özellikleri

### Giriş Sayfası
- Email/şifre ile giriş (`LoginPressed` event'i tetikler)
- Kayıt olma (`SignUpPressed` event'i tetikler)
- Test kullanıcısı: `test@example.com` / `password`

### E-Ticaret Sayfası
- Ürün listesi (`ViewProductPressed` event'i tetikler)
- Sepete ekleme (`AddToCartPressed` event'i tetikler)
- Satın alma (`PurchasePressed` event'i tetikler)

##  Kurulum

1. Bağımlılıkları yükleyin:
```bash
flutter pub get
```

2. Mock sınıflarını oluşturun:
```bash
flutter packages pub run build_runner build
```

3. Firebase konfigürasyonu (opsiyonel):
   - Firebase Console'da yeni proje oluşturun
   - Android uygulaması ekleyin (package: `com.example.bloc_analytics_tracking`)
   - `google-services.json` dosyasını `android/app/` klasörüne koyun
   - Analytics'i etkinleştirin

4. Uygulamayı çalıştırın:
```bash
flutter run
```

**Not**: Firebase konfigürasyonu olmadan da Mock Analytics servisi ile çalışır.

##  Testler

Testleri çalıştırmak için:
```bash
flutter test
```

##  Analytics Event'leri

Uygulama çalıştığında aşağıdaki event'ler otomatik olarak loglanır:

### Authentication Events
- `login` - Kullanıcı girişi
- `sign_up` - Kullanıcı kaydı

### E-Commerce Events
- `add_to_cart` - Sepete ekleme
- `purchase` - Satın alma
- `view_product` - Ürün görüntüleme

### System Events
- `state_transition` - State geçişleri
- `bloc_error` - BLoC hataları

##  Firebase Analytics Entegrasyonu

Gerçek Firebase Analytics entegrasyonu için:

1. Firebase projesi oluşturun
2. `google-services.json` (Android) ve `GoogleService-Info.plist` (iOS) dosyalarını ekleyin
3. `FirebaseAnalyticsService` içindeki print ifadelerini gerçek Firebase çağrıları ile değiştirin:

```dart
@override
void logEvent(String name, {Map<String, dynamic>? parameters}) {
  FirebaseAnalytics.instance.logEvent(
    name: name,
    parameters: parameters,
  );
}
```

##  UI Özellikleri

**Not**: UI tasarımı bu projenin ana odak noktası değildir. Aşağıdaki özellikler sadece BLoC event'lerini tetiklemek ve analytics entegrasyonunu göstermek için minimal olarak uygulanmıştır:

- Material Design 3 (temel)
- Responsive tasarım (flutter_screenutil ile)
- Loading state'leri (BLoC state'lerini göstermek için)
- Error handling (BLoC error state'lerini göstermek için)
- Snackbar bildirimleri (event tetikleme sonuçlarını göstermek için)

##  Makale İle İlişki

Bu proje, [Medium'daki "Flutter'da Firebase Analytics ile BLoC Event Takibi" makalesinde]([https://medium.com/@baranselklnc/flutterda-firebase-analytics-ile-bloc-event-takibi](https://medium.com/@baranselklnc/flutterda-firebase-analytics-ile-bloc-event-takibi-bdba47d74b3a)) detaylı olarak açıklanan tüm kavramları pratik olarak gösterir:

### Makalede Bahsedilen Kavramlar:
- **Event Bazlı Yapının Doğal Uyumu**: BLoC event'leri ile Firebase Analytics'in mükemmel eşleşmesi
- **Merkezi ve Temiz Loglama**: `BlocObserver` ile tek noktadan tüm event'lerin loglanması
- **Parametre Loglama ve Servis Soyutlaması**: `AnalyticsService` ile test edilebilir yapı
- **Test Edilebilirlik Avantajları**: Mock servis ile izole test ortamı

### Makaledeki Kod Örnekleri:
Bu projede makalede verilen tüm kod örnekleri gerçek implementasyonlarla desteklenmiştir:
- `AppBlocObserver` sınıfı
- `AnalyticsService` abstract sınıfı ve implementasyonları
- BLoC event'leri ve parametre loglama
- Dependency injection yapısı


##  Lisans

Bu proje MIT lisansı altında lisanslanmıştır.

##  Yazar

**Baransel Kılınç**

- Medium: [Flutter'da Firebase Analytics ile BLoC Event Takibi](https://medium.com/@baranselklnc/flutterda-firebase-analytics-ile-bloc-event-takibi-bdba47d74b3a)
- LinkedIn: [Baransel Kılınç](https://www.linkedin.com/in/baransel-k%C4%B1l%C4%B1n%C3%A7/)

---

