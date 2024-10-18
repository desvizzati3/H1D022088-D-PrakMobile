import 'package:flutter/material.dart';
import '../bloc/status_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/status.dart';
import '/ui/status_form.dart';
import 'status_page.dart';

// ignore: must_be_immutable
class StatusDetail extends StatefulWidget {
  Status? status;

  StatusDetail({Key? key, this.status}) : super(key: key);

  @override
  _StatusDetailState createState() => _StatusDetailState();
}

class _StatusDetailState extends State<StatusDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Status',
          style: TextStyle(fontFamily: 'Comic Sans MS', color: Colors.orange),
        ),
        backgroundColor: Colors.yellow[800], // Darker yellow for the app bar
      ),
      body: Container(
        color: Colors.yellow[100], // Set a light yellow background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Availability: ${widget.status!.availability}",
                style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Comic Sans MS',
                    color: Colors.orange),
              ),
              Text(
                "Borrower Name: ${widget.status!.borrower_name}",
                style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Comic Sans MS',
                    color: Colors.orange),
              ),
              Text(
                "Due Days: ${widget.status!.due_days}",
                style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Comic Sans MS',
                    color: Colors.orange),
              ),
              _tombolHapusEdit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Edit Button
        OutlinedButton(
          child: const Text("EDIT",
              style:
                  TextStyle(fontFamily: 'Comic Sans MS', color: Colors.orange)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StatusForm(
                  status: widget.status!,
                ),
              ),
            );
          },
        ),
        // Delete Button
        OutlinedButton(
          child: const Text("DELETE",
              style:
                  TextStyle(fontFamily: 'Comic Sans MS', color: Colors.orange)),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?",
          style: TextStyle(fontFamily: 'Comic Sans MS')),
      actions: [
        // Confirm Delete Button
        OutlinedButton(
          child: const Text("Ya",
              style:
                  TextStyle(fontFamily: 'Comic Sans MS', color: Colors.orange)),
          onPressed: () {
            StatusBloc().deleteStatus(widget.status!.id!).then(
              (value) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const StatusPage()));
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
        // Cancel Button
        OutlinedButton(
          child: const Text("Batal",
              style:
                  TextStyle(fontFamily: 'Comic Sans MS', color: Colors.orange)),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
