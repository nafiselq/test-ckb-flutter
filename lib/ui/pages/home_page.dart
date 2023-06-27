import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:karyawan_it/ui/widget/form.dart';

import '../../data/bloc/karyawan/karyawan_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final HDTRefreshController _hdtRefreshController = HDTRefreshController();

    Widget getTitleItemWidget(String label, double width) {
      return Container(
        width: width,
        height: 56,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      );
    }

    List<Widget> getTitleWidget() {
      return [
        getTitleItemWidget('Name', 100),
        getTitleItemWidget('NIK', 90),
        getTitleItemWidget('Tempat Lahir', 90),
        getTitleItemWidget('Tanggal Lahir', 90),
        getTitleItemWidget('Jenis Kelamin', 90),
        getTitleItemWidget('Alamat', 90),
        getTitleItemWidget('Action', 100),
      ];
    }

    Widget content() {
      return BlocProvider(
        create: (context) => KaryawanBloc()..add(KaryawanGet()),
        child: BlocBuilder<KaryawanBloc, KaryawanState>(
          builder: (context, state) {
            if (state is KaryawanSuccess) {
              Widget generateFirstColumnRow(BuildContext context, int index) {
                return Container(
                  width: 100,
                  height: 52,
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(state.karyawans[index].name.toString()),
                );
              }

              Widget generateRightHandSideColumnRow(
                  BuildContext context, int index) {
                return Row(
                  children: <Widget>[
                    Container(
                      width: 90,
                      height: 52,
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text(state.karyawans[index].nik.toString()),
                    ),
                    Container(
                      width: 90,
                      height: 40,
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text(state.karyawans[index].tempat.toString()),
                    ),
                    Container(
                      width: 90,
                      height: 52,
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        DateFormat.yMMMd('id').format(
                          state.karyawans[index].tglLahir!,
                        ),
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 52,
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      child:
                          Text(state.karyawans[index].jenisKelamin.toString()),
                    ),
                    Container(
                      width: 90,
                      height: 52,
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text(state.karyawans[index].alamat.toString()),
                    ),
                    Container(
                      width: 100,
                      height: 52,
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              context.read<KaryawanBloc>().add(
                                    DeletedKaryawan(
                                      int.parse(
                                        state.karyawans[index].id.toString(),
                                      ),
                                      DateTime.now(),
                                    ),
                                  );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    "Product Berhasil dihapus",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "Hapus",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return SizedBox(
                height: 500,
                child: HorizontalDataTable(
                  tableHeight: 500,
                  leftHandSideColumnWidth: 100,
                  rightHandSideColumnWidth: 600,
                  isFixedHeader: true,
                  headerWidgets: getTitleWidget(),
                  leftSideItemBuilder: generateFirstColumnRow,
                  rightSideItemBuilder: generateRightHandSideColumnRow,
                  itemCount: state.karyawans.length,
                  rowSeparatorWidget: const Divider(
                    color: Colors.black54,
                    height: 1.0,
                    thickness: 0.0,
                  ),
                  leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
                  rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
                  enablePullToRefresh: true,
                  refreshIndicator: const ClassicHeader(),
                  fixedSidePlaceHolderRefreshIndicator:
                      const PlaceholderHeader(),
                  refreshIndicatorHeight: 60,
                  onRefresh: () async {
                    debugPrint('onRefresh');
                    //Do sth
                    await Future.delayed(const Duration(milliseconds: 500));
                    _hdtRefreshController.refreshCompleted();
                  },
                  enablePullToLoadNewData: true,
                  loadIndicator: const ClassicFooter(),
                  fixedSidePlaceHolderLoadIndicator: const PlaceholderFooter(),
                  onLoad: () async {
                    debugPrint('onLoad');
                    //Do sth
                    await Future.delayed(const Duration(milliseconds: 500));
                    _hdtRefreshController.loadComplete();
                  },
                  htdRefreshController: _hdtRefreshController,
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    }

    void openModal(BuildContext context) {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ModalForm();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Karyawan Divisi IT",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  openModal(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text(
                  "Tambah Karyawan",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ),
          content(),
        ],
      ),
    );
  }
}
