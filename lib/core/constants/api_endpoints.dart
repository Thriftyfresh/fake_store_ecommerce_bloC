class ApiEndpoints {
  static const String login = '/auth/login';
  static const String products = '/products';
  static String productById(int id) => '/products/$id';
  static const String categories = '/products/categories';
  static String productsByCategory(String category) =>
      '/products/category/$category';
  static String userCart(int userId) => '/carts/user/$userId';
  static String userProfile(int userId) => '/users/$userId';
  static const String carts = '/carts';
}
