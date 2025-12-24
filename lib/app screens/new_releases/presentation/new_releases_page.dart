import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/size_constants.dart';
import '../../../core/constants/asset_constants.dart';
import '../../../widgets/common_bottom_nav_bar.dart';
import '../../../routes/route_names.dart';

class NewReleasesPage extends StatefulWidget {
  const NewReleasesPage({super.key});

  @override
  State<NewReleasesPage> createState() => _NewReleasesPageState();
}

class _NewReleasesPageState extends State<NewReleasesPage> {
  final int _currentIndex = 2;
  bool _isLoading = true;

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
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, RouteNames.search);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('New Releases'),
      ),
      body: _isLoading ? _shimmerView() : _contentView(),
      bottomNavigationBar: CommonBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }



  Widget _contentView() {
    return ListView.builder(
      padding: const EdgeInsets.all(SizeConstants.paddingMedium),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _releaseItem();
      },
    );
  }

  Widget _releaseItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(SizeConstants.borderRadius),
            child: Image.network(
              AssetConstants.animePoster,
              height: 110,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'One Punch Man Season 3',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Release Date:',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                Text(
                  'Description: Third season of One Punch Man.',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _shimmerView() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: ListView.builder(
        padding: const EdgeInsets.all(SizeConstants.paddingMedium),
        itemCount: 5,
        itemBuilder: (_, __) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  width: 80,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 16, width: double.infinity, color: Colors.white),
                      const SizedBox(height: 8),
                      Container(height: 12, width: 120, color: Colors.white),
                      const SizedBox(height: 8),
                      Container(height: 12, width: double.infinity, color: Colors.white),
                      const SizedBox(height: 4),
                      Container(height: 12, width: double.infinity, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
