import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_flutter_python/domain/model.dart';
import 'package:test_flutter_python/ui/_base/_tx/tx_text.dart';
import 'package:test_flutter_python/ui/_base/bloc_state.dart';
import 'package:test_flutter_python/ui/_base/loading_full_page.dart';
import 'package:test_flutter_python/ui/_base/on_init_widget.dart';
import 'package:test_flutter_python/ui/home/home_bloc.dart';
import 'package:test_flutter_python/ui/new_record/new_record_page.dart';
import 'package:test_flutter_python/utils/app_color.dart';
import 'package:test_flutter_python/utils/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String serverDeveloperHost;
  final bool fromLogin;
  MyHomePage({Key key, this.serverDeveloperHost,this.fromLogin = false}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends StateWithBloC<MyHomePage, HomeBloC> {
  final searchTextController = TextEditingController();
  Map<String, String> infoFromQrScan;
  bool collapse = true;
  double _height, _width;

  @override
  void initState() {
    super.initState();
    bloc.getlistTickets(widget.serverDeveloperHost);

    bloc.deleteTicketStream.listen((event) async {
      if (event) {
        Fluttertoast.showToast(
          msg: 'Successful',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
        );
        bloc.getlistTickets(widget.serverDeveloperHost);
      }
    });
  }

  void registerErrorStream(BuildContext cntx) {
    bloc.errorMessageStream.listen((error) {
      if (error != null)
        ScaffoldMessenger.of(cntx).showSnackBar(SnackBar(
          content: Text(error),
        ));
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _appBarButtons(),
      body: OnInitWidget(
        onInit: registerErrorStream,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 14,
                    ),
                    TXText(
                      'Task List',
                      color: AppColor.blue,
                    ),

                    ///este es el listado de las dosis
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StreamBuilder<List<Model>>(
                          stream: bloc.listTicketsStream,
                          initialData: null,
                          builder: (context, snapshot) {
                            final data = snapshot.data;
                            return Card(
                                color: AppColor.gray_light,
                                margin: const EdgeInsets.all(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _globalListDataItem(data),
                                  ),
                                ));
                          }),
                    ),
                  ],
                ),
              ),
            ),
            LoadingFullPageWidget(stream: bloc.isLoadingStream),
          ],
        ),
      ),
      backgroundColor: Colors
          .white, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _separator() => Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        child: Container(
          color: AppColor.gray,
          width: double.maxFinite,
          height: 0.5,
        ),
      );

  Widget _globalDataItemTickets(
          {String text, int value, Model model, Function action}) =>
      InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                    //width: 300,
                    padding: const EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    height: 30,
                    child: TXText(
                      '$text',
                      color: AppColor.blue,
                      fontSize: 16,
                    )),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Tooltip(
                          preferBelow: true,
                          message: 'View ticket',
                          child: IconButton(
                            icon: Icon(Icons.remove_red_eye_outlined),
                            onPressed: () async {
                              await NavigationUtils.push(
                                  context,
                                  NewRecordPage(
                                    model: model,
                                  )).then((value) => setState(() {
                                    bloc.getlistTickets(widget.serverDeveloperHost);
                                  }));
                            },
                            color: AppColor.blue,
                          ),
                        ),
                        TXText(
                          'View',
                          color: AppColor.blue,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete_rounded),
                          onPressed: () async {
                            bloc.deleteTicket(model,widget.serverDeveloperHost);
                          },
                          color: AppColor.blue,
                        ),
                        TXText(
                          'Delete ',
                          color: AppColor.blue,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        onTap: action ?? null,
      );

  _actionsButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TXText(
                'Welcome to My App',
                color: AppColor.blue,
                fontSize: 24,
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.add_rounded),
                        onPressed: () async {
                          await NavigationUtils.push(context, NewRecordPage());
                        },
                        color: AppColor.blue,
                      ),
                      TXText(
                        'New task',
                        color: AppColor.blue,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      );

  _appBarButtons() => PreferredSize(
        preferredSize: Size(double.maxFinite, 100),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.gray_bar,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            border: Border.all(color: AppColor.gray, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 22),
            child: Column(
              children: [
                _separator(),
                _actionsButtons(),
              ],
            ),
          ),
        ),
      );

  List<Widget> _globalListDataItem(List<Model> listtickets) {
    final List<Widget> listItems = [];
    if (listtickets != null) {
      for (var item in listtickets) {
        listItems.add(
          _globalDataItemTickets(
              value: item.id,
              text: item.title,
              model: item,
              action: () {
                return item;
              }),
        );
        listItems.add(_separator());
      }
    }

    return listItems;
  }
}
