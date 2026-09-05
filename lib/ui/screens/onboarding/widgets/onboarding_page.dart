import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/utils/app_Style.dart';
import 'package:greduation_movies_fluter/utils/app_color.dart';
import '../../../../utils/app_size.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String? description;
  final Widget? primaryButton;
  final Widget? secondaryButton;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    this.description,
    this.primaryButton,
    this.secondaryButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: context.width,
              padding: EdgeInsets.symmetric(
                horizontal: context.width * 0.05,
                vertical: context.height * 0.03,
              ),
              decoration: BoxDecoration(
                color: AppColors.blackColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    context.width * 0.08,
                  ),
                  topRight: Radius.circular(
                    context.width * 0.08,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppStyle.bold36White,
                  ),
                  if (description != null) ...[
                    SizedBox(
                      height: context.height * 0.015,
                    ),
                    Text(
                      description!,
                      textAlign: TextAlign.center,
                      style: AppStyle.regular20White,
                    ),
                  ],
                  SizedBox(
                    height: context.height * 0.025,
                  ),

                  if (primaryButton != null)
                    primaryButton!,

                  if (secondaryButton != null) ...[
                    SizedBox(
                      height: context.height * 0.015,
                    ),
                    secondaryButton!,
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}