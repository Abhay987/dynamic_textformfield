import 'package:flutter/material.dart';

class MyWidgets extends StatefulWidget {
  const MyWidgets({Key? key}) : super(key: key);

  @override
  State<MyWidgets> createState() => _MyWidgetsState();
}

class _MyWidgetsState extends State<MyWidgets> {
  List<TextEditingController> itemNameControllers = [];
  List<TextFormField> itemNameFields = [];
  List<TextEditingController> qtyControllers = [];
  List<TextFormField> qtyFields = [];
  List<TextEditingController> priceControllers = [];
  List<TextFormField> priceFields = [];
  List<TextEditingController> discControllers = [];
  List<TextFormField> discFields = [];
  List<String> invoiceList = [];
  List<num> listOfPrices = [];
  @override
  void dispose() {
    for (final controller in itemNameControllers) {
      controller.dispose();
    }
    for (final controller in qtyControllers) {
      controller.dispose();
    }
    for (final controller in priceControllers) {
      controller.dispose();
    }
    for (final controller in discControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Dynamic TextFormFields'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._getFriends(),
              const SizedBox(
                height: 20,
              ),
              FloatingActionButton(
                onPressed: () {
                  // invoiceList.insert(invoiceList.length,"${invoiceList.length}");
                  //setState((){});
                  final itemName = TextEditingController();
                  final qty = TextEditingController();
                  final price = TextEditingController();
                  final disc = TextEditingController();
                  final itemField = _generateTextFieldNew(itemName, "Item");
                  final qtyField = _generateTextField(qty, "Qty");
                  final priceField = _generateTextField(price, "Pr.");
                  final discField = _generateTextField(disc, "Disc(%)");
                  setState(() {
                    invoiceList.insert(
                        invoiceList.length, "${invoiceList.length}");
                    itemNameControllers.add(itemName);
                    qtyControllers.add(qty);
                    itemNameFields.add(itemField);
                    qtyFields.add(qtyField);
                    priceControllers.add(price);
                    discControllers.add(disc);
                    priceFields.add(priceField);
                    discFields.add(discField);
                  });
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(onPressed: () {}, child: const Text('Submit')),
              const SizedBox(
                height: 20,
              ),
              //  Text('${getTotalPrice()}'),
              //..._getTotalAmounts(),
            ],
          ),
        ],
      ),
    );
  }

  num getTotalPrice() {
    num numValue = 0;
    for (int i = 0; i < listOfPrices.length; i++) {
      numValue = listOfPrices[i] + numValue;
    }
    return numValue;
  }

  TextFormField _generateTextFieldNew(
      TextEditingController controller, String hint) {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        setState(() {});
      },
      controller: controller,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: hint,
      ),
    );
  }

  TextFormField _generateTextField(
      TextEditingController controller, String hint) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        setState(() {});
      },
      controller: controller,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: hint,
      ),
    );
  }

  List<Widget> _getFriends() {
    List<num> getTotalAmounts = [];
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < invoiceList.length; i++) {
      num? qty = num.tryParse(qtyControllers[i].text) ?? 0;
      num? price = num.tryParse(priceControllers[i].text) ?? 0;
      num? disc = num.tryParse(discControllers[i].text) ?? 0;
      num? total = qty * price;
      num? discPrice = total - (total * (disc / 100));
      debugPrint('Discount price is : $discPrice  & index is  :  $i');
      getTotalAmounts.insert(i, discPrice);
      listOfPrices = getTotalAmounts;
      friendsTextFields.add(Row(
        children: [
          Expanded(child: Text("$discPrice")),
          Expanded(child: itemNameFields[i]),
          Expanded(child: qtyFields[i]),
          Expanded(child: priceFields[i]),
          Expanded(child: discFields[i]),
          _addRemoveButton(i),
        ],
      ));
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(int index) {
    return InkWell(
      onTap: () {
        itemNameControllers.removeAt(index);
        itemNameFields.removeAt(index);
        invoiceList.removeAt(index);
        qtyFields.removeAt(index);
        qtyControllers.removeAt(index);
        priceFields.removeAt(index);
        priceControllers.removeAt(index);
        discFields.removeAt(index);
        discControllers.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}
