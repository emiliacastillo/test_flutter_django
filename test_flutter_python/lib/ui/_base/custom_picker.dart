import 'package:test_flutter_python/ui/_base/app_bottom_sheet.dart';
import 'package:test_flutter_python/utils/app_color.dart';
import 'package:test_flutter_python/utils/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class _CustomPicker extends StatefulWidget {
  final Function(CustomPickerItem) onTap;
  final List<CustomPickerItem> items;
  final CustomPickerItem initialValue;
  final bool showSearch;

  _CustomPicker({
    @required this.items,
    @required this.onTap,
    this.initialValue,
    this.showSearch = true,
  });

  @override
  _CustomPickerState createState() => _CustomPickerState();
}

class _CustomPickerState extends State<_CustomPicker> {
  final searchTextController = TextEditingController();
  CustomPickerItem selectedItem;
  List<CustomPickerItem> targetList;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialValue;
    targetList = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.items.length > 3
          ? MediaQuery.of(context).size.height * 0.6
          : 200,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
        ),
      ),
      child: Column(
        children: [
          if (widget.showSearch) _searchSection(),
          Expanded(
            child: _itemsSection(),
          ),
        ],
      ),
    );
  }

  Widget _searchSection() => Stack(
        children: [
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.gray_light,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Container(
                width: double.maxFinite,
                child: TextField(
                  controller: searchTextController,
                  decoration: InputDecoration(
                    hintText: 'Buscar',
                    alignLabelWithHint: false,
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: AppColor.gray, fontSize: 12),
                  ),
                  autofocus: false,
                  enabled: true,
                  onChanged: (value) {
                    if (value.length > 2)
                      setState(() {
                        _filterTargetList(value);
                      });
                    else
                      setState(() {
                        targetList = widget.items;
                      });
                  },
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (searchTextController.text.isNotEmpty)
                    InkWell(
                      child: Icon(
                        Icons.close_rounded,
                        color: AppColor.gray,
                        size: 24,
                      ),
                      onTap: () {
                        setState(() {
                          searchTextController.text = '';
                          targetList = widget.items;
                        });
                      },
                    ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      );

  Widget _itemsSection() => ListView.builder(
        itemCount: targetList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return item(targetList[index]);
        },
      );

  Widget item(CustomPickerItem model) => InkWell(
        onTap: () async {
          widget.onTap(model);
          NavigationUtils.pop(context);
        },
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _status(model.displayInfo == selectedItem?.displayInfo),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      model.displayInfo,
                      style: TextStyle(
                        color: AppColor.text_color,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _separator(),
          ],
        ),
      );

  Widget _separator() => Container(
        margin: const EdgeInsets.only(
          top: 5,
        ),
        child: Container(
          color: AppColor.gray,
          width: double.maxFinite,
          height: 0.5,
        ),
      );

  Widget _status(bool selected) => selected
      ? Icon(
          CupertinoIcons.smallcircle_fill_circle,
          color: AppColor.blue_dark,
        )
      : Icon(
          CupertinoIcons.circle,
          color: AppColor.blue_dark,
        );

  void _filterTargetList(String query) {
    targetList = widget.items
        .where((element) =>
            element.displayInfo.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

class CustomPickerItem<T> {
  T value;
  String displayInfo;

  CustomPickerItem({this.value, this.displayInfo});
}

void showCustomPicker({
  Function(CustomPickerItem) onTap,
  BuildContext context,
  List<CustomPickerItem> items,
  CustomPickerItem initialValue,
  bool showSearch = true,
}) {
  showZModalBottomSheet2(
    context: context,
    color: AppColor.gray.withOpacity(0.7),
    builder: (context) => _CustomPicker(
      items: items,
      onTap: onTap,
      initialValue: initialValue,
      showSearch: showSearch,
    ),
  );
}
