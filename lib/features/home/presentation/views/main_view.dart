import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/services/api_service.dart';
import '../manager/home_cubit.dart';
import '../manager/home_state.dart';
import '../widgets/available_now_slider.dart';
import '../widgets/movie_card.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  int _currentMovieIndex = 0;

  final List<String> _categories = [
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Crime',
    'Drama',
    'Horror',
    'Romance',
    'Science Fiction',
    'Thriller',
  ];

  int _currentCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ربط الـ Cubit وتوفيره للشاشة بالكامل ونطق fetchMovies لجلب الداتا
    return BlocProvider(
      create: (context) => HomeCubit(ApiService())..fetchMovies(),
      child: Scaffold(
        backgroundColor: const Color(0xFF121312),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            // 1. حالة التحميل
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              );
            }
            // 2. حالة نجاح جلب الداتا
            else if (state is HomeLoaded) {
              final movies = state.movies;
              final List<String> sortedPosters = movies.map((m) => m.posterUrl).toList();
              final String currentCategoryName = _categories[_currentCategoryIndex];

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 645,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: sortedPosters.isNotEmpty
                                  ? Image.network(
                                sortedPosters[_currentMovieIndex < sortedPosters.length ? _currentMovieIndex : 0],
                                fit: BoxFit.cover,
                              )
                                  : Container(color: const Color(0xFF1C1D1C)),
                            ),
                            Positioned.fill(
                              child: Container(
                                color: const Color(0xFF121312).withValues(alpha: 0.82),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Center(
                                  child: Image.asset(
                                    'assets/images/available_now.png',
                                    width: 260,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                AvailableNowSlider(
                                  imageUrls: sortedPosters,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentMovieIndex = index;
                                    });
                                  },
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: Image.asset(
                                    'assets/images/watch_now.png',
                                    width: 310,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentCategoryName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Text('See More ', style: TextStyle(color: Colors.amber)),
                                  Icon(Icons.arrow_forward, color: Colors.amber, size: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 16),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              imageUrl: movies[index].posterUrl,
                              rating: movies[index].rating,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              );
            }
            // 3. حالة الخطأ
            else if (state is HomeError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
        bottomNavigationBar: Container(
          height: 61,
          margin: const EdgeInsets.only(left: 9, right: 9, bottom: 9),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          decoration: BoxDecoration(
            color: const Color(0xFF282A28).withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;

                  if (index == 0) {
                    _currentCategoryIndex = (_currentCategoryIndex + 1) % _categories.length;
                  }
                });
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/home.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 0 ? Colors.amber : Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 1 ? Colors.amber : Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/explore.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 2 ? Colors.amber : Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/profile.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 3 ? Colors.amber : Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}