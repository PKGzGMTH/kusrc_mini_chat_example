import './onboardingModel.dart';

//ข้อมูลสำหรับหน้าเริ่มต้นแอป
class OnboardingData {
  List<onboardingModel> items = [
    onboardingModel(
        title: "Online chat",
        description:
            "People to communicate in real-time with others through the Internet",
        image: "assets/images/onboardingImage1.jpg"),
    onboardingModel(
        title: "Benefits",
        description: "The ability to quickly respond to a customer's problem",
        image: "assets/images/onboardingImage2.jpg"),
    onboardingModel(
        title: "Mini chat",
        description:
            "a powerful and intuitive live chat software that empowers you to have seamless"
            "and engaging conversations with customers in real-time",
        image: "assets/images/onboardingImage3.jpg"),
  ];
}
