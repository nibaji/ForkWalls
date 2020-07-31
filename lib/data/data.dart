import 'package:forkwalls/model/categories_model.dart';
import 'pexels_key.dart';

String APIKey = pexelKey;

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = new List();
  CategoriesModel CategoryModel = new CategoriesModel();

  //
  CategoryModel.imgUrl =
      "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100";
  CategoryModel.CategoryName = "Bikes";
  categories.add(CategoryModel);
  CategoryModel = new CategoriesModel();

  //
  CategoryModel.imgUrl =
      "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100";
  CategoryModel.CategoryName = "Cars";
  categories.add(CategoryModel);
  CategoryModel = new CategoriesModel();

  //
  CategoryModel.imgUrl =
      "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100";
  CategoryModel.CategoryName = "City";
  categories.add(CategoryModel);
  CategoryModel = new CategoriesModel();

  //
  CategoryModel.imgUrl =
      "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  CategoryModel.CategoryName = "Motivation";
  categories.add(CategoryModel);
  CategoryModel = new CategoriesModel();

  //
  CategoryModel.imgUrl =
      "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&h=100";
  CategoryModel.CategoryName = "Nature";
  categories.add(CategoryModel);
  CategoryModel = new CategoriesModel();

  //
  CategoryModel.imgUrl =
      "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100";
  CategoryModel.CategoryName = "Street Art";
  categories.add(CategoryModel);
  CategoryModel = new CategoriesModel();

  //
  CategoryModel.imgUrl =
      "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100";
  CategoryModel.CategoryName = "Wild Life";
  categories.add(CategoryModel);
  CategoryModel = new CategoriesModel();

  return categories;
}
