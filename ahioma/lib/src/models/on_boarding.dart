class OnBoarding {
  String image;
  String description;

  OnBoarding({this.image, this.description});
}

class OnBoardingList {
  List<OnBoarding> _list;

  List<OnBoarding> get list => _list;

  OnBoardingList() {
    _list = [
      new OnBoarding(
          image: 'img/2.png', description: 'Welcome to Ahioma, your virtual market!!!'),
      new OnBoarding(image: 'img/1.png', description: 'Experience the delight of 24hrs delivery'),
      new OnBoarding(image: 'img/4.png', description: 'Over 100,000 products and shops to buy from'),
    ];
  }
}
