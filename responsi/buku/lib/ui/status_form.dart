import 'package:flutter/material.dart';
import '../bloc/status_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/status.dart';
import 'status_page.dart';

// ignore: must_be_immutable
class StatusForm extends StatefulWidget {
  Status? status;
  StatusForm({Key? key, this.status}) : super(key: key);

  @override
  _StatusFormState createState() => _StatusFormState();
}

class _StatusFormState extends State<StatusForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH STATUS";
  String tombolSubmit = "SIMPAN";
  final _availabilityTextboxController = TextEditingController();
  final _borrowerNameTextboxController = TextEditingController();
  final _dueDaysTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.status != null) {
      setState(() {
        judul = "UBAH STATUS";
        tombolSubmit = "UBAH";
        _availabilityTextboxController.text = widget.status!.availability!;
        _borrowerNameTextboxController.text =
            widget.status!.borrower_name ?? "";
        _dueDaysTextboxController.text = widget.status!.due_days.toString();
      });
    } else {
      judul = "TAMBAH STATUS";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(judul,
              style: TextStyle(
                  fontFamily: 'Comic Sans MS', color: Colors.orange))),
      body: Container(
        color: Colors.yellow[100], // Set a light yellow background color
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _availabilityTextField(),
                  _borrowerNameTextField(),
                  _dueDaysTextField(),
                  _buttonSubmit()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Create Availability Textbox
  Widget _availabilityTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Availability"),
      keyboardType: TextInputType.text,
      controller: _availabilityTextboxController,
      style: const TextStyle(fontFamily: 'Comic Sans MS', color: Colors.orange),
      validator: (value) {
        if (value!.isEmpty) {
          return "Availability harus diisi";
        }
        return null;
      },
    );
  }

  // Create Borrower Name Textbox
  Widget _borrowerNameTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Borrower Name"),
      keyboardType: TextInputType.text,
      controller: _borrowerNameTextboxController,
      style: const TextStyle(fontFamily: 'Comic Sans MS', color: Colors.orange),
      validator: (value) {
        if (value!.isEmpty) {
          return "Borrower Name harus diisi";
        }
        return null;
      },
    );
  }

  // Create Due Days Textbox
  Widget _dueDaysTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Due Days"),
      keyboardType: TextInputType.number,
      controller: _dueDaysTextboxController,
      style: const TextStyle(fontFamily: 'Comic Sans MS', color: Colors.orange),
      validator: (value) {
        if (value!.isEmpty) {
          return "Due Days harus diisi";
        }
        return null;
      },
    );
  }

  // Create Save/Update Button
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit,
          style: const TextStyle(
              fontFamily: 'Comic Sans MS', color: Colors.orange)),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.status != null) {
              // Update status condition
              ubah();
            } else {
              // Add status condition
              simpan();
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Status createStatus = Status(id: null);
    createStatus.availability = _availabilityTextboxController.text;
    createStatus.borrower_name = _borrowerNameTextboxController.text;
    createStatus.due_days = int.parse(_dueDaysTextboxController.text);

    StatusBloc.addStatus(status: createStatus).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const StatusPage(),
      ));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });

    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Status updateStatus = Status(id: widget.status!.id!);
    updateStatus.availability = _availabilityTextboxController.text;
    updateStatus.borrower_name = _borrowerNameTextboxController.text;
    updateStatus.due_days = int.parse(_dueDaysTextboxController.text);

    StatusBloc()
        .updateStatus(
      updateStatus.id!,
      updateStatus.availability!,
      updateStatus.borrower_name!,
      updateStatus.due_days!,
    )
        .then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const StatusPage(),
      ));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Ubah gagal, silahkan coba lagi",
        ),
      );
    });

    setState(() {
      _isLoading = false;
    });
  }
}
