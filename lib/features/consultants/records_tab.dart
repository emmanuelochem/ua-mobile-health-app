import 'package:flutter/material.dart';
import 'package:ua_mobile_health/features/consultants/edit_record.dart';

class Product {
  final String title, desc;
  final Color color;
  Product({
    @required this.title,
    @required this.desc,
    @required this.color,
  });
}

List<Product> products = [
  Product(
    title: "Malaria",
    color: const Color(0xFF71B8FF),
    desc:
        "He made complains of malaria. And the necessary precsriptions were administered.",
  ),
  Product(
    title: "Typhoid Fever",
    color: const Color(0xFFff6374),
    desc:
        "He made complains of typhoid. And the necessary precsriptions were administered.",
  ),
  Product(
    title: "Toothache",
    color: const Color.fromRGBO(255, 170, 91, 1),
    desc:
        "He made complains of tooth ache. And the necessary precsriptions were administered.",
  ),
];

class Listdata extends StatelessWidget {
  const Listdata({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) => ListCard(
                product: products[index],
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditRecord(
                                product: products[index],
                              )));
                },
              )),
    );
  }
}

class ListCard extends StatelessWidget {
  const ListCard({
    Key key,
    @required this.product,
    @required this.press,
  }) : super(key: key);
  final Product product;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: product.color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 19,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.desc,
              maxLines: 5,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
