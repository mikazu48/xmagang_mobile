import 'dart:convert';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:magangskipsi/globals.dart' as globals;
import 'package:magangskipsi/shared/theme.dart';
import 'package:magangskipsi/ui/widget/custom_button.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';

import 'package:path_provider/path_provider.dart';

import '../../globals.dart';

int itemCount = 0;

class DocumentData {
  final String? id;
  final String? jenis_pengajuan;
  final String? no_pengajuan;
  final String? nama_file;
  final String? link_download;

  DocumentData(
      {this.id,
      this.jenis_pengajuan,
      this.no_pengajuan,
      this.nama_file,
      this.link_download});

  factory DocumentData.fromJson(Map<String, dynamic> json) {
    return DocumentData(
        id: json['id'],
        jenis_pengajuan: json['jenis_pengajuan'],
        no_pengajuan: json['no_pengajuan'],
        nama_file: json['nama_file'],
        link_download:
            globals.BASE_URL + "public/pubsdownload/" + json['nama_file']);
  }
}

var dio = new Dio();
CoreFacade cf = new CoreFacade();

Future<List<DocumentData>> fetchData() async {
  globals.Sessions_UserID = "2";
  final response = await http.get(Uri.parse(
      globals.API_URL + "document_magang/" + globals.Sessions_UserID));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new DocumentData.fromJson(data)).toList();
  } else {
    throw Exception('Telah terjadi error !!');
  }
}

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  Future<List<DocumentData>>? futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API and ListView Example',
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<DocumentData>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DocumentData>? data = snapshot.data;
                return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return showDocumentItems(data[index]);
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Future downloadfromUrl(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: cf.showLoaderDialog(context),
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print("Link Download : " + url);
      print(response.headers);
      if (response.headers.value("content-disposition") == null ||
          !response.headers
              .value("content-disposition")
              .toString()
              .contains("attachment")) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Download gagal, format API salah ! \n\n" + url)));
        Navigator.pop(context);
        return;
      }
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Download file sukses! " + file.path.toString())));
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);
    OpenFile.open(savePath);
  }

  Widget showDocumentItems(DocumentData dcd) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          dcd.jenis_pengajuan.toString(),
                          textAlign: TextAlign.left,
                          style: textBlackStyle.copyWith(
                              fontSize: 25,
                              fontWeight: semiBold,
                              color: Colors.green),
                        ),
                        Text(
                          "No Pengajuan : " + dcd.no_pengajuan.toString(),
                          textAlign: TextAlign.left,
                          style: textBlackStyle.copyWith(
                            fontSize: 12,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Container(
            width: 170,
            height: 50,
            child: CustomButton(
              title: 'Download File',
              onPressed: () async {
                var tempDir = await getApplicationDocumentsDirectory();
                String fullPath = tempDir.path + "/" + dcd.nama_file.toString();

                downloadfromUrl(dio, dcd.link_download.toString(), fullPath);
              },
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
