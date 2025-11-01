import 'package:engaz_task/app/core/injection/injection.dart';
import 'package:engaz_task/app/features/restaurants/presentation/cubit/restaurant_cubit.dart';
import 'package:engaz_task/app/features/restaurants/presentation/cubit/restaurant_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Example page demonstrating RestaurantCubit usage.
/// Shows how to integrate the Cubit with BlocBuilder and handle different states.
class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RestaurantCubit>()
        ..fetchRestaurants(
          latitude: 30.0444,
          longitude: 31.2357,
        ),
      child: const RestaurantListView(),
    );
  }
}

/// The main view that listens to RestaurantCubit state changes.
class RestaurantListView extends StatelessWidget {
  const RestaurantListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
        actions: [
          // Filter button
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<RestaurantCubit>().refreshRestaurants(
                    latitude: 30.0444,
                    longitude: 31.2357,
                  );
            },
          ),
        ],
      ),
      body: BlocConsumer<RestaurantCubit, RestaurantState>(
        listener: (context, state) {
          // Handle error states with SnackBar
          if (state is RestaurantError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: () {
                    context.read<RestaurantCubit>().refreshRestaurants(
                          latitude: 30.0444,
                          longitude: 31.2357,
                        );
                  },
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return switch (state) {
            RestaurantInitial() => const Center(
                child: Text('Ready to load restaurants'),
              ),
            RestaurantLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            RestaurantSuccess() => _buildSuccessView(context, state),
            RestaurantLoadingMore() => _buildLoadingMoreView(context, state),
            RestaurantError() => _buildErrorView(context, state),
            RestaurantEmpty() => _buildEmptyView(context, state),
          };
        },
      ),
    );
  }

  Widget _buildSuccessView(BuildContext context, RestaurantSuccess state) {
    return RefreshIndicator(
      onRefresh: () => context.read<RestaurantCubit>().refreshRestaurants(
            latitude: 30.0444,
            longitude: 31.2357,
          ),
      child: Column(
        children: [
          // Pagination info
          Container(
            padding: const EdgeInsets.all(8),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Page ${state.pagination.currentPage} of ${state.pagination.totalPages}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Total: ${state.pagination.totalBranches} branches',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          // List of branches
          Expanded(
            child: ListView.builder(
              itemCount: state.branches.length +
                  (state.pagination.hasNextPage ? 1 : 0),
              itemBuilder: (context, index) {
                // Load more indicator
                if (index == state.branches.length) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.read<RestaurantCubit>().loadMoreRestaurants(
                                latitude: 30.0444,
                                longitude: 31.2357,
                              );
                        },
                        icon: const Icon(Icons.arrow_downward),
                        label: const Text('Load More'),
                      ),
                    ),
                  );
                }

                final branch = state.branches[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://dealsapps.net/DealsAppData/DealsUsers/${branch.logoUrl}',
                      ),
                      onBackgroundImageError: (_, __) {},
                      child: const Icon(Icons.restaurant),
                    ),
                    title: Text(
                      branch.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${branch.vendorName} - ${branch.cityName}'),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text('${branch.rating} (${branch.ratingsCount})'),
                            const SizedBox(width: 16),
                            const Icon(Icons.location_on, size: 16),
                            const SizedBox(width: 4),
                            Text('${branch.distance.toStringAsFixed(2)} km'),
                          ],
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (branch.isFreeDelivery)
                          const Chip(
                            label: Text('Free', style: TextStyle(fontSize: 10)),
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.zero,
                          )
                        else
                          Text(
                            '${branch.deliveryFee} EGP',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        Text(
                          '${branch.avgDeliveryTime} min',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingMoreView(
    BuildContext context,
    RestaurantLoadingMore state,
  ) {
    return Column(
      children: [
        // Show current data
        Expanded(
          child: ListView.builder(
            itemCount: state.currentBranches.length,
            itemBuilder: (context, index) {
              final branch = state.currentBranches[index];
              return ListTile(
                leading: const Icon(Icons.restaurant),
                title: Text(branch.name),
                subtitle: Text(branch.vendorName),
              );
            },
          ),
        ),
        // Loading indicator at bottom
        Container(
          padding: const EdgeInsets.all(16),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Loading more...'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorView(BuildContext context, RestaurantError state) {
    // If we have previous data, show it with an error message
    if (state.previousBranches != null && state.previousBranches!.isNotEmpty) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.red.shade100,
            child: Row(
              children: [
                const Icon(Icons.error, color: Colors.red),
                const SizedBox(width: 8),
                Expanded(child: Text(state.message)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: state.previousBranches!.length,
              itemBuilder: (context, index) {
                final branch = state.previousBranches![index];
                return ListTile(
                  leading: const Icon(Icons.restaurant),
                  title: Text(branch.name),
                  subtitle: Text(branch.vendorName),
                );
              },
            ),
          ),
        ],
      );
    }

    // No previous data, show full error screen
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              state.message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<RestaurantCubit>().refreshRestaurants(
                    latitude: 30.0444,
                    longitude: 31.2357,
                  );
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context, RestaurantEmpty state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.restaurant_menu, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'No Restaurants',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              state.message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<RestaurantCubit>().resetFilters();
            },
            icon: const Icon(Icons.clear),
            label: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Filter Restaurants'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Free Delivery Only'),
              leading: const Icon(Icons.delivery_dining),
              onTap: () {
                context.read<RestaurantCubit>().filterByFreeDelivery();
                Navigator.pop(dialogContext);
              },
            ),
            ListTile(
              title: const Text('Rating ≥ 4.0'),
              leading: const Icon(Icons.star),
              onTap: () {
                context.read<RestaurantCubit>().filterByMinRating(4.0);
                Navigator.pop(dialogContext);
              },
            ),
            ListTile(
              title: const Text('Reset Filters'),
              leading: const Icon(Icons.clear),
              onTap: () {
                context.read<RestaurantCubit>().resetFilters();
                Navigator.pop(dialogContext);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
