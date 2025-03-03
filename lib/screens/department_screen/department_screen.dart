import 'dart:math';

import 'package:flutter/material.dart';

import '../../utils/themes.dart';
import '../../widgets/custom_scaffold.dart';
import 'widgets/about_section.dart';
import 'widgets/department_screen_app_bar.dart';
import 'widgets/drop_down_menu_item.dart';
import 'widgets/faculty_details_section.dart';

enum Item {
  about,
  facultyDetails,
  placementDetails,
  resultAnalysis,
  curriculum,
  more,
}

extension ItemNameExtension on Item {
  String get name {
    switch (this) {
      case Item.about:
        return "About";
      case Item.facultyDetails:
        return "Faculty Details";
      case Item.placementDetails:
        return "Placement Details";
      case Item.resultAnalysis:
        return "Result Analysis";
      case Item.curriculum:
        return "Curriculum";
      case Item.more:
        return "More";
    }
  }
}

class DepartmentScreen extends StatefulWidget {
  final String departmentName;

  const DepartmentScreen({
    Key? key,
    required this.departmentName,
  }) : super(key: key);

  @override
  _DepartmentScreenState createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  Item selectedItem = Item.about;

  void _showDropDown(BuildContext context) async {
    Size size = MediaQuery.of(context).size;
    OverlayState overlayState = Overlay.of(context)!;
    late OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: 20,
        top: size.height * 0.27,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          width: 230,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            border: Border.all(color: kLightModeLightBlue),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            children: [
              for (var item in Item.values)
                DropDownMenuItem(
                    title: item.name,
                    onTap: () {
                      setState(() {
                        selectedItem = item;
                      });
                      overlayEntry!.remove();
                    })
            ],
          ),
        ),
      );
    });
    overlayState.insert(overlayEntry);
  }

  Widget section(Item item) {
    switch (item) {
      case Item.about:
        return const AboutSection();
      case Item.facultyDetails:
        return const FacultyDetailsSection();
      default:
        return const AboutSection();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomScaffold(
      appBar: const DepartmentScreenAppBar(
        title: "Department",
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width,
              height: 0.18 * size.height,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.departmentName,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 22),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    width: 230,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: kLightModeLightBlue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          selectedItem.name,
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: Colors.white),
                        ),
                        const Spacer(),
                        const VerticalDivider(
                          color: Colors.white,
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showDropDown(context);
                          },
                          child: Transform.rotate(
                            angle: -90 * pi / 180,
                            child: const Icon(
                              Icons.chevron_left,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            section(selectedItem),
          ],
        ),
      ),
    );
  }
}
