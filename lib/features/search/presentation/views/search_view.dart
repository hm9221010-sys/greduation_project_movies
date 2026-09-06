import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/services/search_service.dart';
import '../manager/search_bloc.dart';
import '../manager/search_event.dart';
import '../manager/search_state.dart';
import '../widgets/search_result_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  void _onChanged(String query, SearchBloc bloc) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(
      const Duration(milliseconds: 400),
          () {
        bloc.add(SearchQueryChanged(query));
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(SearchService()),
      child: Scaffold(
        backgroundColor: const Color(0xFF121312),
        body: SafeArea(
          child: Builder(
            builder: (context) {
              final bloc = context.read<SearchBloc>();

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 21.h,
                    ),
                    child: SizedBox(
                      width: 398.w,
                      height: 55.72.h,
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                        onChanged: (value) {
                          _onChanged(value, bloc);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),

                          prefixIcon: Padding(
                            padding: EdgeInsets.all(14.w),
                            child: SvgPicture.asset(
                              'assets/icons/search.svg',
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),

                          filled: true,
                          fillColor: const Color(0xFF282A28),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: BorderSide(
                              color: const Color(0xFF282A28),
                              width: 1.w,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: BorderSide(
                              color: const Color(0xFF282A28),
                              width: 1.w,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: BorderSide(
                              color: const Color(0xFF282A28),
                              width: 1.w,
                            ),
                          ),

                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0.h,
                            horizontal: 16.w,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state is SearchInitial) {
                          return Center(
                            child: Image.asset(
                              'assets/images/empty.png',
                              width: 124.w,
                              height: 124.h,
                              fit: BoxFit.contain,
                            ),
                          );
                        }

                        if (state is SearchLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          );
                        }

                        if (state is SearchLoaded) {
                          if (state.movies.isEmpty) {
                            return Center(
                              child: Image.asset(
                                'assets/images/empty.png',
                                width: 124.w,
                                height: 124.h,
                                fit: BoxFit.contain,
                              ),
                            );
                          }

                          return GridView.builder(
                            padding: EdgeInsets.fromLTRB(
                              16.w,
                              0,
                              16.w,
                              100.h,
                            ),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.w,
                              mainAxisSpacing: 16.h,
                              childAspectRatio: 0.68,
                            ),
                            itemCount: state.movies.length,
                            itemBuilder: (context, index) {
                              return SearchResultCard(
                                movie: state.movies[index],
                              );
                            },
                          );
                        }

                        if (state is SearchError) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Text(
                                'Error: ${state.message}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}