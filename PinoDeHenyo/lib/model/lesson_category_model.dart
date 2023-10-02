class LessonCategoryModel {
  final String id;
  final String title;
  final String description;
  final String example;
  final String image;

  const LessonCategoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.example,
    required this.image,
  });
}

List<LessonCategoryModel> lessonCategoryList = <LessonCategoryModel>[
  ////////////////////////
  const LessonCategoryModel(
    id: 'PUNO',
    title: 'Puno ng Niyog',
    description:
        'Ang puno ng niyog ay isang ekspresyon sa Filipino na nagpapahiwatig ng pagiging masuwerte o maginhawa.',
    example:
        'Tuwing umaga, ako\'y nagigising na puno ng niyog sa buhay dahil sa masarap na almusal na handa ni Nanay.',
    image: 'assets/lesson/puno_niyog.png',
  ),
  const LessonCategoryModel(
    id: 'PUNO',
    title: 'Puno ng Mangga',
    description:
        'Ang puno ng manga ay maaaring magkaiba ng kahulugan depende sa konteksto. Maaring ito ay tumukoy sa isang puno o halaman na nagbubunga ng manga, o ito ay maaring gamitin na idyomatikong kahulugan.',
    example:
        'Ang puno ng manga sa likod ng bahay namin ay puno ng masarap na bunga ngayon.',
    image: 'assets/lesson/puno_mangga.png',
  ),
  const LessonCategoryModel(
    id: 'PUNO',
    title: 'Puno ng Saging',
    description:
        'Ang puno ng saging ay isang sa mga mabilis dumaminat tumubo at halos lahat ng parte ng puno ng saging ay nagagamit.',
    example:
        'Sa kanyang paglalakad may nakita siyang maraming bunga ng puno ng saging.',
    image: 'assets/lesson/puno_saging.png',
  ),
  const LessonCategoryModel(
    id: 'PUNO',
    title: 'Puno ng Papaya',
    description:
        'Ang puno ng papaya ay isang ekspresyon sa Filipino na nagpapahiwatig ng maraming obligasyon o gawain. Ito ay maaaring maging negatibo dahil nagpapahiwatig ito ng sobrang trabaho o pagka-abala.',
    example:
        'Sa kanyang trabaho, parang puno ng papaya ang kanyang araw-araw na schedule, walang oras para sa pahinga.',
    image: 'assets/lesson/puno_papaya.png',
  ),
  const LessonCategoryModel(
    id: 'PUNO',
    title: 'Puno ng Bayabas',
    description:
        'Ang puno ng bayabas ay simbolo ng suwerte, pagkamayabong, at kasaganaan. Nanaginip ng bayabas puno nangangahulugan na ikaw ay umaasa sa magagandang bagay na darating sa iyo.',
    example:
        'Ang kanilang tahanan ay puno ng bayabas, dahil masuwerte at masagana ang kanilang pamilya.',
    image: 'assets/lesson/puno_bayabas.png',
  ),

  ///////

  const LessonCategoryModel(
    id: 'HAYOP',
    title: 'Kalabaw',
    description:
        'Ang kalabaw ay isa sa mga mahahalagang hayop dito sa Pilipinas. Ito ay tumutulong sa pag-aararo ng lupa at pag-aani ng gulay sa mga sakahan at ito din ang pambansang hayop ng Pilipinas.',
    example: 'Si lolo ay nakasakay sa kalabaw habang nag aararo sa bukid.',
    image: 'assets/lesson/kalabaw.png',
  ),
  const LessonCategoryModel(
    id: 'HAYOP',
    title: 'Aso',
    description:
        'Ang aso ay isa sa matalik na kaibigan ng mga tao at ito din ang nagsisilbing tagapagbantay sa tahanan.',
    example: 'Si Juan ay may alagang aso, ang pangalan ay bummer.',
    image: 'assets/lesson/aso.png',
  ),
  const LessonCategoryModel(
    id: 'HAYOP',
    title: 'Oso',
    description:
        'Ang oso ay isa sa malaking hayop na mabangis at kinatatakutan at kabilang sa pangkaraniwang katangian ng mga oso ang pagkakaroon ng maikling buntot.',
    example: 'Si Joan ay nakakita sa gubat ng isang oso.',
    image: 'assets/lesson/oso.png',
  ),
  const LessonCategoryModel(
    id: 'HAYOP',
    title: 'Pusa',
    description:
        'Ang pusa ay isa sa maliit at maamong hayop na kabilang sa nakatira sa mga kabahayan at isa sa kaibigan ng tao.',
    example: 'Si Joshua ay may alagang puting pusa.',
    image: 'assets/lesson/pusa.png',
  ),
  const LessonCategoryModel(
    id: 'HAYOP',
    title: 'ahas',
    description:
        'Ang ahas ay ang mahaba at walang hitang mga reptilyang karnibora at isa sa delikadong hayop.',
    example: 'Si Mark ay maynakitang mahabang ahas sa daan.',
    image: 'assets/lesson/ahas.png',
  ),

  /////

  const LessonCategoryModel(
    id: 'ANYONG TUBIG',
    title: 'Batis',
    description:
        'Ang batis ay isang punto kung saan dumadaloy ang tubig mula sa akwipero, isang patong sa ilalim ng lupa na naglalaman ng tubig sa natatagusang bato, palabas tungo sa ibabaw ng lupa sa Daigdig.',
    example: 'Si kuya ay pupunta sa batis para kumuha ng sariwang tubig.',
    image: 'assets/lesson/batis.png',
  ),
  const LessonCategoryModel(
    id: 'ANYONG TUBIG',
    title: 'Dagat',
    description:
        'Ang dagat ay isang malaking lawas ng maalat na tubig na ang nakadugtong ay karagatan, o ng isang malaking lawang-alat na walang likas na lagusan gaya ng Dagat Caspian at Dagat Patay.',
    example: 'Sila tatay ay pupunta sa dagat para mangisda.',
    image: 'assets/lesson/dagat.png',
  ),
  const LessonCategoryModel(
    id: 'ANYONG TUBIG',
    title: 'Sapa',
    description:
        'Maliit o katamtamang batis na maaring tuyo sa mahabang tag-init o tagtuyot.',
    example: 'Nagpunta ang mga bata sa sapa upang mag tampisaw.',
    image: 'assets/lesson/sapa.png',
  ),
  const LessonCategoryModel(
    id: 'ANYONG TUBIG',
    title: 'Lawa',
    description:
        'Ang lawa ay isang anyong tubig na pinapalibutan ng lupain. Karamihan sa mga lawa sa daigdig ay tubig tabang.',
    example:
        'pumasyal si itay sa lawa para subukan ang kanyang ginawang bangka.',
    image: 'assets/lesson/lawa.png',
  ),
  const LessonCategoryModel(
    id: 'ANYONG TUBIG',
    title: 'Ilog',
    description:
        'Ang ilog ay isang malaking likas na daanang tubig, maaaring pinagkukunan nito ang isang lawa, isang bukal o pagtitipon ng maliit na mga batis, kilala bilang agos.',
    example: 'Pumunta si inay sa ilog upang maglaba ng mga damit.',
    image: 'assets/lesson/ilog.png',
  ),
];
