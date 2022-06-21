import 'package:dynamic_textformfield/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_textformfield/show_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyWidgets(),
    );
  }
}

class _View3 extends StatefulWidget {
  @override
  _View3State createState() => _View3State();
}

class _View3State extends State<_View3> {
  final List<TextEditingController> _nameControllers = [];
  final List<TextField> _nameFields = [];
  final List<TextEditingController> _telControllers = [];
  final List<TextField> _telFields = [];
  final List<TextEditingController> _addressControllers = [];
  final List<TextField> _addressFields = [];

  @override
  void dispose() {
    for (final controller in _nameControllers) {
      controller.dispose();
    }
    for (final controller in _telControllers) {
      controller.dispose();
    }
    for (final controller in _addressControllers) {
      controller.dispose();
    }
    _okController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Dynamic Group Text Field"),
          ),
          body: Column(
            children: [
              Expanded(child: _listView()),
              _addTile(),
              _okButton(context),
            ],
          )),
    );
  }

  Widget _addTile() {
    return ListTile(
      title: const Icon(Icons.add),
      onTap: () {
        final name = TextEditingController();
        final tel = TextEditingController();
        final address = TextEditingController();

        final nameField = _generateTextField(name, "name");
        final telField = _generateTextField(tel, "mobile");
        final addressField = _generateTextField(address, "address");

        setState(() {
          _nameControllers.add(name);
          _telControllers.add(tel);
          _addressControllers.add(address);
          _nameFields.add(nameField);
          _telFields.add(telField);
          _addressFields.add(addressField);
        });
      },
    );
  }

  TextField _generateTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: hint,
      ),
    );
  }

  Widget _listView() {
    final children = [
      for (var i = 0; i < _nameControllers.length; i++)
        Container(
          margin: const EdgeInsets.all(5),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: i.toString(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Column(
              children: [
                _nameFields[i],
                _telFields[i],
                _addressFields[i],
              ],
            ),
          ),
        )
    ];
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  final _okController = TextEditingController();
  Widget _okButton(BuildContext context) {
    final textField = TextField(
      controller: _okController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );

    final button = ElevatedButton(
      onPressed: () async {
        String text = _nameControllers
            .where((element) => element.text != "")
            .fold("", (acc, element) => acc += "${element.text}\n");
        text = text +
            _telControllers
                .where((element) => element.text != "")
                .fold("", (acc, element) => acc += "${element.text}\n");
        text = text +
            _addressControllers
                .where((element) => element.text != "")
                .fold("", (acc, element) => acc += "${element.text}\n");
        /*  final index = int.parse(_okController.text);
        String text = "name: ${_nameControllers[index].text}\n" +
            "tel: ${_telControllers[index].text}\n" +
            "address: ${_addressControllers[index].text}";*/
        await showMessage(context, text, "Result");
      },
      child: const Text("OK"),
    );

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 100,
          height: 50,
          child: textField,
        ),
        button,
      ],
    );
  }
}

class _View1 extends StatefulWidget {
  @override
  _View1State createState() => _View1State();
}

class _View1State extends State<_View1> {
  final List<TextEditingController> _controllers = [];
  final List<TextField> _fields = [];

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Dynamic Text Field"),
          ),
          body: Column(
            children: [
              _addTile(),
              Expanded(child: _listView()),
              _okButton(),
            ],
          )),
    );
  }

  Widget _addTile() {
    return ListTile(
      title: const Icon(Icons.add),
      onTap: () {
        final controller = TextEditingController();
        final field = TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: "name${_controllers.length + 1}",
          ),
        );

        setState(() {
          _controllers.add(controller);
          _fields.add(field);
        });
      },
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _fields.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(5),
          child: _fields[index],
        );
      },
    );
  }

  Widget _okButton() {
    return ElevatedButton(
      onPressed: () async {
        String text = _controllers
            .where((element) => element.text != "")
            .fold("", (acc, element) => acc += "${element.text}\n");
        final alert = AlertDialog(
          title: Text("Count: ${_controllers.length}"),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
        await showDialog(
          context: context,
          builder: (BuildContext context) => alert,
        );
        setState(() {});
      },
      child: const Text("OK"),
    );
  }
}
