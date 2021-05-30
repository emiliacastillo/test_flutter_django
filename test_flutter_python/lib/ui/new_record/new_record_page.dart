import 'package:test_flutter_python/domain/model.dart';
import 'package:test_flutter_python/ui/_base/_tx/tx_button.dart';
import 'package:test_flutter_python/ui/_base/_tx/tx_text.dart';
import 'package:test_flutter_python/ui/_base/_tx/tx_textfield.dart';
import 'package:test_flutter_python/ui/_base/_tx/tx_validator.dart';
import 'package:test_flutter_python/ui/_base/bloc_state.dart';
import 'package:test_flutter_python/ui/_base/loading_full_page.dart';
import 'package:test_flutter_python/ui/_base/on_init_widget.dart';
import 'package:test_flutter_python/ui/home/home_page.dart';
import 'package:test_flutter_python/ui/new_record/new_record_bloc.dart';
import 'package:test_flutter_python/utils/app_color.dart';
import 'package:test_flutter_python/utils/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:date_format/date_format.dart';

class NewRecordPage extends StatefulWidget {
  final Model model;
  final String serverDeveloperHost;

  NewRecordPage({
    this.model,
    this.serverDeveloperHost
  });

  @override
  _NewRecordPageState createState() => _NewRecordPageState();
}

class _NewRecordPageState extends StateWithBloC<NewRecordPage, NewRecordBloC> {
  final _keyForm = new GlobalKey<FormState>();

  double _height, _width;

////////////////////////////

  final titleController = TextEditingController();
  Model modelsaved;

///////////////////////

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      modelsaved = widget.model;
      titleController.text = widget.model.title;
    }

    bloc.saveTicketStream.listen((event) async {
      if (event) {
        Fluttertoast.showToast(
          msg: 'Successful',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
        );
        NavigationUtils.pop(context);
        NavigationUtils.push(context, MyHomePage());
      }
    });

       bloc.deleteTicketStream.listen((event) async {
      if (event) {
        Fluttertoast.showToast(
          msg: 'Successful',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
        );
        NavigationUtils.pop(context,result: true);
        //NavigationUtils.push(context, MyHomePage());
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
    return _body();
  }

  _body() => Scaffold(
        appBar: _appBarButtons(),     
        body: Stack(
          children: [
            OnInitWidget(
              onInit: registerErrorStream,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Card(
                  color: AppColor.gray_light,
                  margin: const EdgeInsets.only(top: 100, left: 10, right: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 60),
                    child: Form(
                      key: _keyForm,
                      child: Column(
                        children: <Widget>[
                          TXTextField(
                            label: 'Task Title',
                            inputType: TextInputType.text,
                            controller: titleController,
                            //inputCapitalization: TextCapitalization.words,
                            validator: TXValidator.required(context),
                            enable: true,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.maxFinite,
                            child: TXButton(
                              text: 'Save',
                              color: Colors.white,
                              onPressed: () {
                                if (_keyForm.currentState.validate()) {
                                  _save();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            LoadingFullPageWidget(
              stream: bloc.isLoadingStream,
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
        backgroundColor: Colors.white,
      );
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

  _actionsButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_rounded),
                        onPressed: () async {
                          NavigationUtils.pop(context, result: true);
                        },
                        color: AppColor.blue,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [             
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete_rounded),
                        onPressed: () async {
                          _delete();
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
          ),
        ],
      );

  ///Save
  void _save() {
    if (modelsaved == null)
      bloc.saveTicket(Model(id: null, title: titleController.text),widget.serverDeveloperHost);
    else
      bloc.saveTicket(Model(id: modelsaved.id, title: titleController.text),widget.serverDeveloperHost);
  }

  void _delete() {
    if (modelsaved != null)
      bloc.deleteTicket(modelsaved,widget.serverDeveloperHost);
  }
}
