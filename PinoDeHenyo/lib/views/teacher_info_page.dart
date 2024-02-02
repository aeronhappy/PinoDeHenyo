import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/teacher/teacher_bloc.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/model/teacher_model.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';

class TeacherInfoPage extends StatefulWidget {
  final String title;
  const TeacherInfoPage({super.key, required this.title});

  @override
  State<TeacherInfoPage> createState() => _TeacherInfoPageState();
}

class _TeacherInfoPageState extends State<TeacherInfoPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int id = 0;

  @override
  void initState() {
    super.initState();
    context.read<TeacherBloc>().add(GetMyAccount());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeacherBloc, TeacherState>(
      listener: (context, state) {
        if (state is LoadedMyAccount) {
          setState(() {
            id = state.teacherModel.id;
            firstNameController.text = state.teacherModel.firstName;
            lastNameController.text = state.teacherModel.lastName;
            genderController.text = state.teacherModel.gender;
            userNameController.text = state.teacherModel.userName;
            passwordController.text = state.teacherModel.password;
          });
        }
        if (state is TeacherInfoChanged) {
          Navigator.pop(context);
        }
      },
      child: Stack(children: [
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
            child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomBackButton(text: widget.title),
                    SizedBox(height: 30),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "First Name",
                          style: smallTitleWhite(true),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black54, width: 2)),
                          child: TextField(
                            cursorColor: Colors.black,
                            style: bodyBlack,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Ilagay ang unang pangalan dito.",
                                labelStyle:
                                    bodyBlack.copyWith(color: Colors.black45)),
                            controller: firstNameController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Last Name",
                          style: smallTitleWhite(true),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black54, width: 2)),
                          child: TextField(
                            cursorColor: Colors.black,
                            style: bodyBlack,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Ilagay ang Apelido.",
                                labelStyle:
                                    bodyBlack.copyWith(color: Colors.black45)),
                            controller: lastNameController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Gender",
                          style: smallTitleWhite(true),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black54, width: 2)),
                          child: TextField(
                              cursorColor: Colors.black,
                              style: bodyBlack,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Ilagay ang kasarian",
                                  labelStyle: bodyBlack.copyWith(
                                      color: Colors.black45)),
                              controller: genderController),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "User Name",
                          style: smallTitleWhite(true),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black54, width: 2)),
                          child: TextField(
                              cursorColor: Colors.black,
                              style: bodyBlack,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Ilagay ang user name dito.",
                                  labelStyle: bodyBlack.copyWith(
                                      color: Colors.black45)),
                              controller: userNameController),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Password",
                          style: smallTitleWhite(true),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black54, width: 2)),
                          child: TextField(
                              cursorColor: Colors.black,
                              style: bodyBlack,
                              obscureText: true,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Ilagay ang password dito.",
                                  labelStyle: bodyBlack.copyWith(
                                      color: Colors.black45)),
                              controller: passwordController),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      color: firstNameController.text.isEmpty ||
                              lastNameController.text.isEmpty ||
                              genderController.text.isEmpty ||
                              userNameController.text.isEmpty ||
                              passwordController.text.isEmpty
                          ? Colors.green.shade200
                          : Colors.green,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: firstNameController.text.isEmpty ||
                                lastNameController.text.isEmpty ||
                                genderController.text.isEmpty ||
                                userNameController.text.isEmpty ||
                                passwordController.text.isEmpty
                            ? null
                            : () {
                                context.read<TeacherBloc>().add(
                                    ChangeTeacherInfo(
                                        teacherModel: TeacherModel(
                                            id: id,
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                            gender: genderController.text,
                                            userName: userNameController.text,
                                            password:
                                                passwordController.text)));
                              },
                        child: SizedBox(
                          height: 60,
                          child: Center(
                            child: Text(
                              "SAVE",
                              style: smallTitleWhite(false),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ))
      ]),
    );
  }
}
