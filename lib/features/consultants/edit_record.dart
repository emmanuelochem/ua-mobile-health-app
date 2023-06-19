import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ua_mobile_health/core/ui/typography_style.dart';
import 'package:ua_mobile_health/core/ui/ui_colors.dart';
import 'package:ua_mobile_health/features/consultants/records_tab.dart';

class EditRecord extends StatefulWidget {
  const EditRecord({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  _EditRecordState createState() => _EditRecordState();
}

class _EditRecordState extends State<EditRecord> {
  Color pageColor = Colors.white;

  final title = TextEditingController();
  final desc = TextEditingController();

  @override
  void initState() {
    super.initState();
    title.text = widget.product.title;
    desc.text = widget.product.desc;
    pageColor = widget.product.color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: pageColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'New Record',
          style: TypographyStyle.heading5.copyWith(
            fontSize: 18.sp,
            color: UIColors.secondary,
          ),
        ),
        leading: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 0.010.sh,
            vertical: 0.010.sh,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: UIColors.secondary600.withOpacity(.5),
              border: Border.all(
                width: 1,
                color: UIColors.secondary500,
              )),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(
              'assets/icons/navigator_back.svg',
              height: 0.016.sh,
            ),
            iconSize: 0.02.sh,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 0.010.sh,
              vertical: 0.010.sh,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: UIColors.secondary600.withOpacity(.5),
                border: Border.all(
                  width: 1,
                  color: UIColors.secondary500,
                )),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(PhosphorIcons.calendar),
              iconSize: 0.02.sh,
              color: UIColors.secondary,
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.058.sw),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(width: 1, color: UIColors.secondary500))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: List.generate(
                  products.length, (index) => colorSelection(index)),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: 0.01.sh, horizontal: 0.03.sh),
                decoration: BoxDecoration(
                  color: UIColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Save',
                  style: TypographyStyle.bodySmall.copyWith(
                    fontSize: 17.sp,
                    color: UIColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //title
            TextFormField(
              controller: title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              decoration: const InputDecoration(
                hintText: "Enter title",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            TextFormField(
              controller: desc,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              decoration: const InputDecoration(
                hintText: "Enter description",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding colorSelection(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: InkWell(
        onTap: () {
          setState(() {
            pageColor = products[index].color;
          });
        },
        child: Container(
          height: 43,
          width: 43,
          decoration: BoxDecoration(
              color: products[index].color,
              borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }
}
