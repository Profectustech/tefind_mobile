import 'package:saleko/utils/assets_manager.dart';

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
    image: Assets.iphoneLogo,
    title: "Welcome to Saleko!",
    content:
        "Discover a world of diverse products and vendors at your fingertips. Get the best deals and a seamless shopping experience all in one place.",
  );
  screens.add(screenOne);

  //screen 2
  OnboardingScreenModel screenTwo = OnboardingScreenModel(
    image: Assets.onboardingOne,
    title: "Negotiate Prices",
    content:
        "Find the best deals and negotiate prices directly with sellers. Get the products you love at the prices you want.",
  );

  screens.add(screenTwo);

  //screen 3
  OnboardingScreenModel screenThree = OnboardingScreenModel(
    image: Assets.street,
    title: "Search by Market",
    content:
        "Explore products from various markets. Whether you're looking for local treasures or international goods, Saleko has it all.",
  );
  screens.add(screenThree);
  //screen 4
  OnboardingScreenModel screenFour = OnboardingScreenModel(
    image: Assets.rider,
    title: "Swift Delivery",
    content:
        "Enjoy fast and reliable delivery services. Your purchases will reach you swiftly and securely.",
  );

  screens.add(screenFour);

  return screens;
}
