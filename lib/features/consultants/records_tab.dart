import 'package:flutter/material.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/features/consultants/edit_record.dart';

class Listdata extends StatelessWidget {
  const Listdata({Key key, @required this.records}) : super(key: key);

  final List records;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: records.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) => ListCard(
                product: records[index],
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditRecord(
                                record: records[index],
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
  final Map product;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product['title'],
              style: TypographyStyle.bodyMediumn.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 19, height: 0),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '11th April, 23',
              style: TypographyStyle.bodyMediumn.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 14, height: 0),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product['body'],
              maxLines: 5,
              style: TypographyStyle.bodyMediumn.copyWith(
                  fontSize: 13,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  height: 0),
            ),
          ],
        ),
      ),
    );
  }
}

class RecordColor {
  final String id;
  final Color color;
  RecordColor({
    @required this.id,
    @required this.color,
  });
}

List<RecordColor> products = [
  RecordColor(
    id: '1',
    color: const Color(0xFFFFFFFF),
  ),
  RecordColor(
    id: '2',
    color: const Color(0xFF71B8FF),
  ),
  RecordColor(
    id: '3',
    color: const Color(0xFFff6374),
  ),
  RecordColor(
    id: '4',
    color: const Color.fromRGBO(255, 170, 91, 1),
  ),
];
