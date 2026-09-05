import 'package:flutter/material.dart';
import '../../../utils/route_name.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/onboarding_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          OnboardingPage(
            image: 'assets/images/onboarding/OnBoarding_1.png',
            title: 'Find Your Next Favorite Movie Here',
            description:
            'Get access to a huge library of movies \n to suit all tastes. You will surely like it.',
            primaryButton: OnboardingButton(
              text: 'Explore Now',
              backgroundColor: Colors.yellow,
              textColor: Colors.black,
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          OnboardingPage(
            image: 'assets/images/onboarding/OnBoarding_2.png',
            title: 'Discover Movies',
            description:
            'Explore a vast collection of movies in all '
                ' qualities and genres. Find your next '
                      'favorite film with ease.',
            primaryButton: OnboardingButton(
              text: 'Next',
              backgroundColor: Colors.yellow,
              textColor: Colors.black,
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          OnboardingPage(
            image: 'assets/images/onboarding/OnBoarding_3.png',
            title: 'Explore All Genres',
            description:
            'Discover movies from every genre, in all '
            '\n available qualities. Find something new '
                 'and exciting to watch every day.',
            primaryButton: OnboardingButton(
              text: 'Next',
              backgroundColor: Colors.yellow,
              textColor: Colors.black,
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            secondaryButton: OnboardingButton(
              text: 'Back',
              backgroundColor: Colors.transparent,
              textColor: Colors.yellow,
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          OnboardingPage(
            image: 'assets/images/onboarding/OnBoarding_4.png',
            title: 'Create Watchlists',
            description:
            'Save movies to your watchlist to keep\n track of what you want to watch next.'
                ' Enjoy films in various qualities and '
                             ' genres.',
            primaryButton: OnboardingButton(
              text: 'Next',
              backgroundColor: Colors.yellow,
              textColor: Colors.black,
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            secondaryButton: OnboardingButton(
              text: 'Back',
              backgroundColor: Colors.transparent,
              textColor: Colors.yellow,
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          OnboardingPage(
            image: 'assets/images/onboarding/OnBoarding_5.png',
            title: 'Rate, Review, and Learn',
            description:
            'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies with your reviews.',
            primaryButton: OnboardingButton(
              text: 'Next',
              backgroundColor: Colors.yellow,
              textColor: Colors.black,
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            secondaryButton: OnboardingButton(
              text: 'Back',
              backgroundColor: Colors.transparent,
              textColor: Colors.yellow,
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          OnboardingPage(
            image: 'assets/images/onboarding/OnBoarding_6.png',
            title: 'Start Watching Now',
            primaryButton: OnboardingButton(
              text: 'Finish',
              backgroundColor: Colors.yellow,
              textColor: Colors.black,
              onPressed: () {
                // todo login screen
                Navigator.pushReplacementNamed(
                  context,
                  RouteName.loginRoute,
                );
              },
            ),
            secondaryButton: OnboardingButton(
              text: 'Back',
              backgroundColor: Colors.transparent,
              textColor: Colors.yellow,
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}