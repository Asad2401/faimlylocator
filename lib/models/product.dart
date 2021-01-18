class Product {
  int id, price;
  double tex_vat;
  String title, image;

  Product({this.id, this.price, this.title, this.image, this.tex_vat});
}

// list of products
// for our demo
List<Product> products = [
  Product(
    id: 1,
    price: 70,
    title: "Cylinder Size 11 kg",
    image: "lib/assets/Item_1.png",
    tex_vat: .05,
  ),
  // Product(
  //   id: 4,
  //   price: 100,
  //   title: "Cylinder Size 22 kg",
  //   image: "lib/assets/Item_2.png",
  //   tex_vat: 0.05,
  // ),
  // Product(
  //   id: 9,
  //   price: 190,
  //   title: "Cylinder Size 44 kg",
  //   image: "lib/assets/Item_3.png",
  //   tex_vat: 0.05,
  // ),
];
