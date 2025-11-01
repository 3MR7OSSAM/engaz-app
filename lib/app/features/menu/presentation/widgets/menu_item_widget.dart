import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../domain/models/product.dart';

/// Widget displaying a single menu item card.
class MenuItemWidget extends StatelessWidget {
  /// Creates a [MenuItemWidget].
  const MenuItemWidget({
    required this.product,
    this.onTap,
    super.key,
  });

  /// The product to display.
  final Product product;

  /// Callback when the item is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _ItemInfo(product: product),
            ),
            const SizedBox(width: 10),
            _ItemImageCarousel(product: product),
          ],
        ),
      ),
    );
  }
}

/// Private widget for displaying menu item information.
class _ItemInfo extends StatelessWidget {
  const _ItemInfo({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          product.description,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        _PriceInfo(product: product),
      ],
    );
  }
}

/// Private widget for displaying price information with discount.
class _PriceInfo extends StatelessWidget {
  const _PriceInfo({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    if (product.hasDiscount) {
      return Row(
        children: [
          Text(
            '${product.finalPrice.toStringAsFixed(2)} EGP',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${product.price.toStringAsFixed(2)} EGP',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      );
    }

    return Text(
      '${product.price.toStringAsFixed(2)} EGP',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

/// Private widget for displaying product image carousel.
class _ItemImageCarousel extends StatefulWidget {
  const _ItemImageCarousel({
    required this.product,
  });

  final Product product;

  @override
  State<_ItemImageCarousel> createState() => _ItemImageCarouselState();
}

class _ItemImageCarouselState extends State<_ItemImageCarousel> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasImages = widget.product.images.isNotEmpty;

    if (!hasImages) {
      return _buildPlaceholder();
    }

    if (widget.product.images.length == 1) {
      return _buildSingleImage();
    }

    return _buildCarousel();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: const Icon(
        Icons.fastfood,
        size: 45,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildSingleImage() {
    return Stack(
      children: [
        _buildImageContainer(widget.product.images.first.fullImageUrl),
        if (widget.product.hasDiscount) _buildDiscountBadge(),
      ],
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 90,
              viewportFraction: 1.0,
              enableInfiniteScroll: widget.product.images.length > 1,
              autoPlay: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
            ),
            items: widget.product.images.map((image) {
              return _buildImageContainer(image.fullImageUrl);
            }).toList(),
          ),
          if (widget.product.hasDiscount) _buildDiscountBadge(),
          _buildCarouselIndicator(),
        ],
      ),
    );
  }

  Widget _buildImageContainer(String imageUrl) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.fastfood,
              size: 45,
              color: Colors.grey,
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                strokeWidth: 2,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDiscountBadge() {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(12),
          ),
        ),
        child: Text(
          '${widget.product.discountPercentage.toInt()}% OFF',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselIndicator() {
    return Positioned(
      bottom: 4,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.product.images.asMap().entries.map((entry) {
          return Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentImageIndex == entry.key
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.5),
            ),
          );
        }).toList(),
      ),
    );
  }
}
