import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesmen_app/model/customerListModel.dart';
import 'package:salesmen_app/model/customerModel.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/others/widgets.dart';
import 'package:salesmen_app/search_field.dart';

class SearchScreen extends StatefulWidget {
  List<CustomerListModel> customerModel;
  double lat, long;
  SearchScreen({required this.customerModel, required this.lat, required this.long});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int listLength = 0;
  late bool _isSearching;
  var f = NumberFormat("###,###.0#", "en_US");
  bool isLoading = false;
  List<String> menuButton = ["DIRECTION",'EDIT SHOP'];
  @override
  void initState() {
    super.initState();
    _isSearching = false;
    getAllCustomerData();
    listLength = 3;
  }

  int i = 0;
  List<CustomerListModel> _list = [];
  List<CustomerListModel> customersearchresult = [];
  Future getAllCustomerData() async {
    for (var item in widget.customerModel) {
      if (i < widget.customerModel.length) {
        _list.add(CustomerListModel(
            id:widget.customerModel[i].id,
            custName: widget.customerModel[i].custName,
          custAddress: widget.customerModel[i].custAddress,
          custPrimNb: widget.customerModel[i].custPrimNb,
          distance: widget.customerModel[i].distance,
          verified: widget.customerModel[i].verified,
          lat: widget.customerModel[i].lat,
          long: widget.customerModel[i].long,
          salemanName: widget.customerModel[i].salemanName,
        ));

        i++;
      } else {
        print("else work");
      }
    }
    print("customer list " + _list.length.toString());
  }

  final TextEditingController _controller = new TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double height = media.height;
    double width = media.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor1,
        title: Text("Search Screen"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.025,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SearchField(enable: true,onTap:(){},controller: _controller,onchange: searchOperation,),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          customersearchresult.length != 0 || _controller.text.isNotEmpty
              ? Expanded(
                  child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (_scrollController.position.pixels ==
                            _scrollController.position.maxScrollExtent) {
                          //  double temp=0.01;
                          setState(() {
                            if (listLength + 1 < customersearchresult.length) {
                              listLength += 1;
                            } else {
                              int temp =
                                  customersearchresult.length - listLength;
                              listLength = listLength + temp;
                            }
                          });
                          //print('temp value is'+listLength.toString());
                        }
                        if (_scrollController.position.pixels ==
                            _scrollController.position.minScrollExtent) {
                          //  print('start scroll');
                        }
                        return false;
                      },
                      child: DraggableScrollbar.rrect(
                        controller: _scrollController,
                        heightScrollThumb: 48.0,
                        backgroundColor: themeColor1,
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: customersearchresult.length>10?10:customersearchresult.length,
                            itemBuilder:(context,index){
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child:
                                CustomerCard(
                                  height: height,
                                  width: width,
                                  f: f,
                                  menuButton: menuButton,
                                  code: customersearchresult[index].id,
                                  category: customersearchresult[index].id,
                                  shopName: customersearchresult[index].custName,
                                  address:customersearchresult[index].custAddress,
                                  name: customersearchresult[index].custName,
                                  phoneNo: customersearchresult[index].custPrimNb,
                                  lastVisit: "--",
                                  dues: "--",
                                  lastTrans:"--",
                                  outstanding: "--",
                                  lat: customersearchresult[index].lat,
                                  long: customersearchresult[index].long,
                                  customerData: customersearchresult[index],
                                  image:
                                  "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimages.indianexpress.com%2F2021%2F12%2Fdoctor-strange-2-1200.jpg&imgrefurl=https%3A%2F%2Findianexpress.com%2Farticle%2Fentertainment%2Fhollywood%2Fdoctor-strange-2-suggest-benedict-cumberbatch-sorcerer-supreme-might-lead-avengers-7698058%2F&tbnid=GxuE_SM1fXrAqM&vet=12ahUKEwjr4bj575_3AhVMxqQKHSC5BRAQMygBegUIARDbAQ..i&docid=6gb_YRZyTk5MWM&w=1200&h=667&q=dr%20strange&ved=2ahUKEwjr4bj575_3AhVMxqQKHSC5BRAQMygBegUIARDbAQ",
                                  showLoading: (value) {
                                    setState(() {
                                      isLoading = value;
                                    });
                                  },
                                ),
                              );
                            }
                        ),
                      )),
                )
              : Container(),
        ],
      ),
    );
  }

  void searchOperation(String searchText) {
    if (_isSearching != null) {
      customersearchresult.clear();
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i].custName.toString();
        String data1 = _list[i].id.toString();

        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          print("search by name");
          customersearchresult.addAll([_list[i]]);
          setState(() {});
        }else if(data1.toLowerCase().contains(searchText.toLowerCase())) {
          print("search by code");
          customersearchresult.addAll([_list[i]]);
          setState(() {});
        }
      }
      print("result is: " + customersearchresult.length.toString());
    }
  }
}
