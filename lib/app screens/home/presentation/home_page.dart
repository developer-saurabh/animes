import 'package:anime/app%20screens/home/presentation/cubit/home_cubit.dart';
import 'package:anime/app%20screens/home/presentation/cubit/home_state.dart';
import 'package:anime/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/constants/size_constants.dart';
import '../../../core/di/service_locator.dart';
import '../../../widgets/common_bottom_nav_bar.dart';
import '../../../core/network/api_helper.dart';
import '../data/repositories/home_repository.dart';
import '../data/models/anime_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _currentIndex = 0;
  bool _isLoading = true;

  List<AnimeModel> _topMovies = [];

  late final HomeRepository _repository;

  Future<void> _launchHomeTrailer() async {
  const String url = 'https://www.youtube.com/watch?v=LV-nazLVmgo';
  final uri = Uri.parse(url);

  await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );
}


  @override
  void initState() {
    super.initState();
    _repository = HomeRepository(ApiHelper());
    _fetchHomeData();
  }

  Future<void> _fetchHomeData() async {
    try {
      final response = await _repository.fetchTopMovies();
      if (mounted) {
        setState(() {
          _topMovies = response.data;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Home API error: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, RouteNames.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, RouteNames.search);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, RouteNames.newReleases);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
body: SafeArea(
  child: BlocProvider(
    create: (_) => sl<HomeCubit>()..fetchHomeData(),
    child: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return _shimmerView();
        }

        if (state is HomeLoaded) {
          _topMovies = state.animeList;
          return _contentView();
        }

        if (state is HomeError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        return _shimmerView();
      },
    ),
  ),
),
      bottomNavigationBar: CommonBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }


  Widget _contentView() {
    if (_topMovies.isEmpty) {
      return const Center(
        child: Text('No data found', style: TextStyle(color: Colors.white)),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _heroSection(_topMovies.first),
          const SizedBox(height: SizeConstants.paddingLarge),
          _sectionHeader(StringConstants.trendingAnime),
          _animeHorizontalList(_topMovies),
          const SizedBox(height: SizeConstants.paddingLarge),
          _sectionHeader(StringConstants.upcomingAnime),
          _animeHorizontalList(_topMovies), // 🔁 same API for now
        ],
      ),
    );
  }



  Widget _shimmerView() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 320, color: Colors.white),
            const SizedBox(height: 24),
            _shimmerSectionHeader(),
            _shimmerHorizontalList(),
            const SizedBox(height: 24),
            _shimmerSectionHeader(),
            _shimmerHorizontalList(),
          ],
        ),
      ),
    );
  }

  Widget _shimmerSectionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SizeConstants.paddingMedium,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(height: 18, width: 140, color: Colors.white),
          Container(height: 14, width: 60, color: Colors.white),
        ],
      ),
    );
  }

  Widget _shimmerHorizontalList() {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(SizeConstants.paddingMedium),
        itemCount: 6,
        itemBuilder: (_, __) {
          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: 12),
            color: Colors.white,
          );
        },
      ),
    );
  }



  Widget _heroSection(AnimeModel anime) {
    return Stack(
      children: [
        Container(
          height: 320,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(anime.images.largeImageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 320,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.9),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                anime.title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                anime.synopsis ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                     onPressed: _launchHomeTrailer,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text(StringConstants.play),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.textPrimary),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: AppColors.textPrimary),
                    label: const Text(
                      StringConstants.myList,
                      style: TextStyle(color: AppColors.textPrimary),
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



  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SizeConstants.paddingMedium,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            StringConstants.viewAll,
            style: TextStyle(color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _animeHorizontalList(List<AnimeModel> list) {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(SizeConstants.paddingMedium),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final anime = list[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.animeDetail,
                arguments: anime,
              );
            },

            child: Container(
              width: 120,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeConstants.borderRadius),
                image: DecorationImage(
                  image: NetworkImage(anime.images.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.all(6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    anime.score?.toStringAsFixed(1) ?? '--',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
