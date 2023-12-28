import 'package:flutter/material.dart';

class LessonCategoryModel {
  final String id;
  final String title;
  final String description;
  final String example;
  final String image;
  Color? color;

  LessonCategoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.example,
    required this.image,
    required this.color,
  });
}

List<LessonCategoryModel> lessonCategoryList = <LessonCategoryModel>[
  LessonCategoryModel(
    id: 'PRUTAS',
    title: 'Mangga',
    description:
        'Ang mangga ay isang uri ng prutas na karaniwang makikita sa mga lugar na may mainit na klima, tulad ng Pilipinas. Ito ay may matamis na lasa at maraming uri.',
    example: 'Bumili si Ana ng isang kilong mangga sa palengke.',
    image: 'assets/lesson/mangga.png',
    color: null,
  ),
  LessonCategoryModel(
    id: 'PRUTAS',
    title: 'Mansanas',
    description:
        'Ang mansanas ay karaniwang kulay pula o berde ito ay may matamis na lasa. Ito ay kilala sa kanyang mabuting epekto sa kalusugan dahil sa mataas na nilalaman ng bitamina C.',
    example: 'Ang paboritong prutas ni Sam ay mansanas.',
    image: 'assets/lesson/mansanas.png',
    color: null,
  ),
  LessonCategoryModel(
    id: 'PRUTAS',
    title: 'Saging',
    description:
        'Ang saging ay may malambot na laman at matamis na lasa kapag hinog na, kilala din ito pagiging isang magandang mapagkukunan ng potassium.',
    example:
        'May tanim na saging sila Andrei at Andrea sa kanilang likod bahay.',
    image: 'assets/lesson/saging.png',
    color: null,
  ),

  LessonCategoryModel(
    id: 'PRUTAS',
    title: 'Ubas',
    description:
        'Ang ubas ay isang uri ng prutas na nagmula sa isang gumagapang na halaman. Nagagawang alak ang prutas mulan sa halamang ito.',
    example:
        'Kilala ang bayan nina Claire dahil mayaman sila sa mga tanim na ubas.',
    image: 'assets/lesson/ubas.png',
    color: null,
  ),
  LessonCategoryModel(
    id: 'PRUTAS',
    title: 'Pakwan',
    description:
        'Ang pakwan ay kilalang prutas sa Pilipinas na paborito ng marami. Ang halaman ay gumagapang, may malapad na dahon at may madilaw na bulaklak.',
    example: 'Malaki at matamis ang pakwan na nabili ni Mark sa palengke.',
    image: 'assets/lesson/pakwan.png',
    color: null,
  ),
  ////////////////////////
  LessonCategoryModel(
    id: 'GULAY',
    title: 'Kamatis',
    description:
        'Ang kamatis ay ang tawag sa isang uri ng halaman o bunga nito na kulay lunti kulang hilaw , subalit nagiging dilaw hanggang pula kung hinog na. Nagtataglay din ito ng bitamina A at C.',
    example: 'Hinog na ang mga tanim  na kamatis ni Denise.',
    image: 'assets/lesson/kamatis.png',
    color: null,
  ),

  LessonCategoryModel(
    id: 'GULAY',
    title: 'Talong',
    description:
        'Ang talong ay isang maliit na puno na may magaspang at matinik na mga sanga. Lumalaki ito ng mga kalahati hanggang isang metro ang taas.',
    example:
        'Bumili ng isang kilong talong si Christoff sa naglalako ng mga gulay sa kalsada.',
    image: 'assets/lesson/talong.png',
    color: null,
  ),

  LessonCategoryModel(
    id: 'GULAY',
    title: 'Petsay',
    description:
        'Ang petsay o pechay ay ang tinatawag na Chinese cabbage sa Ingles na nangangahulugan "repolyong intsik", na may madidilim na luntiang dahon at mga malalapad na mapuputing tangkay.',
    example: 'Madaming tanim na pechay sina Mary sa kanilang likod bahay.',
    image: 'assets/lesson/petsay.png',
    color: null,
  ),

  LessonCategoryModel(
    id: 'GULAY',
    title: 'Okra',
    description:
        'Ang okra ay isang uri ng halamang gulay na malawakang itinatanim sa tropiko at may katamtamang lamig na mga Rehiyon.',
    example: 'Paboritong gulay ni Jade ang okra.',
    image: 'assets/lesson/okra.png',
    color: null,
  ),

  LessonCategoryModel(
    id: 'GULAY',
    title: 'Sayote',
    description:
        'Ang sayote ay isang uri ng halamang gulay na kahugis ng prutas na peras.',
    example: 'Namitis si Ara ng sayote sa kanilang taniman.',
    image: 'assets/lesson/sayote.png',
    color: null,
  ),
  ///////
  LessonCategoryModel(
    id: 'HAYOP',
    title: 'Kalabaw',
    description:
        'Ang kalabaw ay isa sa mga mahahalagang hayop dito sa Pilipinas. Ito ay tumutulong sa pag-aararo ng lupa at pag-aani ng gulay sa mga sakahan at ito din ang pambansang hayop ng Pilipinas.',
    example: 'Si lolo ay nakasakay sa kalabaw habang nag aararo sa bukid.',
    image: 'assets/lesson/kalabaw.png',
    color: null,
  ),
  LessonCategoryModel(
    id: 'HAYOP',
    title: 'Aso',
    description:
        'Ang aso ay isa sa matalik na kaibigan ng mga tao at ito din ang nagsisilbing tagapagbantay sa tahanan.',
    example: 'Si Juan ay may alagang aso, ang pangalan ay bummer.',
    image: 'assets/lesson/aso.png',
    color: null,
  ),
  LessonCategoryModel(
    id: 'HAYOP',
    title: 'Oso',
    description:
        'Ang oso ay isa sa malaking hayop na mabangis at kinatatakutan at kabilang sa pangkaraniwang katangian ng mga oso ang pagkakaroon ng maikling buntot.',
    example: 'Si Joan ay nakakita sa gubat ng isang oso.',
    image: 'assets/lesson/oso.png',
    color: null,
  ),
  LessonCategoryModel(
    id: 'HAYOP',
    title: 'Pusa',
    description:
        'Ang pusa ay isa sa maliit at maamong hayop na kabilang sa nakatira sa mga kabahayan at isa sa kaibigan ng tao.',
    example: 'Si Joshua ay may alagang puting pusa.',
    image: 'assets/lesson/pusa.png',
    color: null,
  ),
  LessonCategoryModel(
    id: 'HAYOP',
    title: 'Ahas',
    description:
        'Ang ahas ay ang mahaba at walang hitang mga reptilyang karnibora at isa sa delikadong hayop.',
    example: 'Si Mark ay maynakitang mahabang ahas sa daan.',
    image: 'assets/lesson/ahas.png',
    color: null,
  ),

  /////

  LessonCategoryModel(
    id: 'ANYONG TUBIG',
    title: 'Batis',
    description:
        'Ang batis ay isang punto kung saan dumadaloy ang tubig mula sa akwipero, isang patong sa ilalim ng lupa na naglalaman ng tubig sa natatagusang bato, palabas tungo sa ibabaw ng lupa sa Daigdig.',
    example: 'Si kuya ay pupunta sa batis para kumuha ng sariwang tubig.',
    image: 'assets/lesson/batis.png',
    color: null,
  ),
  LessonCategoryModel(
    id: 'ANYONG TUBIG',
    title: 'Dagat',
    description:
        'Ang dagat ay isang malaking lawas ng maalat na tubig na ang nakadugtong ay karagatan, o ng isang malaking lawang-alat na walang likas na lagusan gaya ng Dagat Caspian at Dagat Patay.',
    example: 'Sila tatay ay pupunta sa dagat para mangisda.',
    image: 'assets/lesson/dagat.png',
    color: null,
  ),
  LessonCategoryModel(
    id: 'ANYONG TUBIG',
    title: 'Sapa',
    description:
        'Maliit o katamtamang batis na maaring tuyo sa mahabang tag-init o tagtuyot.',
    example: 'Nagpunta ang mga bata sa sapa upang mag tampisaw.',
    image: 'assets/lesson/sapa.png',
    color: null,
  ),
  LessonCategoryModel(
    id: 'ANYONG TUBIG',
    title: 'Lawa',
    description:
        'Ang lawa ay isang anyong tubig na pinapalibutan ng lupain. Karamihan sa mga lawa sa daigdig ay tubig tabang.',
    example:
        'pumasyal si itay sa lawa para subukan ang kanyang ginawang bangka.',
    image: 'assets/lesson/lawa.png',
    color: null,
  ),
  LessonCategoryModel(
    id: 'ANYONG TUBIG',
    title: 'Ilog',
    description:
        'Ang ilog ay isang malaking likas na daanang tubig, maaaring pinagkukunan nito ang isang lawa, isang bukal o pagtitipon ng maliit na mga batis, kilala bilang agos.',
    example: 'Pumunta si inay sa ilog upang maglaba ng mga damit.',
    image: 'assets/lesson/ilog.png',
    color: null,
  ),
];
