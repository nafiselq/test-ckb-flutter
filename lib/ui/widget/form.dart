import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karyawan_it/data/bloc/karyawan/karyawan_bloc.dart';
import 'package:karyawan_it/data/models/karyawan_model.dart';

class ModalForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ModalForm({super.key});

  @override
  Widget build(BuildContext context) {
    final jobC = TextEditingController();
    final nameC = TextEditingController();
    final nikC = TextEditingController();
    final tempatC = TextEditingController();
    final tgllhrC = TextEditingController();
    final jkC = TextEditingController();
    final alamatC = TextEditingController();

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              TextFormField(
                controller: jobC,
                decoration: InputDecoration(labelText: 'Job Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your job title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: nameC,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: nikC,
                decoration: InputDecoration(labelText: 'Nik'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your nik';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: tempatC,
                decoration: InputDecoration(labelText: 'Tempat Lahir'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your tempat lahir';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: tgllhrC,
                decoration: InputDecoration(labelText: 'Tanggal Lahir'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your tanggal lahir';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: jkC,
                decoration: InputDecoration(labelText: 'Jenis Kelamin'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your jenis kelamin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: alamatC,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your alamat';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var data = {
                      'titeJobs': jobC.text,
                      'name': nameC.text,
                      'nik': nikC.text,
                      'tempat': tempatC.text,
                      'jenisKelamin': jkC.text,
                      'alamat': alamatC.text,
                    };

                    print("ini adalah data $data");
                    // Process form data
                    context.read<KaryawanBloc>().add(KaryawanAdd(
                        jobC.text,
                        nameC.text,
                        int.parse(nikC.text),
                        tempatC.text,
                        DateTime.parse(tgllhrC.text),
                        jkC.text,
                        alamatC.text));
                    // Close the modal
                    // Navigator.pop(context);
                  }
                },
                child: BlocBuilder<KaryawanBloc, KaryawanState>(
                  builder: (context, state) {
                    if (state is KaryawanLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is KaryawanFailed) {
                      return Text("Gagal lOGIN");
                    }
                    return Text('Submit');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
