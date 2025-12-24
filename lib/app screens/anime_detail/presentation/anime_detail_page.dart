import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/size_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../home/data/models/anime_model.dart';

class AnimeDetailPage extends StatefulWidget {
  final AnimeModel anime;

  const AnimeDetailPage({
    super.key,
    required this.anime,
  });

  @override
  State<AnimeDetailPage> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // short shimmer for UX polish
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _isLoading ? _shimmerView() : _contentView(),
    );
  }


  Widget _contentView() {
    final anime = widget.anime;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _heroSection(anime),
          const SizedBox(height: 20),
          _playTrailerButton(),
          const SizedBox(height: 24),
          _sectionTitle('Anime Synopsis'),
          _synopsisText(anime.synopsis),
          const SizedBox(height: 24),
          _sectionHeader('Genres'),
          _genresRow(anime),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

 

  Widget _heroSection(AnimeModel anime) {
    return Stack(
      children: [
        Container(
          height: 360,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(anime.images.largeImageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 360,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.95),
              ],
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 8,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 16,
          right: 16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(SizeConstants.borderRadius),
                child: Image.network(
                  anime.images.imageUrl,
                  height: 150,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      anime.title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Score: ${anime.score?.toStringAsFixed(1) ?? '--'}',
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      anime.type,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      anime.studios.isNotEmpty
                          ? anime.studios.first.name
                          : '',
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _playTrailerButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(SizeConstants.borderRadius),
            ),
          ),
          onPressed: () {},
          child: const Text(
            StringConstants.play,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

 

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _synopsisText(String? synopsis) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        synopsis ?? 'No synopsis available.',
        style: const TextStyle(
          color: AppColors.textSecondary,
          height: 1.4,
        ),
      ),
    );
  }


  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _genresRow(AnimeModel anime) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: anime.genres
            .map(
              (g) => Chip(
                label: Text(g.name),
                backgroundColor: AppColors.cardBackground,
                labelStyle:
                    const TextStyle(color: AppColors.textPrimary),
              ),
            )
            .toList(),
      ),
    );
  }

 
  Widget _shimmerView() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Column(
        children: [
          Container(height: 360, color: Colors.white),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 48, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
