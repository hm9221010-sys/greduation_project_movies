import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greduation_movies_fluter/ui/browse/browse_cubit.dart';
import 'package:greduation_movies_fluter/ui/browse/browse_state.dart';
import 'package:greduation_movies_fluter/utils/app_Style.dart';
import 'package:greduation_movies_fluter/utils/app_color.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrowseCubit()..loadBrowseData(),
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
       
        body: BlocBuilder<BrowseCubit, BrowseState>(
          builder: (context, state) {
            if (state is BrowseLoadingState) {
              return  Center(
                child: CircularProgressIndicator(color: AppColors.yellowColor),
              );
            } else if (state is BrowseErrorState) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style:  TextStyle(color: AppColors.whiteColor),
                ),
              );
            } else if (state is BrowseSuccessState) {
              return Column(
                children: [
                  SizedBox(
                    height: 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.genres.length,
                      padding:  EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, index) {
                        final genre = state.genres[index];
                        final isSelected = genre == state.selectedGenre;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              context.read<BrowseCubit>().changeCategory(genre);
                            },
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.yellowColor
                                    : AppColors.blackColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.yellowColor,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                genre,
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.blackColor
                                      :  AppColors.yellowColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  movie.posterUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.broken_image,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.blackColor.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        movie.rating,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.star,
                                        color: AppColors.yellowColor,
                                        size: 16,
                                      ),
                                ],
                                  ),
                            ),
                         ),
                            ],
                             ),
                        );
                         },
                ),
                  ),
             ],
              );
            }
            return const SizedBox.shrink();
            },
          ),
      ),
    );
  }
}