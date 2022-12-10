import 'package:tiutiu/core/constants/strings.dart';

class DummyData {
  static const otherCaracteristicsList = [
    'Vermifugado',
    'Brincalhão',
    'Lida bem com outros PETs',
    'Tranquilo',
    'Lida bem com crianças',
    'Castrado',
    'Lida bem com visitas',
    'Vacinado',
    'Tímido',
    'Manhoso',
    'Carente',
    'Amigão',
    'Guarda',
    'Dócil',
  ];

  static Map<String, List<String>> breeds = {
    PetTypeStrings.dog: [
      '-',
      'Akita',
      'Basset',
      'Beagle',
      'Bichon',
      'Boiadeiro',
      'Border',
      'Boston',
      'Boxer',
      'Buldogue francês',
      'Buldogue inglês',
      'Bull',
      'Cane',
      'Cavalier',
      'Chihuahua',
      'Chow',
      'Cocker',
      'Dachshund',
      'Dálmata',
      'Doberman',
      'Dogo',
      'Dogue',
      'Fila',
      'Golden',
      'Raça Indefinida',
      'Husky',
      'Jack',
      'Labrador',
      'Lhasa',
      'Lulu',
      'Maltês',
      'Mastiff',
      'Mastim',
      'Pastor Shetland',
      'Pastor australiano',
      'Pastor alemão',
      'Pequinês',
      'Pinscher',
      'Pit',
      'Poodle',
      'Pug',
      'Rottweiler',
      'Schnauzer',
      'Shar',
      'Shiba',
      'Shih',
      'Shih Tzu',
      'Staffordshire',
      'Vira-lata',
      'Weimaraner',
      'Yorkshire'
    ],
    PetTypeStrings.cat: [
      '-',
      'Abissínio',
      'Angorá',
      'Ashera',
      'Balinês',
      'Bengal',
      'Bobtail americano',
      'Bobtail japonês',
      'Bombay',
      'Burmês',
      'Burmês vermelho',
      'Chartreux',
      'Colorpoint de Pêlo Curto',
      'Cornish Rex.',
      'Curl Americano (sem informação)',
      'Devon Rex',
      'Raça Indefinida',
      'Himalaio',
      'Jaguatirica',
      'Javanês',
      'Korat',
      'LaPerm',
      'Maine Coon',
      'Manx',
      'Cymric',
      'Mau Egípcio',
      'Mist Australiano',
      'Munchkin',
      'Norueguês da Floresta',
      'Pelo curto americano',
      'Pelo curto brasileiro',
      'Pelo curto europeu',
      'Pelo curto inglês',
      'Persa',
      'Pixie-bob',
      'Ragdoll',
      'Ocicat',
      'Russo Azul',
      'Sagrado da Birmânia',
      'Savannah',
      'Scottish Fold',
      'Selkirk Rex',
      'Siamês',
      'Siberiano',
      'Singapura',
      'Somali',
      'Sphynx',
      'Thai',
      'Tonquinês',
      'Toyger',
      'Usuri',
      'Sem raça definida',
    ],
    PetTypeStrings.bird: [
      '-',
      'Abelharuco',
      'Agapornis',
      'Agapornis canus',
      'Agapornis fischeri',
      'agapornis liliane',
      'agapornis nigrinenis',
      'Agapornis personatus',
      'Agapornis roseicollis',
      'Agapornis swinderniana',
      'agapornis taranta',
      'Alma-de-gato',
      'Amaranta do Senegal',
      'Anaca',
      'Aracari de Frantzius',
      'Araponga',
      'Arara-azul-de-lear',
      'Arara-azul-grande',
      'Arara-azul-pequena',
      'Araracanga',
      'Arara-caninde',
      'Arara-de-barriga-amarela',
      'Arara-militar',
      'Arara-vermelha',
      'Ararinha-azul',
      'Ararinha-de-testa-vermelha',
      'Bavete',
      'Cabeca de Ameixa',
      'Caboclinho-de-barriga-preta',
      'Caboclinho-de-papo-escuro',
      'Cacatua',
      'calafate',
      'Canario',
      'Canario Arlequim Portugues',
      'Canario de Cor',
      'Canario de Porte',
      'Caraquita',
      'Cardeal-da-amazonia',
      'cardeal-de-goias',
      'cardeal-de-topete-vermelho',
      'Cardeal-do-nordeste',
      'Cardeal-do-pantanal',
      'Calopsita ou Caturra',
      'Caturrita',
      'chamariz',
      'Codorna',
      'Coleiro',
      'Common Redpoll',
      'Cordonbleu',
      'Curio',
      'Domin&oacute',
      'Ecletus Roratus Polychloros',
      'Ema',
      'Expl&ecircndido',
      'Forpus Coelestis',
      'Galah',
      'Garca-real-europeia',
      'Garrincha',
      'Gaviao-asa-de-telha',
      'Gaviao-azul ',
      'Gaviao-belo',
      'Gaviao-branco',
      'Gaviaocinzento',
      'Gaviao-pega-macaco',
      'Gaviao-pomba',
      'Granatina',
      'Guaruba',
      'Harpia',
      'Raça Indefinida',
      'Inhambu-galinha',
      'Jandaia coquinho',
      'Ja&oacute',
      'Jo&atilde;o-de-barro',
      'Kakarikes',
      'Lorys',
      'Lugano',
      'Macuco',
      'Main&aacute',
      'mandarim',
      'Moustache',
      'Negrito Boliviano',
      'Neophemas',
      'Papagaio-char&atilde;o',
      'Papagaio-Chaua',
      'Papagaio-cinzento',
      'Papagaio-da-patagonia',
      'Papagaio-da-serra',
      'Papagaio-de-cara-roxa',
      'Papagaio-de-hispaniola',
      'Papagaio-de-peito-roxo',
      'Papagaio-de-porto-rico',
      'Papagaio-de-santa-lucia',
      'Papagaio-de-sao-vicente',
      'Papagaio do Congo',
      'papagaio-do-mangue',
      'Papagaio-escarlate',
      'Papagaio-galego',
      'Papagaio-moleiro',
      'Papagaio-verdadeiro',
      'Perdiz',
      'Periquito Australiano',
      'Periquito-de-colar',
      'Periquito-rei (Aratinga Aurea)',
      'Pica-pau-bico-de-marfim',
      'Pica-pau-carijo',
      'Pica-pau-de-banda-branca',
      'Pica-pau-de-barriga-vermelha',
      'Pica-pau-de-cabeca-amarela',
      'Pica-pau-de-topete-vermelho',
      'Pica-pau-do-campo',
      'Pica-pau-malhado-grande',
      'Pintarroxo',
      'Pintassilgo Baianinho',
      'Pintassilgo Comum',
      'Pintassilgo de Cabeca Preta',
      'Pintassilgo de capa preta',
      'Pintassilgo do Equador',
      'pintassilgo do nordeste',
      'Pintassilgo dos Andes',
      'Pintassilgo Portugues',
      'Pombo-comum',
      'Port Lincon',
      'Red Rumpet ',
      'Ring neck',
      'Rosela adscitus',
      'Rosela eximius',
      'Rosela Pennant',
      'Tarim',
      'tuiuiu',
      'Urubu-rei ',
      'Verdilhao Comum',
      'Verdilhao de Cabeca Negra',
      'Verdilhao Oriental',
      'Warsangli Linnet',
      'Yemen Linnet'
    ],
  };

  static const size = [
    '-',
    'Mini',
    'Pequeno',
    'Médio',
    'Grande',
  ];

  static List<String> health = [
    '-',
    PetHealthString.chronicDisease,
    PetHealthString.palliative,
    PetHealthString.preganant,
    PetHealthString.healthy,
    PetHealthString.hurted,
    PetHealthString.ill,
  ];

  static const gender = [
    '-',
    'Macho',
    'Fêmea',
    'Hermafrodita',
    'Não tem',
  ];

  static const catColors = [
    '-',
    'Amarelo',
    'Branca',
    'Bicolor',
    'Branco',
    'Branco com Cinza',
    'Branco com Preto',
    'Cinzento',
    'Carey',
    'Escaminha',
    'Malhado',
    'Marrom',
    'Marrom com amarelo',
    'Marrom com branco',
    'Marrom com cinza',
    'Marrom com preto',
    'Mostarda',
    'Multicolor',
    'Laranja',
    'Frajola',
    'Rajado',
    'Preto',
    'Preto com Amarelo',
    'Tricolor',
    'Tigrado',
  ];

  static const dogColors = [
    '-',
    'Amarelo',
    'Azul Escuro',
    'Bege',
    'Bicolor',
    'Branco',
    'Branco com Cinza',
    'Branco com Preto',
    'Chocolate',
    'Castanho',
    'Cinza',
    'Dourado',
    'Dálmata',
    'Magno',
    'Marrom',
    'Marrom Acobreado',
    'Marrom com Amarelo',
    'Marrom com Branco',
    'Marrom com Cinza',
    'Marrom com Preto',
    'Mostarda',
    'Multicolor',
    'Preto',
    'Preto com Amarelo',
    'Fulva (Ruivo)',
    'Tricolor',
    'Vermelho',
  ];

  static const allColors = [
    '-',
    'Abóbora',
    'Açafrão',
    'Amarelo',
    'Âmbar',
    'Ameixa',
    'Amêndoa',
    'Ametista',
    'Anil',
    'Azul',
    'Bege',
    'Bicolor',
    'Bordô',
    'Branco',
    'Bronze',
    'Cáqui',
    'Caramelo',
    'Carmesim',
    'Carmim',
    'Castanho',
    'Cereja',
    'Chocolate',
    'Ciano ',
    'Cinza',
    'Cinzento',
    'Cobre',
    'Coral',
    'Creme',
    'Damasco',
    'Dourado',
    'Escaminha',
    'Escarlate',
    'Esmeralda',
    'Ferrugem',
    'Frajola',
    'Fúcsia',
    'Gelo',
    'Grená',
    'Gris',
    'Índigo',
    'Jade',
    'Jambo',
    'Laranja',
    'Lavanda',
    'Lilás ',
    'Limão',
    'Liso',
    'Loiro',
    'Lobinho',
    'Magenta',
    'Malva',
    'Marfim',
    'Marrom',
    'Marrom com amarelo',
    'Marrom com branco',
    'Marrom com cinza',
    'Marrom com preto',
    'Mostarda',
    'Multicolor',
    'Negro',
    'Ocre',
    'Oliva',
    'Oncinha',
    'Ouro',
    'Pêssego',
    'Prata',
    'Preto',
    'Preto com amarelo',
    'Preto com branco',
    'Preto com cinza',
    'Púrpura',
    'Rosa',
    'Roxo',
    'Rubro',
    'Salmão',
    'Sépia',
    'Siamês',
    'Sialata',
    'Terracota',
    'Tijolo',
    'Tigrado',
    'Tricolor',
    'Turquesa',
    'Uva',
    'Verde',
    'Vermelho',
    'Vinho',
    'Violeta',
    'Dálmata'
  ];
}
