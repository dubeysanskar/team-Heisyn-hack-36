const Map<String, String> categories = {
  'category_all':'All',
  'category_web': 'Web Development',
  'category_app': 'App Development',
  'category_ai': 'Artificial Intelligence',
  'category_business': 'Business Intelligence',
  'category_editing': 'Video Editing',
  'category_media': 'Social Media',
};

class Course {
  String title;
  String author;
  String src;
  String category;
  double rating;
  String price;
  String discountPrice;

  Course({
    required this.title,
    required this.author,
    required this.src,
    required this.category,
    required this.rating,
    required this.price,
    required this.discountPrice,
  });
}

final List<Course> courseData = [
  Course(
    title: 'HTML / CSS From Zero to Hero',
    author: 'Shiva Pandey',
    src: 'assets/images/course/html-css.png',
    category: categories['category_web']!,
    rating: 4.8,
    price: '149/-',
    discountPrice: 'Free',
  ),
  Course(
    title: 'Advanced Javascript',
    author: 'Devendra Singh',
    src: 'assets/images/course/javascript.jpg',
    category: categories['category_web']!,
    rating: 4.5,
    price: '99/-',
    discountPrice: 'Free',
  ),
  Course(
    title: 'Next Js / React Js Full course',
    author: 'Shiva Pandey',
    src: 'assets/images/course/nextjs.png',
    category: categories['category_web']!,
    rating: 4.5,
    price: '199/-',
    discountPrice: 'Free',
  ),
  Course(
    title: 'Flutter App Development',
    author: 'Zaid Sayyed',
    src: 'assets/images/course/flutter.jpeg',
    category: categories['category_app']!,
    rating: 4.8,
    price: '149/-',
    discountPrice: 'Free',
  ),
  Course(
    title: 'Kotlin Crash Course',
    author: 'Zaid Sayyed',
    src: 'assets/images/course/kotlin.webp',
    category: categories['category_app']!,
    rating: 4.3,
    price: '99/-',
    discountPrice: 'Free',
  ),
  Course(
    title: 'Gen AI | ChatGPT',
    author: 'Sanskar Dubey',
    src: 'assets/images/course/gen-ai.png',
    category: categories['category_ai']!,
    rating: 4.8,
    price: '199/-',
    discountPrice: 'Free',
  ),
  Course(
    title: 'AI / Machine Learning',
    author: 'Shiva Pandey',
    src: 'assets/images/course/ai-ml.jpg',
    category: categories['category_ai']!,
    rating: 4.0,
    price: '99/-',
    discountPrice: 'Free',
  ),
  Course(
    title: 'Data Science and Analysis',
    author: 'Devendra Singh',
    src: 'assets/images/course/data-science.png',
    category: categories['category_ai']!,
    rating: 4.5,
    price: '149/-',
    discountPrice: 'Free',
  ),
  Course(
    title: 'Video Editing',
    author: 'Safwan Khan',
    src: 'assets/images/course/video-editing.png',
    category: categories['category_editing']!,
    rating: 4.6,
    price: '99/-',
    discountPrice: 'Free',
  ),
  Course(
    title: 'Photo Editing',
    author: 'Safwan Khan',
    src: 'assets/images/course/photo-editing.jpg',
    category: categories['category_editing']!,
    rating: 4.4,
    price: '99/-',
    discountPrice: 'Free',
  ),
  Course(
    title: 'Social Media',
    author: 'Sanskar Dubey',
    src: 'assets/images/course/social-media.png',
    category: categories['category_media']!,
    rating: 4.8,
    price: '149/-',
    discountPrice: 'Free',
  ),
];

