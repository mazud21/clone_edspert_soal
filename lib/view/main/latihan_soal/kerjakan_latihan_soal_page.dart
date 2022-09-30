import 'package:clone_edspert_soal/controller_provider/load_data.dart';
import 'package:clone_edspert_soal/view/main/latihan_soal/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../../constants/r.dart';
import '../../../helpers/user_email.dart';
import '../../../models/kerjakan_soal_list.dart';
import '../../../models/network_response.dart';
import '../../../repository/latihan_soal_api.dart';

class KerjakanLatihanSoalPage extends StatefulWidget {
  const KerjakanLatihanSoalPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<KerjakanLatihanSoalPage> createState() =>
      _KerjakanLatihanSoalPageState();
}

class _KerjakanLatihanSoalPageState extends State<KerjakanLatihanSoalPage>
    with SingleTickerProviderStateMixin {

  /*KerjakanSoalList? loadData?.kerjakanSoalList;
  getQuestionList() async {
    final result = await LatihanSoalApi().postQuestionList(widget.id);
    if (result.status == Status.success) {
      loadData?.kerjakanSoalList = KerjakanSoalList.fromJson(result.data!);
      _controller = TabController(length: loadData?.kerjakanSoalList!.data!.length, vsync: this);
      _controller!.addListener(() {
        setState(() {});
      });
      setState(() {});
    }
  }*/

  LoadData? loadData;

  TabController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getQuestionList();
    load();
  }

  load(){
    loadData = Provider.of<LoadData>(context,listen: false);
    loadData?.getSoal(widget.id);

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        // Here you can write your code for open new view
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Latihan Soal")),
      // tombol selanjutnya atau submit
      bottomNavigationBar: _controller == null
          ? SizedBox(
              height: 0,
            )
          : Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: R.colors.primary,
                        fixedSize: Size(153, 33),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      if (_controller!.index == loadData!.kerjakanSoalList!.data!.length - 1) {
                        final result = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return BottomsheetConfirmation();
                            });
                        print(result);
                        if (result == true) {
                          print("kirim ke backend");
                          List<String> answer = [];
                          List<String> questionId = [];

                          loadData?.kerjakanSoalList!.data!.forEach((element) {
                            questionId.add(element.bankQuestionId!);
                            answer.add(element.studentAnswer!);
                          });

                          final payload = {
                            "user_email": UserEmail.getUserEmail(),
                            "exercise_id": widget.id,
                            "bank_question_id": questionId,
                            "student_answer": answer,
                          };
                          print(payload);

                          final result =
                              await LatihanSoalApi().postStudentAnswer(payload);
                          if (result.status == Status.success) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return ResultPage(
                                exerciseId: widget.id,
                              );
                            }));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Submit gagal. silahkan ulangi")));
                          }
                        }
                      } else {
                        _controller!.animateTo(_controller!.index + 1);
                      }
                    },
                    child: Text(_controller?.index == loadData?.kerjakanSoalList!.data!.length
                          ? "Kumpulin"
                          : "Selanjutnya",
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
      body: loadData?.kerjakanSoalList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                // TabBar no soal
                Container(
                  child: TabBar(
                    controller: _controller,
                    tabs: List.generate(
                      loadData?.kerjakanSoalList!.data!.length,
                      (index) => Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                // TabBarView soal dan pilihan jawaban
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(8),
                  child: TabBarView(
                      controller: _controller,
                      children: List.generate(
                        loadData?.kerjakanSoalList!.data!.length as int,
                        (index) => SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Soal no ${index + 1}",
                                style: TextStyle(
                                  color: R.colors.greySubtitleHome,
                                  fontSize: 12,
                                ),
                              ),
                              if (loadData?.kerjakanSoalList!.data![index].questionTitle != null)
                                Html(
                                  data: loadData?.kerjakanSoalList!.data![index].questionTitle!,
                                  customRender: {
                                    "table": (context, child) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child:
                                            (context.tree as TableLayoutElement)
                                                .toWidget(context),
                                      );
                                    }
                                  },
                                  style: {
                                    "body": Style(
                                      padding: EdgeInsets.zero,
                                    ),
                                    "p": Style(
                                      fontSize: FontSize(12),
                                    )
                                  },
                                ),
                              if (loadData?.kerjakanSoalList!.data![index].questionTitleImg !=
                                  null)
                                Image.network(
                                    loadData?.kerjakanSoalList!.data![index].questionTitleImg! as String),
                              _buildOption(
                                "A",
                                loadData?.kerjakanSoalList!.data![index].optionA,
                                loadData?.kerjakanSoalList!.data![index].optionAImg,
                                index,
                              ),
                              _buildOption(
                                "B",
                                loadData?.kerjakanSoalList!.data![index].optionB,
                                loadData?.kerjakanSoalList!.data![index].optionBImg,
                                index,
                              ),
                              _buildOption(
                                "C",
                                loadData?.kerjakanSoalList!.data![index].optionC,
                                loadData?.kerjakanSoalList!.data![index].optionCImg,
                                index,
                              ),
                              _buildOption(
                                "D",
                                loadData?.kerjakanSoalList!.data![index].optionD,
                                loadData?.kerjakanSoalList!.data![index].optionDImg,
                                index,
                              ),
                              _buildOption(
                                "E",
                                loadData?.kerjakanSoalList!.data![index].optionE,
                                loadData?.kerjakanSoalList!.data![index].optionEImg,
                                index,
                              ),
                            ],
                          ),
                        ),
                      ).toList()),
                ))
              ],
            ),
    );
  }

  Widget _buildOption(
      String option, String? answer, String? answerImg, int index) {
    final answerCheck = loadData?.kerjakanSoalList!.data![index].studentAnswer == option;
    return GestureDetector(
      onTap: () {
        loadData?.kerjakanSoalList!.data![index].studentAnswer = option;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 2,
        ),
        decoration: BoxDecoration(
            color: answerCheck ? Colors.blue.withOpacity(0.4) : Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Text(
              option + ".",
              style: TextStyle(
                color: answerCheck ? Colors.white : Colors.black,
              ),
            ),
            if (answer != null)
              Expanded(
                child: Html(
                  data: answer,
                  style: {
                    "p": Style(
                      color: answerCheck ? Colors.white : Colors.black,
                    ),
                  },
                ),
              ),
            if (answerImg != null) Expanded(child: Image.network(answerImg)),
          ],
        ),
      ),
    );
  }
}

class BottomsheetConfirmation extends StatefulWidget {
  const BottomsheetConfirmation({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomsheetConfirmation> createState() =>
      _BottomsheetConfirmationState();
}

class _BottomsheetConfirmationState extends State<BottomsheetConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 100,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: R.colors.greySubtitle,
            ),
          ),
          SizedBox(height: 15),
          Image.asset(R.assets.icConfirmatio),
          SizedBox(height: 15),
          Text("Kumpulkan latihan soal sekarang?"),
          Text("Boleh langsung kumpulin dong"),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text("Nanti Dulu"))),
              SizedBox(width: 15),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text("Ya"))),
            ],
          )
        ]),
      ),
    );
  }
}
