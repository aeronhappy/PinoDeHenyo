import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/user/user_bloc.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';

class ListOfStudentPage extends StatefulWidget {
  final String title;
  const ListOfStudentPage({super.key, required this.title});

  @override
  State<ListOfStudentPage> createState() => _ListOfStudentPageState();
}

class _ListOfStudentPageState extends State<ListOfStudentPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetAllUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        top: 0,
        child: Image.asset(
          'assets/pino/14.png',
          fit: BoxFit.fitHeight,
        ),
      ),
      SafeArea(
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBackButton(text: widget.title),
                        SizedBox(height: 50),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state is LoadedAllUsers) {
                                return state.users.length == 0
                                    ? Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Center(
                                            child: Text(
                                          "To add a student, you must first scan and save student data.",
                                          textAlign: TextAlign.center,
                                          style: bodyBlack,
                                        )),
                                      )
                                    : ListView.builder(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        itemCount: state.users.length,
                                        itemBuilder: (context, index) {
                                          var user = state.users[index];
                                          return Container(
                                            height: 45,
                                            padding: EdgeInsets.only(
                                                left: 20, right: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Text(user.userName,
                                                        style: smallTitleBlack(
                                                                false)
                                                            .copyWith(
                                                                fontSize: 16))),
                                                Material(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    splashColor:
                                                        Colors.red.shade200,
                                                    onTap: () {
                                                      context
                                                          .read<UserBloc>()
                                                          .add(DeleteUserById(
                                                              userId: user
                                                                  .deviceId));
                                                    },
                                                    child: Container(
                                                      width: 45,
                                                      height: 45,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        ))
                      ]))))
    ]);
  }
}
