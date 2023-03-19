import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopzmclay/provider/product_provider.dart';

class AttriputesTabScreen extends StatefulWidget {
  @override
  State<AttriputesTabScreen> createState() => _AttriputesTabScreenState();
}

class _AttriputesTabScreenState extends State<AttriputesTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  final TextEditingController _sizeController = TextEditingController();

  List<String> _sizeList = [];

  bool _entered = false;

  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter Brand Name';
              } else {
                return null;
              }
            },
            onChanged: (value) {
              _productProvider.getFormData(brandName: value);
            },
            decoration: InputDecoration(labelText: 'Brand'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Container(
                  width: 100,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Size';
                      } else {
                        return null;
                      }
                    },
                    controller: _sizeController,
                    onChanged: (value) {
                      setState(() {
                        _entered = true;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Size'),
                  ),
                ),
              ),
              _entered == true
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow.shade900,
                      ),
                      onPressed: () {
                        setState(() {
                          _sizeList.add(_sizeController.text);
                          _sizeController.clear();
                          _isSaved = false;
                        });
                        print(_sizeList);
                      },
                      child: Text('Add'),
                    )
                  : Text('')
            ],
          ),
          if (_sizeList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _sizeList.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _sizeList.removeAt(index);
                              _productProvider.getFormData(sizeList: _sizeList);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.yellow.shade900,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _sizeList[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
              ),
            ),
          if (_sizeList.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                _productProvider.getFormData(sizeList: _sizeList);
                setState(() {
                  _isSaved = true;
                });
              },
              child: Text(
                _isSaved ? 'Saved' : 'Save',
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3),
              ),
            ),
        ],
      ),
    );
  }
}
