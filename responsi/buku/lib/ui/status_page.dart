import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/status_bloc.dart';
import '/model/status.dart';
import '/ui/status_detail.dart';
import '/ui/status_form.dart';
import 'login_page.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Status',
          style: TextStyle(
            fontFamily: 'ComicSans', // Font Comic Sans
          ),
        ),
        backgroundColor: Colors.orange, // Warna AppBar oranye
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatusForm()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'ComicSans',
                  color: Colors.orange, // Warna teks oranye
                ),
              ),
              trailing: const Icon(Icons.logout, color: Colors.orange),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      )
                    });
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: StatusBloc.getStatuses(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListStatus(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      backgroundColor: Colors.yellow[100], // Warna latar belakang kuning muda
    );
  }
}

class ListStatus extends StatelessWidget {
  final List? list;

  const ListStatus({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemStatus(
          status: list![i],
        );
      },
    );
  }
}

class ItemStatus extends StatelessWidget {
  final Status status;

  const ItemStatus({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StatusDetail(
              status: status,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.orange[50], // Warna latar belakang kartu oranye muda
        child: ListTile(
          title: Text(
            status.availability!,
            style: const TextStyle(
              fontFamily: 'ComicSans', // Font Comic Sans
              color: Colors.orange, // Warna teks oranye
            ),
          ),
          subtitle: Text(
            status.borrower_name ?? "N/A",
            style: const TextStyle(
              fontFamily: 'ComicSans', // Font Comic Sans
            ),
          ),
          trailing: Text(
            status.due_days.toString(),
            style: const TextStyle(
              fontFamily: 'ComicSans', // Font Comic Sans
            ),
          ),
        ),
      ),
    );
  }
}
