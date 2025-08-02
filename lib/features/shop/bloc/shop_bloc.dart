import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object?> get props => [];
}

class AddToCartPressed extends ShopEvent {
  final String itemId;
  final String itemName;
  final double price;

  const AddToCartPressed(this.itemId, this.itemName, this.price);

  @override
  List<Object?> get props => [itemId, itemName, price];
}

class PurchasePressed extends ShopEvent {
  final String transactionId;
  final double value;
  final String currency;

  const PurchasePressed(this.transactionId, this.value, this.currency);

  @override
  List<Object?> get props => [transactionId, value, currency];
}

class ViewProductPressed extends ShopEvent {
  final String productId;
  final String productName;

  const ViewProductPressed(this.productId, this.productName);

  @override
  List<Object?> get props => [productId, productName];
}

// States
abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object?> get props => [];
}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopSuccess extends ShopState {
  final String message;

  const ShopSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ShopFailure extends ShopState {
  final String message;

  const ShopFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitial()) {
    on<AddToCartPressed>(_onAddToCartPressed);
    on<PurchasePressed>(_onPurchasePressed);
    on<ViewProductPressed>(_onViewProductPressed);
  }

  Future<void> _onAddToCartPressed(
    AddToCartPressed event,
    Emitter<ShopState> emit,
  ) async {
    emit(ShopLoading());
    
    try {
      // Simüle edilmiş sepete ekleme işlemi
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ShopSuccess('${event.itemName} sepete eklendi'));
    } catch (e) {
      emit(ShopFailure(e.toString()));
    }
  }

  Future<void> _onPurchasePressed(
    PurchasePressed event,
    Emitter<ShopState> emit,
  ) async {
    emit(ShopLoading());
    
    try {
      // Simüle edilmiş satın alma işlemi
      await Future.delayed(const Duration(seconds: 1));
      emit(ShopSuccess('Satın alma başarılı: ${event.value} ${event.currency}'));
    } catch (e) {
      emit(ShopFailure(e.toString()));
    }
  }

  Future<void> _onViewProductPressed(
    ViewProductPressed event,
    Emitter<ShopState> emit,
  ) async {
    emit(ShopLoading());
    
    try {
      // Simüle edilmiş ürün görüntüleme işlemi
      await Future.delayed(const Duration(milliseconds: 200));
      emit(ShopSuccess('${event.productName} görüntülendi'));
    } catch (e) {
      emit(ShopFailure(e.toString()));
    }
  }
} 