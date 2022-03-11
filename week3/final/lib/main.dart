import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab23/ExpenseListModel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Expense.dart';

class FormPage extends StatefulWidget {
  FormPage({Key? key, required this.id, required this.expenses})
      : super(key: key);
  final int id;
  final ExpenseListModel expenses;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
/*
  _FormPageState({Key ? key, required this.id, required this.expenses});
*/

/*  final int id;
  final ExpenseListModel expenses;*/
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  double _amount = 0.0;
  DateTime _date = DateTime.now();
  String _category = "";

  void _submit() {
    final form = formKey.currentState;
    if (form != null) {
      form.save();
      if (widget.id == 0)
        widget.expenses.add(Expense(0, _amount, _date, _category));
      else
        widget.expenses.update(Expense(widget.id, _amount, _date, _category));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Enter expense details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                    icon: const Icon(Icons.monetization_on),
                    labelText: 'Amount',
                    labelStyle: TextStyle(fontSize: 18)),
                validator: (val) {
                  Pattern pattern = r'^[1-9]\d*(\.\d+)?$';
                  RegExp regex = RegExp(pattern.toString());
                  if (!regex.hasMatch(val!))
                    return 'Enter a valid number';
                  else
                    return null;
                },
                initialValue: widget.id == 0
                    ? ''
                    : widget.expenses.byId(widget.id)!.amount.toString(),
                onSaved: (val) => _amount = double.parse(val!),
              ),
              TextFormField(
                style: TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  hintText: 'Enter date',
                  labelText: 'Date',
                  labelStyle: TextStyle(fontSize: 18),
                ),
                validator: (val) {
                  Pattern pattern =
                      r'/\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$';
                  RegExp regex = RegExp(pattern.toString());
                  if (!regex.hasMatch(val!))
                    return 'Enter a valid date';
                  else
                    return null;
                },
                onSaved: (val) => _date = DateTime.parse(val!),
                initialValue: widget.id == 0
                    ? ''
                    : widget.expenses.byId(widget.id)!.formattedDate,
                keyboardType: TextInputType.datetime,
              ),
              TextFormField(
                style: TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                    icon: const Icon(Icons.category),
                    labelText: 'Category',
                    labelStyle: TextStyle(fontSize: 18)),
                onSaved: (val) => _category = val!,
                initialValue: widget.id == 0
                    ? ''
                    : widget.expenses.byId(widget.id)!.category.toString(),
              ),
              ElevatedButton(
                onPressed: _submit,
                child: new Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final expense = ExpenseListModel();

  runApp(ScopedModel<ExpenseListModel>(model: expense, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INT3120 20',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Lesson 23'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ScopedModelDescendant<ExpenseListModel>(
          builder: (context, child, model) {
            return ListView.separated(
              itemCount: model.items == null ? 1 : model.items.length + 1,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return ListTile(
                    title: Text(
                      "Total expenses: " + model.totalExpense.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  index = index - 1;
                  return Dismissible(
                    key: Key(model.items[index].id.toString()),
                    onDismissed: (direction) {
                      model.delete(model.items[index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Item with id, " +
                              model.items[index].id.toString() +
                              " is dismissed"),
                        ),
                      );
                    },
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormPage(
                              id: model.items[index].id,
                              expenses: model,
                            ),
                          ),
                        );
                      },
                      leading: const Icon(Icons.monetization_on),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      title: Text(
                        model.items[index].category +
                            ": " +
                            model.items[index].amount.toString() +
                            " \nspent on " +
                            model.items[index].formattedDate,
                        style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: ScopedModelDescendant<ExpenseListModel>(
        builder: (context, child, expenses) {
          return FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScopedModelDescendant<ExpenseListModel>(
                    builder: (context, child, expenses) {
                      return FormPage(
                        id: 0,
                        expenses: expenses,
                      );
                    },
                  ),
                ),
              );
            },
            tooltip: 'Add',
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
