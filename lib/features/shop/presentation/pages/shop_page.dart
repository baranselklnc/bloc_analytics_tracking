import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/shop_bloc.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Ticaret Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocListener<ShopBloc, ShopState>(
        listener: (context, state) {
          if (state is ShopSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is ShopFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ürünler',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView(
                  children: [
                    _buildProductCard(
                      context,
                      'Ürün 1',
                      'Bu harika bir ürün!',
                      99.99,
                      'product_1',
                    ),
                    SizedBox(height: 16.h),
                    _buildProductCard(
                      context,
                      'Ürün 2',
                      'İkinci harika ürün!',
                      149.99,
                      'product_2',
                    ),
                    SizedBox(height: 16.h),
                    _buildProductCard(
                      context,
                      'Ürün 3',
                      'Üçüncü harika ürün!',
                      199.99,
                      'product_3',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              BlocBuilder<ShopBloc, ShopState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state is ShopLoading
                          ? null
                          : () {
                              context.read<ShopBloc>().add(
                                    const PurchasePressed(
                                      'transaction_123',
                                      449.97,
                                      'TRY',
                                    ),
                                  );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      child: state is ShopLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Tümünü Satın Al (449.97 TL)'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    String name,
    String description,
    double price,
    String productId,
  ) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8.h),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 8.h),
            Text(
              '${price.toStringAsFixed(2)} TL',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<ShopBloc>().add(
                            ViewProductPressed(productId, name),
                          );
                    },
                    child: const Text('Görüntüle'),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: BlocBuilder<ShopBloc, ShopState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is ShopLoading
                            ? null
                            : () {
                                context.read<ShopBloc>().add(
                                      AddToCartPressed(
                                        productId,
                                        name,
                                        price,
                                      ),
                                    );
                              },
                        child: const Text('Sepete Ekle'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 