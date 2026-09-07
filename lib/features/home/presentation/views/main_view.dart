// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../data/services/api_service.dart';
// import '../manager/home_cubit.dart';
// import '../manager/home_state.dart';
// import '../widgets/available_now_slider.dart';
// import '../widgets/movie_card.dart';
// import '../../../search/presentation/views/search_view.dart';
//
// class MainView extends StatefulWidget {
//   const MainView({super.key});
//
//   @override
//   State<MainView> createState() => _MainViewState();
// }
//
// class _MainViewState extends State<MainView> {
//   int _selectedIndex = 0;
//   int _currentMovieIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return MediaQuery(
//       data: MediaQuery.of(context).copyWith(
//         textScaler: TextScaler.noScaling,
//       ),
//       child: BlocProvider(
//         create: (context) => HomeCubit(ApiService())..fetchMovies(),
//         child: Builder(
//           builder: (context) {
//             return Scaffold(
//               backgroundColor: const Color(0xFF121312),
//               body: IndexedStack(
//                 index: _selectedIndex,
//                 children: [
//                   SafeArea(
//                     child: BlocBuilder<HomeCubit, HomeState>(
//                       builder: (context, state) {
//                         if (state is HomeLoading) {
//                           return const Center(
//                             child: CircularProgressIndicator(
//                               color: Colors.amber,
//                             ),
//                           );
//                         }
//
//                         if (state is HomeLoaded) {
//                           final movies = state.movies;
//                           final categoryMovies = state.categoryMovies;
//                           final currentCategoryName = state.categoryName;
//
//                           final sortedPosters =
//                           movies.map((movie) => movie.posterUrl).toList();
//
//                           return SingleChildScrollView(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   width: double.infinity,
//                                   height: 645.h,
//                                   child: Stack(
//                                     clipBehavior: Clip.hardEdge,
//                                     children: [
//                                       Positioned.fill(
//                                         child: sortedPosters.isNotEmpty
//                                             ? Image.network(
//                                           sortedPosters[
//                                           _currentMovieIndex < sortedPosters.length
//                                               ? _currentMovieIndex
//                                               : 0
//                                           ],
//                                           fit: BoxFit.cover,
//                                         )
//                                             : Container(
//                                           color: const Color(0xFF1C1D1C),
//                                         ),
//                                       ),
//
//                                       Positioned.fill(
//                                         child: Container(
//                                           color: const Color(0xFF121312)
//                                               .withValues(alpha: 0.82),
//                                         ),
//                                       ),
//
//                                       Positioned(
//                                         top: 7.h,
//                                         left: 81.w,
//                                         child: Image.asset(
//                                           'assets/images/available_now.png',
//                                           width: 267.w,
//                                           height: 93.h,
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//
//                                       if (sortedPosters.isNotEmpty)
//                                         Positioned(
//                                           top: 121.h,
//                                           left: 0,
//                                           right: 0,
//                                           child: AvailableNowSlider(
//                                             imageUrls: sortedPosters,
//                                             ratings: movies
//                                                 .map((movie) => movie.rating)
//                                                 .toList(),
//                                             onPageChanged: (index) {
//                                               setState(() {
//                                                 _currentMovieIndex = index;
//                                               });
//                                             },
//                                           ),
//                                         ),
//
//                                       Positioned(
//                                         top: 493.h,
//                                         left: 38.w,
//                                         child: Image.asset(
//                                           'assets/images/watch_now.png',
//                                           width: 354.w,
//                                           height: 146.h,
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//
//                                 SizedBox(height: 10.h),
//
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(
//                                     horizontal: 16.w,
//                                     vertical: 4.h,
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text(
//                                             currentCategoryName,
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 18.sp,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           if (state.categoryLoading) ...[
//                                             SizedBox(width: 8.w),
//                                             SizedBox(
//                                               width: 14.w,
//                                               height: 14.w,
//                                               child: const CircularProgressIndicator(
//                                                 strokeWidth: 2,
//                                                 color: Colors.amber,
//                                               ),
//                                             ),
//                                           ],
//                                         ],
//                                       ),
//                                       TextButton(
//                                         onPressed: () {},
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               'See More ',
//                                               style: TextStyle(
//                                                 color: Colors.amber,
//                                                 fontSize: 14.sp,
//                                               ),
//                                             ),
//                                             Icon(
//                                               Icons.arrow_forward,
//                                               color: Colors.amber,
//                                               size: 16.sp,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//
//                                 SizedBox(
//                                   height: 220.h,
//                                   child: categoryMovies.isEmpty
//                                       ? Center(
//                                     child: Text(
//                                       'No movies found in this category',
//                                       style: TextStyle(
//                                         color: Colors.white70,
//                                         fontSize: 14.sp,
//                                       ),
//                                     ),
//                                   )
//                                       : ListView.builder(
//                                     scrollDirection: Axis.horizontal,
//                                     padding: EdgeInsets.only(left: 16.w),
//                                     itemCount: categoryMovies.length,
//                                     itemBuilder: (context, index) {
//                                       return MovieCard(
//                                         imageUrl:
//                                         categoryMovies[index].posterUrl,
//                                         rating:
//                                         categoryMovies[index].rating,
//                                       );
//                                     },
//                                   ),
//                                 ),
//
//                                 SizedBox(height: 100.h),
//                               ],
//                             ),
//                           );
//                         }
//
//                         if (state is HomeError) {
//                           return SingleChildScrollView(
//                             physics: const AlwaysScrollableScrollPhysics(),
//                             child: SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.7,
//                               child: Center(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(16.w),
//                                   child: Text(
//                                     'Error: ${state.message}',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16.sp,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }
//
//                         return const SizedBox();
//                       },
//                     ),
//                   ),
//
//                   const SearchView(),
//
//                   Center(
//                     child: Text(
//                       'Explore',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.sp,
//                       ),
//                     ),
//                   ),
//
//                   Center(
//                     child: Text(
//                       'Profile',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.sp,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               bottomNavigationBar: Container(
//                 height: 61.h,
//                 margin: EdgeInsets.only(
//                   left: 9.w,
//                   right: 9.w,
//                   bottom: 9.h,
//                 ),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF282A28).withValues(alpha: 0.9),
//                   borderRadius: BorderRadius.circular(16.r),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     _buildNavItem(
//                       context: context,
//                       index: 0,
//                       assetPath: 'assets/icons/home.svg',
//                     ),
//                     _buildNavItem(
//                       context: context,
//                       index: 1,
//                       assetPath: 'assets/icons/search.svg',
//                     ),
//                     _buildNavItem(
//                       context: context,
//                       index: 2,
//                       assetPath: 'assets/icons/explore.svg',
//                     ),
//                     _buildNavItem(
//                       context: context,
//                       index: 3,
//                       assetPath: 'assets/icons/profile.svg',
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem({
//     required BuildContext context,
//     required int index,
//     required String assetPath,
//   }) {
//     final bool isSelected = _selectedIndex == index;
//
//     return Expanded(
//       child: GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTap: () {
//           setState(() {
//             _selectedIndex = index;
//           });
//
//           if (index == 0) {
//             context.read<HomeCubit>().nextCategory();
//           }
//         },
//         child: Center(
//           child: SvgPicture.asset(
//             assetPath,
//             width: 24.w,
//             height: 24.h,
//             colorFilter: ColorFilter.mode(
//               isSelected ? Colors.amber : Colors.white,
//               BlendMode.srcIn,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }























import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greduation_movies_fluter/ui/profile_screen.dart';

import '../../data/services/api_service.dart';
import '../manager/home_bloc.dart';
import '../manager/home_event.dart';
import '../manager/home_state.dart';
import '../widgets/available_now_slider.dart';
import '../widgets/movie_card.dart';
import '../../../search/presentation/views/search_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  int _currentMovieIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.noScaling,
      ),
      child: BlocProvider(
        create: (context) => HomeBloc(ApiService())..add(FetchMoviesEvent()),
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: const Color(0xFF121312),
              body: IndexedStack(
                index: _selectedIndex,
                children: [
                  SafeArea(
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          );
                        }

                        if (state is HomeLoaded) {
                          final movies = state.movies;
                          final categoryMovies = state.categoryMovies;
                          final currentCategoryName = state.categoryName;

                          final sortedPosters =
                          movies.map((movie) => movie.posterUrl).toList();

                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 645.h,
                                  child: Stack(
                                    clipBehavior: Clip.hardEdge,
                                    children: [
                                      Positioned.fill(
                                        child: sortedPosters.isNotEmpty
                                            ? Image.network(
                                          sortedPosters[
                                          _currentMovieIndex < sortedPosters.length
                                              ? _currentMovieIndex
                                              : 0
                                          ],
                                          fit: BoxFit.cover,
                                        )
                                            : Container(
                                          color: const Color(0xFF1C1D1C),
                                        ),
                                      ),

                                      Positioned.fill(
                                        child: Container(
                                          color: const Color(0xFF121312)
                                              .withValues(alpha: 0.82),
                                        ),
                                      ),

                                      Positioned(
                                        top: 7.h,
                                        left: 81.w,
                                        child: Image.asset(
                                          'assets/images/available_now.png',
                                          width: 267.w,
                                          height: 93.h,
                                          fit: BoxFit.contain,
                                        ),
                                      ),

                                      if (sortedPosters.isNotEmpty)
                                        Positioned(
                                          top: 121.h,
                                          left: 0,
                                          right: 0,
                                          child: AvailableNowSlider(
                                            imageUrls: sortedPosters,
                                            ratings: movies
                                                .map((movie) => movie.rating)
                                                .toList(),
                                            onPageChanged: (index) {
                                              setState(() {
                                                _currentMovieIndex = index;
                                              });
                                            },
                                          ),
                                        ),

                                      Positioned(
                                        top: 493.h,
                                        left: 38.w,
                                        child: Image.asset(
                                          'assets/images/watch_now.png',
                                          width: 354.w,
                                          height: 146.h,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 10.h),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 4.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            currentCategoryName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (state.categoryLoading) ...[
                                            SizedBox(width: 8.w),
                                            SizedBox(
                                              width: 14.w,
                                              height: 14.w,
                                              child: const CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.amber,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Row(
                                          children: [
                                            Text(
                                              'See More ',
                                              style: TextStyle(
                                                color: Colors.amber,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              color: Colors.amber,
                                              size: 16.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 220.h,
                                  child: categoryMovies.isEmpty
                                      ? Center(
                                    child: Text(
                                      'No movies found in this category',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  )
                                      : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.only(left: 16.w),
                                    itemCount: categoryMovies.length,
                                    itemBuilder: (context, index) {
                                      return MovieCard(
                                        imageUrl:
                                        categoryMovies[index].posterUrl,
                                        rating:
                                        categoryMovies[index].rating,
                                      );
                                    },
                                  ),
                                ),

                                SizedBox(height: 100.h),
                              ],
                            ),
                          );
                        }

                        if (state is HomeError) {
                          return SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: Text(
                                    'Error: ${state.message}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ),

                  const SearchView(),

                  Center(
                    child: Text(
                      'Explore',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  ProfileScreen(),

                  // Center(
                  //   child: Text(
                  //     'Profile',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 20.sp,
                  //     ),
                  //   ),
                  // ),
                ],
              ),

              bottomNavigationBar: Container(
                height: 61.h,
                margin: EdgeInsets.only(
                  left: 9.w,
                  right: 9.w,
                  bottom: 9.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF282A28).withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildNavItem(
                      context: context,
                      index: 0,
                      assetPath: 'assets/icons/home.svg',
                    ),
                    _buildNavItem(
                      context: context,
                      index: 1,
                      assetPath: 'assets/icons/search.svg',
                    ),
                    _buildNavItem(
                      context: context,
                      index: 2,
                      assetPath: 'assets/icons/explore.svg',
                    ),
                    _buildNavItem(
                      context: context,
                      index: 3,
                      assetPath: 'assets/icons/profile.svg',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required String assetPath,
  }) {
    final bool isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });

          if (index == 0) {
            context.read<HomeBloc>().add(NextCategoryEvent());
          }
        },
        child: Center(
          child: SvgPicture.asset(
            assetPath,
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              isSelected ? Colors.amber : Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}