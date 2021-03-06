import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  static List<String> friendsList = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name textfield
                  const Text(
                    'Add Friends',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  ..._getFriends(),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    child: FloatingActionButton(
                      onPressed: () {
                        friendsList.insert(friendsList.length, "");
                        setState(() {});
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// get firends text-fields
  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < friendsList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: FriendTextFields(i)),
            const SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == 0, i),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          friendsList.insert(friendsList.length, "");
        } else {
          friendsList.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class FriendTextFields extends StatefulWidget {
  final int index;
  // ignore: use_key_in_widget_constructors
  const FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _MyFormState.friendsList[widget.index];
    });

    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: TextFormField(
            controller: _nameController,
            onChanged: (v) => _MyFormState.friendsList[widget.index] = v,
            decoration:
                const InputDecoration(hintText: 'Enter your friend\'s name'),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: TextFormField(
            controller: _nameController,
            onChanged: (v) => _MyFormState.friendsList[widget.index] = v,
            decoration:
                const InputDecoration(hintText: 'Enter your friend\'s name'),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: TextFormField(
            controller: _nameController,
            onChanged: (v) => _MyFormState.friendsList[widget.index] = v,
            decoration:
                const InputDecoration(hintText: 'Enter your friend\'s name'),
          ),
        ),
      ],
    );
  }
}
