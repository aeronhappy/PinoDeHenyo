class LessonModel {
  final String id;
  final String title;
  final String description;
  final String example;
  final String image;

  const LessonModel({
    required this.id,
    required this.title,
    required this.description,
    required this.example,
    required this.image,
  });
}

List<LessonModel> lessonList = <LessonModel>[
  const LessonModel(
    id: 'Aa',
    title: 'Araw',
    description:
        'Isang bituin na pinapalibutan ng mga planeta na nagbibigay ilaw at araw sa mundo.',
    example:
        'Walang kahit sinumang nakakapunta sa araw dahil sa sobrang init nito.',
    image: 'assets/lesson/araw.png',
  ),
  const LessonModel(
    id: 'Bb',
    title: 'Baka',
    description:
        'Ito ay malaki at maamong hayop,may apat na paa, may sungay, at ginagatasan ang inahin.',
    example: 'Pupunta si tatay sa bukid upang gatasan ang aming mga baka.',
    image: 'assets/lesson/baka.png',
  ),
  const LessonModel(
    id: 'Kk',
    title: 'Kahoy',
    description:
        'Ang kahoy ay maaring gamitin sa pag buo ng bahay. Ito ay makukuha sa mga puno na naputol.',
    example: 'Kumuha ka ng kahoy at gagawin nating pang-gatong.',
    image: 'assets/lesson/kahoy.png',
  ),
  const LessonModel(
    id: 'Dd',
    title: 'Dahon',
    description:
        'Manipis na luntiang bahagi ng sanga ng isang punongkahoy o halaman.',
    example: 'Ang dahon ng gabi ay hugis puso.',
    image: 'assets/lesson/dahon.png',
  ),
  const LessonModel(
    id: 'Ee',
    title: 'Espada',
    description:
        'Isang mahaba at matalim na piraso ng metal na ginagamit bilang pamputol.',
    example: 'Si Zoro ay may tatlong espada.',
    image: 'assets/lesson/espada.png',
  ),
  const LessonModel(
    id: 'Gg',
    title: 'Gatas',
    description:
        'Ito ay isang uri ng masustansyang inumin na maaring mag mula sa ating ina o sa mga inahing hayop.',
    example:
        'Sabi ng aking nanay na palagi akong uminom ng gatas bago matulog.',
    image: 'assets/lesson/gatas.png',
  ),
  const LessonModel(
    id: 'Hh',
    title: 'Hari',
    description: 'Isang lalaking makapangyarihang pinuno ng isang lupain.',
    example: 'Ang hari sa aming bayan ay napabuti.',
    image: 'assets/lesson/hari.png',
  ),
  const LessonModel(
    id: 'Ii',
    title: 'Isda',
    description: 'Ang hayop na naninirahan sa tubig.',
    example: 'Ang aking nanay ay nag bebenta ng isda sa pelengke.',
    image: 'assets/lesson/isda.png',
  ),
  const LessonModel(
    id: 'Ll',
    title: 'Laso',
    description:
        'Ito ay isang piraso ng tela o kauri nito na ginagamit na pantali o pandekorasyon.',
    example: 'Talian ng laso ang kahong panregalo',
    image: 'assets/lesson/laso.png',
  ),
  const LessonModel(
    id: 'Mm',
    title: 'Mais',
    description: 'Isang uri ng bungang gulay.',
    example: 'Ang mais ay masarap ilahok sa bulalo.',
    image: 'assets/lesson/mais.png',
  ),
  const LessonModel(
    id: 'Nn',
    title: 'Nanay',
    description:
        'Siya ay magulang na babae.Itinuturing din na ilaw ng tahanan.',
    example: 'Ang aking nanay ay masipag at mapagmahal sa amin.',
    image: 'assets/lesson/nanay.png',
  ),
  const LessonModel(
    id: 'Oo',
    title: 'Okra',
    description: 'Ito ay isang uri ng halamang gulay.',
    example: 'Ang okra ang paborito kong gulay.',
    image: 'assets/lesson/okra.png',
  ),
  const LessonModel(
    id: 'Pp',
    title: 'Pulis',
    description:
        'Isang pangkat ng mga taong may hanapbuhay o trabahong nangangalaga ng katahimikan at kaayusan, pagpapatupad ng batas  at pagbibigay ng proteksyon sa publiko at madla.',
    example: 'May nahuling tatlong mag nanakaw ang mga pulis.',
    image: 'assets/lesson/pulis.png',
  ),
  const LessonModel(
    id: 'Rr',
    title: 'Radyo',
    description:
        'Aparatong ginagamit sa pagtanggap, pagbrodkast, o pagpapadala sa senyas na panradyo.',
    example: 'Binalita sa radyo ang parating na bagyo.',
    image: 'assets/lesson/radyo.png',
  ),
  const LessonModel(
    id: 'Ss',
    title: 'Sabon',
    description: 'Uri ng panglinis sa anumang bagay.',
    example: 'Bumili ka ng sabon sa tindahan at ako ay maliligo.',
    image: 'assets/lesson/sabon.png',
  ),
  const LessonModel(
    id: 'Tt',
    title: 'Tatay',
    description:
        'Siya ay magulang na lalaki. Itinuturing din na haligi ng tahanan.',
    example: 'Ang aking tatay ay gumagawa ng bahay.',
    image: 'assets/lesson/tatay.png',
  ),
  const LessonModel(
    id: 'Uu',
    title: 'Ubas',
    description:
        'Isang uri ng prutas na nagmula sa isang gumagapang na halaman. ',
    example: 'Madaming nakatanim na ubas saming bakuran.',
    image: 'assets/lesson/ubas.png',
  ),
  const LessonModel(
    id: 'Ww',
    title: 'Walis',
    description:
        'Isang kagamitang panlinis na yari mula sa sintetikong plastik, buhok, o hibla  ng mais.',
    example: 'Mag walis ka mamaya at may darating na bisita.',
    image: 'assets/lesson/walis.png',
  ),
  const LessonModel(
    id: 'Yy',
    title: 'Yoyo',
    description:
        'Ito ay laruan na binubuo ng dalawang bilog na pinapaikot sa pamamagitan ng pisi.',
    example: 'Ako ay nagpabili ng yoyo sa aking nanay.',
    image: 'assets/lesson/yoyo.png',
  ),
];
