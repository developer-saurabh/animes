import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/size_constants.dart';
import '../../../core/constants/asset_constants.dart';
import '../../../widgets/common_bottom_nav_bar.dart';
import '../../../routes/route_names.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final int _currentIndex = 1;

  bool _isLoading = true;
  String _query = '';

  // Dummy data (later replace with API response)
  final List<String> _animeList = [
    'Frieren: Beyond Journey',
    'One Piece Fan Letter',
    'Fullmetal Alchemist',
    'Steins;Gate',
    'Attack on Titan',
    'Gintama Season 4',
    'Solo Leveling',
    'One Punch Man',
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;

    if (index == 0) {
      Navigator.pushReplacementNamed(context, RouteNames.home);
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, RouteNames.newReleases);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: _isLoading ? _shimmerView() : _contentView()),
      bottomNavigationBar: CommonBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }

  // ================= CONTENT =================

  Widget _contentView() {
    final filteredList =
        _animeList
            .where(
              (anime) => anime.toLowerCase().contains(_query.toLowerCase()),
            )
            .toList();

    return Column(
      children: [_searchBar(), Expanded(child: _gridList(filteredList))],
    );
  }

  // ================= SEARCH BAR =================

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(SizeConstants.paddingMedium),
      child: TextField(
        style: const TextStyle(color: AppColors.textPrimary),
        onChanged: (value) {
          setState(() => _query = value);
        },
        decoration: InputDecoration(
          hintText: 'Search Anime',
          hintStyle: const TextStyle(color: AppColors.textSecondary),
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          filled: true,
          fillColor: AppColors.cardBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(SizeConstants.borderRadius),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ================= GRID =================

  Widget _gridList(List<String> list) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: SizeConstants.paddingMedium,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.animeDetail);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    SizeConstants.borderRadius,
                  ),
                  child: Image.network(
                    AssetConstants.animePoster,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                list[index],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ================= SHIMMER =================

  Widget _shimmerView() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(SizeConstants.paddingMedium),
            child: Container(
              height: 50,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeConstants.paddingMedium,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
              itemCount: 6,
              itemBuilder: (_, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Container(color: Colors.white)),
                    const SizedBox(height: 6),
                    Container(height: 12, width: 100, color: Colors.white),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
