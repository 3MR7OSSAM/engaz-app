import 'package:engaz_task/app/features/menu/domain/models/vendor_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget displaying the restaurant header with background image and info.
class RestaurantHeaderWidget extends StatelessWidget {
  const RestaurantHeaderWidget({
    required this.vendorInfo,
    this.onBackPressed,
    this.onCartPressed,
    super.key,
  });

  final VendorInfo vendorInfo;
  final VoidCallback? onBackPressed;
  final VoidCallback? onCartPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background Image
        Container(
          height: 220,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                vendorInfo.fullCoverImageUrl.isEmpty
                    ? 'https://placehold.co/400x200/png'
                    : vendorInfo.fullCoverImageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: vendorInfo.fullCoverImageUrl.isEmpty
              ? null
              : Image.network(
                  vendorInfo.fullCoverImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.restaurant, size: 80),
                      ),
                    );
                  },
                ),
        ),

        /// Content
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 25,
          ),
          child: Column(
            children: [
              const SizedBox(height: 200),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 6,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _RestaurantInfo(vendorInfo: vendorInfo),
                    const SizedBox(height: 10),
                    const Divider(height: 1, color: Colors.grey),
                    const SizedBox(height: 10),
                    _InfoRow(vendorInfo: vendorInfo),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// App Bar (back + cart)
        Positioned(
          top: 40,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _AppBar(
              onBackPressed: onBackPressed,
              onCartPressed: onCartPressed,
            ),
          ),
        ),
      ],
    );
  }
}

/// Private widget for displaying the app bar with back and cart buttons.
class _AppBar extends StatelessWidget {
  const _AppBar({
    this.onBackPressed,
    this.onCartPressed,
  });

  final VoidCallback? onBackPressed;
  final VoidCallback? onCartPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Center(
            child: IconButton(
              padding: EdgeInsets.only(left: 6.w),
              onPressed: onBackPressed,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black45,
                size: 20,
              ),
            ),
          ),
        ),
        const Spacer(),
        Container(
          width: 40,
          height: 40,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: onBackPressed,
              icon: const Icon(
                Icons.shopping_cart_checkout_outlined,
                color: Colors.black45,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Private widget for displaying restaurant information.
class _RestaurantInfo extends StatelessWidget {
  const _RestaurantInfo({
    required this.vendorInfo,
  });

  final VendorInfo vendorInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Restaurant Logo
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: vendorInfo.fullLogoUrl.isEmpty
              ? Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[200],
                  child: const Icon(Icons.restaurant, size: 30),
                )
              : Image.network(
                  vendorInfo.fullLogoUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey[200],
                      child: const Icon(Icons.restaurant, size: 30),
                    );
                  },
                ),
        ),
        const SizedBox(width: 12),

        /// Name, branch, rating
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vendorInfo.vendorName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                vendorInfo.branchName,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '4.7',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Private widget for displaying restaurant info row.
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.vendorInfo,
  });

  final VendorInfo vendorInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _InfoItem(
          label: 'Delivery Fee',
          value: vendorInfo.isFreeDelivery
              ? 'Free'
              : '${vendorInfo.deliveryFee.toStringAsFixed(2)} EGP',
        ),
        _VerticalDivider(),
        _InfoItem(
          label: 'Delivery Time',
          value: vendorInfo.avgDeliveryTime,
        ),
        _VerticalDivider(),
        _InfoItem(
          label: 'For Calling',
          value: vendorInfo.phone,
        ),
      ],
    );
  }
}

/// Single info item.
class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black54, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

/// Vertical divider between info items
class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 25,
      color: Colors.grey.shade300,
    );
  }
}
