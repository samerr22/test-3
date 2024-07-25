class UnboardingContent {
  String image;
  String title;
  String description;
  UnboardingContent(
      {required this.description, required this.image, required this.title});
}

List<UnboardingContent> contents = [
  UnboardingContent(
      description: "Discover and mark",
      image: "images/screen1.png",
      title: "Discover, mark, and share your\n    favorite places with ease"),
  UnboardingContent(
      description:
          "Pinpoint exact locations with precision\n     using our intuitive marking tools.",
      image: "images/screen1.png",
      title: "Easy to find the right place"),
  UnboardingContent(
      description: "  Share your marked locations effortlessly \n                 with friends and family",
      image: "images/screen1.png",
      title: 'Easy to mark your location')
];
