import 'package:te_find/utils/assets_manager.dart';

class OnboardingScreenModel {
  String image;
  String title;
  String content;

  OnboardingScreenModel({
    required this.image,
    required this.title,
    required this.content,
  });
}

List<OnboardingScreenModel> getScreens() {
  List<OnboardingScreenModel> screens = [];

  //screen 1
  OnboardingScreenModel screenOne = OnboardingScreenModel(
    image: Assets.onboardingOne,
    title: "Shop with Confidence",
    content:
        "Verified sellers, secure payments, and quality\nassurance for every purchase",
  );
  screens.add(screenOne);

  //screen 2
  OnboardingScreenModel screenTwo = OnboardingScreenModel(
    image: Assets.onboardingTwo,
    title: "Shop with Confidence",
    content:
    "Verified sellers, secure payments, and quality\nassurance for every purchase",
  );

  screens.add(screenTwo);

  //screen 3
  OnboardingScreenModel screenThree = OnboardingScreenModel(
    image: Assets.onboardingThree,
    title: "Shop with Confidence",
    content:
    "Verified sellers, secure payments, and quality\nassurance for every purchase",
  );
  screens.add(screenThree);

  return screens;
}
