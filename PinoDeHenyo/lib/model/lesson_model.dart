class LessonModel {
  final String id;
  final String title;
  final String description;
  final String image;

  const LessonModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });
}

List<LessonModel> lessonList = <LessonModel>[
  const LessonModel(
    id: '1',
    title: 'BAKA',
    description: 'Baka ay may apat na paa , ito ay malaki.',
    image:
        'https://static.vecteezy.com/system/resources/previews/000/648/305/original/vector-cute-cow-cartoon.jpg',
  ),
];
