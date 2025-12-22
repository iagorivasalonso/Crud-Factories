'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "a61910df347b2e43a75f8c0bd332b260",
".git/config": "b46d2962c8e11f776c6c36ba901d6d8e",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/FETCH_HEAD": "d41d8cd98f00b204e9800998ecf8427e",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "4b44f371f99513445517b6e20aa685d6",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "f428e075acdd27f5eb9caf1b9bbda56e",
".git/logs/refs/heads/main": "f428e075acdd27f5eb9caf1b9bbda56e",
".git/logs/refs/remotes/origin/main": "829b7f453bc7ad733c785682f597365a",
".git/objects/00/ca3aeb4256e4946e08b249988f9da8b93630ba": "ec4e492fd2a77a812f266898d884b555",
".git/objects/08/27c17254fd3959af211aaf91a82d3b9a804c2f": "360dc8df65dabbf4e7f858711c46cc09",
".git/objects/09/97f6a3aff0265ec100fe2b00bdd21d299899f6": "da87924b880307cee72921c989dbcf74",
".git/objects/0b/9eadaa9c489dbb6130535481036b2313badbc8": "0e7d63b8700ae5c0af690ea37f81341d",
".git/objects/0d/57f936c8bea0d4f7703f2258d8d32c4f1c26ae": "4c7681755ccd78908f87dabe4ffe087f",
".git/objects/14/9787f77bcfd7b903d4e9e70cb1e6e7d6714b4d": "9987673107ea4663f307295528fb02f2",
".git/objects/1a/cfcb74027da17e45ea1bc202b2c998627cc3f9": "14a331bddf38940e6320a3b0cca68fb0",
".git/objects/1b/d21e179ee31430e04a094c5b2f7190128d739f": "05540cac5fb6a936bafb9fb2e49364e3",
".git/objects/1d/9c6ee0c66d786a8ce761f5711441db600ca5a9": "51a8aafa2a6c4017b7233dcfec7ef055",
".git/objects/20/421abf2d595533fe66249fb17697bf5a473573": "f0a2e34701d2ce9e6809b111f8593e48",
".git/objects/22/e268516f20cf6f03019a6972674646cf5391a5": "df5d4141b66d605c51cecfd6df6d0324",
".git/objects/24/cdd0b9d71becadea0ee21527ab9243808ddf65": "82f3eaef08bb927b853095af4388fc2a",
".git/objects/25/cbaf1432e1dcda1a758dd5f2c50a5dc0c6540a": "d17e3dc7e437edd9646693cdada61b2b",
".git/objects/27/82260174f32889ddb8952809216d770cc95fe5": "ee8abe88819304e70eac2f7f65a31749",
".git/objects/2c/31471997fe7a7c0e040965cc75656e503fc587": "677524f382c19efea97b3f1b056ccaea",
".git/objects/2d/583c7dc55bc37f8d5298b0cd48c1e108adef52": "5b7df31ccc8494f4da0573cd4b1777bb",
".git/objects/2e/a16bd6764235e997dcce27094fcca085f280f1": "5f0031f331f63fd37425e14919d74858",
".git/objects/30/9ac798bbbe037ab5485584dc072e89202ce8c4": "a3338dc6332d5bbc7eeb470fa4ceda4e",
".git/objects/32/b2bccf3fa734fd74ced6f191834d4a56c8236c": "848208335bb3554571dde5c5b2d434b8",
".git/objects/36/240ba884bf97ee03ead1454da55e483a6fda23": "c9c2b3f9e893a4b521731571ef5c4452",
".git/objects/37/eecce7010fe62b00ff7d0c3f782609d90795d9": "57e66c18bbbc93e30a7ad2bea1faf4d7",
".git/objects/3a/8cda5335b4b2a108123194b84df133bac91b23": "1636ee51263ed072c69e4e3b8d14f339",
".git/objects/41/de173d9014b38f8290acf270c490b37fc79a60": "d2a9d01215e9d65fd0456ded49e98878",
".git/objects/44/4d39ba935a53282734c0b7c19487260013444f": "e4be7fdb8731ba959b0465baa0fcb5bd",
".git/objects/47/629664c77b093c6b2a7b3726b75aaf6cae6295": "301d7051f7acd4bd95828de09d310135",
".git/objects/47/986e6f3379a0f4cbba6b264d8c4315de7da6dc": "96929d7fcb4d63ca01c72724b1bbe167",
".git/objects/4b/825dc642cb6eb9a060e54bf8d69288fbee4904": "75589287973d2772c2fc69d664e10822",
".git/objects/4e/cb09e5a8244b3e19eb185095101467fe3b083e": "38c06cf8bad31b5dccd82907883d6932",
".git/objects/50/0e2794d9f1bb782464b441c9a28069a01aa879": "59426e781c253d6321defd028d3bbe8c",
".git/objects/51/03e757c71f2abfd2269054a790f775ec61ffa4": "d437b77e41df8fcc0c0e99f143adc093",
".git/objects/51/3b13f618ccba12e988b407ac9a09613cdc2090": "32a80c198b50a0ceaf647af62acfcc20",
".git/objects/51/c2391dd83129e625932606e25d5a3c6fb3564c": "434d99fc8fdf4b023646f6cfc31dd4ac",
".git/objects/5e/35e65b7fd650df01ad1de21e4f13f1e10aa0fd": "578adb7e42efb86aa134b9d87d201d8d",
".git/objects/68/43fddc6aef172d5576ecce56160b1c73bc0f85": "2a91c358adf65703ab820ee54e7aff37",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/6b/d9a63e5a834d23e554cd5a5b06f8aaf934db00": "710b6c151c49b8bd382cc9dee96bb75f",
".git/objects/6d/eb2293c1a6aa532fe263a7ac3e8f95398c23f3": "22463a0a1a9696a2b083238f2e1880ff",
".git/objects/6f/7661bc79baa113f478e9a717e0c4959a3f3d27": "985be3a6935e9d31febd5205a9e04c4e",
".git/objects/70/c1a959d5ae95adcaeb2949ea4bc024347b2dc5": "41d92997c487689f9598407239f5ec64",
".git/objects/72/e9f453abb7bc959445caff5a72386cef2fbbc0": "b46c9fbf90f50b142b31ec7dc958f5c7",
".git/objects/75/a640ace9dfdb7fa534756c7415d37789cef412": "a18e07d845055d3b4d84ca9d23c58744",
".git/objects/75/d8ac4bfa4b8917b7a4766131e632146f450547": "1d461b54bc4a1142200d3d71ba687c01",
".git/objects/7a/7cd37b4540d0bb662ac4a1286f26dd05fd987b": "efb7cc9e37b0fb902f020d16b1ceeef1",
".git/objects/7c/3463b788d022128d17b29072564326f1fd8819": "37fee507a59e935fc85169a822943ba2",
".git/objects/80/937ba79992d5ce285eb67eb5df8ff8c13acc9f": "28c11f34ad732cb9c6a5f070e39daff6",
".git/objects/85/63aed2175379d2e75ec05ec0373a302730b6ad": "997f96db42b2dde7c208b10d023a5a8e",
".git/objects/87/91991198f1b72abb016db23eea39917fa0d40a": "3e55c2e0e6c2e1526fbffe2e38e8a43f",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8d/6c7493f5c20c8262a16a58341d13a1b09ddf6b": "cdbc9940c1390aba43701adc58dcb832",
".git/objects/8e/21753cdb204192a414b235db41da6a8446c8b4": "1e467e19cabb5d3d38b8fe200c37479e",
".git/objects/90/36c46e77638a69ebc5aee3bd85e81087e2e83c": "a03e7ca2d179d68cffe4578c61d1088c",
".git/objects/92/65271423f84461d77884d2951fb8bc3d1fd82a": "b19ea62170f08eea8d0867d33c16947d",
".git/objects/93/29be506b2ac73d3652266c3e3f93fb36b18600": "3da16e3d8802fca930f64bc41021c151",
".git/objects/93/b363f37b4951e6c5b9e1932ed169c9928b1e90": "c8d74fb3083c0dc39be8cff78a1d4dd5",
".git/objects/95/f72be85255d9a67c2382c7f89efc81c065ffb6": "241dab59d6da7f969328fe6dd0ee8325",
".git/objects/97/f37f09477aa80635d3bac2cc942dded802e077": "8fc4624a97a3fa9957a091d3505b7328",
".git/objects/9a/5283756799f81ccd112043db1174cf4cc8e9f2": "28014e10e802ddd5045f3ce80bb75ba9",
".git/objects/9f/9a8bde7c58915892845d4046ae6846f3b5822e": "754f942bc725b22e43a30bb8c4a2c0a6",
".git/objects/a1/b9bd9b182c76362be72b907d1af22d3c62c0f9": "4ce205bd3a5089b8b857461999a53594",
".git/objects/a2/578b71b853416f25d9f10f4f1e8135b0df99db": "9c4dc02c1393251cf3775227151adc03",
".git/objects/a3/d50913b54dac73d29e7a8e38dfce0b8d27ca4c": "d484ef97cb17af4d657a5dcc6a1888a3",
".git/objects/a7/3f4b23dde68ce5a05ce4c658ccd690c7f707ec": "ee275830276a88bac752feff80ed6470",
".git/objects/ad/ced61befd6b9d30829511317b07b72e66918a1": "37e7fcca73f0b6930673b256fac467ae",
".git/objects/ad/d11dceb888dcada9025c87856f30240e659622": "700a9ff5568bc91ea4c5c088e05bb4e4",
".git/objects/ae/513e37fba1176a6910837058124e54f55b4e3b": "624e96b8c7a8a39fb9177f3e148df52e",
".git/objects/b3/ec07489f4f439aa20e090df906b0487764d21a": "b1596fa5d3976abe1b8ee10c96292146",
".git/objects/b4/767e9a9782ef846346face75bb3dacf4a390ec": "c64db0247c24e3483c98c784549258ac",
".git/objects/b4/946fa26c792863913fb669edfe3e5289bbeaef": "07143a36f1e7c73e21729185ad64add7",
".git/objects/b6/b81563c6dc47fca7d5bfcd66855b6379a45167": "2c1b8e6cfbaeb6471623b700d6a28c94",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b8/4ea327727b9550834e7956dd5fc04c10e7272f": "36cc05a712e12264be63676891f4941a",
".git/objects/b8/8687c11ac8d0887d803d72e66e5cc5eb92ac5c": "3450351db8b966ae0b2d0291eb30702d",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/3e39bd49dfaf9e225bb598cd9644f833badd9a": "666b0d595ebbcc37f0c7b61220c18864",
".git/objects/b9/9df8ee4156162abe4ab3c7615d14b7741591b2": "3ddf5619537617c57aaf44e8875e0140",
".git/objects/ba/1f4af16a06af253c21466b988f78359271d423": "f57faf8b7f76325a18f3c076492b9095",
".git/objects/bc/b7713842d00592981d06cf6d93eab30d929bc4": "d56358ea8a9b49a05d41881b2a6f9830",
".git/objects/bd/c3df7d8166bf70f90ea3bd9349fb8391a5595d": "61e03cab3dfb4a183abb34817354e603",
".git/objects/be/6423959e0ef960ff3aea67b18b7e9e766c8db1": "0a08937ae63e85d16c0aa6bb09e7993b",
".git/objects/bf/ffdeb89a7bdbc721f13acbe395945c79536cc9": "ad12cfa90d26f370ecb459142ea5e3ec",
".git/objects/c3/7b19966dc97523fb3e584aeb2aeed4dc23f6b0": "12ef1bbfe948636ed8a2a0891de8a00b",
".git/objects/c6/7f9e51701e15a4ff442552dee2a85be1dd8ca0": "c9448d3247b7910147976b7af8d61ff7",
".git/objects/c8/0edbfac571904140ada8b9b41008e1d7a224f9": "c87c2055a725a7a8c91f82093215e522",
".git/objects/c8/3af99da428c63c1f82efdcd11c8d5297bddb04": "144ef6d9a8ff9a753d6e3b9573d5242f",
".git/objects/ca/06c407a9f298d272174ae3732efd81d603c257": "6a317a57ee0e866756bc456641396d5a",
".git/objects/cc/872e48ed08a6c3161adb2ad0cb55477b892b6c": "f6f1e6582ed11641b0fac428a4c58eed",
".git/objects/d1/0fb8b9b29667d4a4d7b2018409be92f38ea365": "cfc2ae124b0d766678148599dc7fd441",
".git/objects/d3/ac68f6babffc58d0103e424a0a56a0fa3bdecc": "0af41a83a11a06721a02c83bd9497bdd",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d8/a3a3a153a3987f5d7a5a748e090639349e6e0d": "2288f66cce945c7cecf38a2ffafea3a4",
".git/objects/d9/5a315ddd21f0db1de8f486f5445c67cacdfb1d": "9d0d7742c6716be5e64ebdc43ea22d27",
".git/objects/d9/5b1d3499b3b3d3989fa2a461151ba2abd92a07": "a072a09ac2efe43c8d49b7356317e52e",
".git/objects/dc/30cc03cabb1f6fc5f548c3fb5ebf3bab03bcab": "5114909039cf2a94a45f872701c0fc2e",
".git/objects/dd/5817ff72a39472723b6e8ad0128720269db445": "c6cfa6f51c51a2b1207f678bbbcce58e",
".git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391": "c70c34cbeefd40e7c0149b7a0c2c64c2",
".git/objects/e7/54376e2cdb3c23c45df2d77ea3cce9c7084010": "84d299c57efa56cb26e345f9aa26f1a4",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/ea/788af8322e47f94439f75313760418ccf8b903": "ab3dbf109e4b82570bc333ca5af968b5",
".git/objects/ea/a8fc6ce8df58ca06c3b5120a9240c0218be3f7": "8eb72b7dc2a11c22f3e86a38e2c2dde4",
".git/objects/eb/7c7402c08ffefdb00536b6be27946535fa9f63": "50e07689032d9638a3693308bd5587af",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ed/8becfdfafece9c2f4324eea53f0cd916e28051": "3a3fed21e7813e904c814357c28f9855",
".git/objects/ed/c718d2a1aff0257844d35e7ca7aeaebc5201e3": "681105e15021ab7d14eb37e48222190c",
".git/objects/f1/04a2be1d61ff2ca69f7c11f0fde9bf5f0119dd": "eedb15a6bb10f2166daf62ceface4f62",
".git/objects/f3/3e0726c3581f96c51f862cf61120af36599a32": "afcaefd94c5f13d3da610e0defa27e50",
".git/objects/f3/51a125ea1f66891f4a6e4651bbe3a014ef16c1": "1b56bc779957e09f1cfb1a020b07883e",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/f6/e6c75d6f1151eeb165a90f04b4d99effa41e83": "95ea83d65d44e4c524c6d51286406ac8",
".git/objects/fa/0a562524bf88f11906872d5e4e1302d2c630de": "95508da8e3f52ad9f1264e7c5a121077",
".git/objects/fd/05cfbc927a4fedcbe4d6d4b62e2c1ed8918f26": "5675c69555d005a1a244cc8ba90a402c",
".git/refs/heads/main": "4865029cf51b0499d77635f82104f51c",
".git/refs/remotes/origin/main": "4865029cf51b0499d77635f82104f51c",
"assets/AssetManifest.bin": "76bd443920f2c63f455d6cb8628ed995",
"assets/AssetManifest.bin.json": "7cce5f7faeba5f6cfc711e70122b5725",
"assets/dataDefault/conections.csv": "d41d8cd98f00b204e9800998ecf8427e",
"assets/dataDefault/empleoyes.csv": "3821d52440a35121a57b5b85937dc549",
"assets/dataDefault/factories.csv": "d503d6a9b9ff9560847cdcb5b7f375b1",
"assets/dataDefault/lines.csv": "35bbbb2599dd03b5d9265fcf64763297",
"assets/dataDefault/mails.csv": "917f85e750a5bccf1beab9fc34460e35",
"assets/dataDefault/routes.csv": "952ba73c25263ac83ae2b64fb99010c6",
"assets/dataDefault/sectors.csv": "9ce4b25977a721b95c52f4fafceec56b",
"assets/FontManifest.json": "3625e415bb2494b494e72b607845657e",
"assets/fonts/MaterialIcons-Regular.otf": "37eea2be457d1bb0c5b4a48dd7b127bd",
"assets/NOTICES": "3220c6c527a112655af350fe0c554d10",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/fluent_ui/assets/AcrylicNoise.png": "81f27726c45346351eca125bd062e9a7",
"assets/packages/fluent_ui/fonts/FluentIcons.ttf": "f3c4f09a37ace3246250ff7142da5cdd",
"assets/packages/fluent_ui/fonts/SegoeIcons.ttf": "5c053a34db297a1a533e62815a9b8827",
"assets/packages/l10n_flutter/lib/examples/resources/demo3/en.json": "9f044a5af0ad702dc5650c90b3b769f2",
"assets/packages/l10n_flutter/lib/examples/resources/demo3/en_GB.json": "013e62651a833fae8b56744b03aa8a15",
"assets/packages/l10n_flutter/lib/examples/resources/demo3/en_US.json": "013e62651a833fae8b56744b03aa8a15",
"assets/packages/l10n_flutter/lib/examples/resources/demo3/he.json": "79771c7d83e534d81fcc956cdba00880",
"assets/packages/l10n_flutter/lib/examples/resources/demo3/he_IL.json": "d5c8c1a6e3e42d4767ef94d548d6759d",
"assets/packages/l10n_flutter/lib/examples/resources/demo3/ru.json": "4d8037d72e6965d015420262154034d9",
"assets/packages/l10n_flutter/lib/examples/resources/demo3/ru_RU.json": "94d52f0ae35220aabef48ac30d038ea7",
"assets/packages/l10n_flutter/lib/examples/resources/l10n/en.json": "1610af616e72bf7a2e7b59fdae5a637b",
"assets/packages/l10n_flutter/lib/examples/resources/l10n/en_GB.json": "8fc2d2e6737dd939efb25975ffd6410d",
"assets/packages/l10n_flutter/lib/examples/resources/l10n/en_US.json": "9ce1190f867ea2f251dd9cd297a1c676",
"assets/packages/l10n_flutter/lib/examples/resources/l10n/he.json": "a793ffad1263d51a8e9f96595f71ae95",
"assets/packages/l10n_flutter/lib/examples/resources/l10n/he_IL.json": "64abcd088c18b55b739db65110fb30fe",
"assets/packages/l10n_flutter/lib/examples/resources/l10n/report.html": "abc634400feaf09a4c78177d4fd797ed",
"assets/packages/l10n_flutter/lib/examples/resources/l10n/ru.json": "efd43ff773dcd4dd6a7480331f589ea1",
"assets/packages/l10n_flutter/lib/examples/resources/l10n/ru_RU.json": "94de79e034827beef2fbb310b79f7335",
"assets/packages/rflutter_alert/assets/images/2.0x/close.png": "abaa692ee4fa94f76ad099a7a437bd4f",
"assets/packages/rflutter_alert/assets/images/2.0x/icon_error.png": "2da9704815c606109493d8af19999a65",
"assets/packages/rflutter_alert/assets/images/2.0x/icon_info.png": "612ea65413e042e3df408a8548cefe71",
"assets/packages/rflutter_alert/assets/images/2.0x/icon_success.png": "7d6abdd1b85e78df76b2837996749a43",
"assets/packages/rflutter_alert/assets/images/2.0x/icon_warning.png": "e4606e6910d7c48132912eb818e3a55f",
"assets/packages/rflutter_alert/assets/images/3.0x/close.png": "98d2de9ca72dc92b1c9a2835a7464a8c",
"assets/packages/rflutter_alert/assets/images/3.0x/icon_error.png": "15ca57e31f94cadd75d8e2b2098239bd",
"assets/packages/rflutter_alert/assets/images/3.0x/icon_info.png": "e68e8527c1eb78949351a6582469fe55",
"assets/packages/rflutter_alert/assets/images/3.0x/icon_success.png": "1c04416085cc343b99d1544a723c7e62",
"assets/packages/rflutter_alert/assets/images/3.0x/icon_warning.png": "e5f369189faa13e7586459afbe4ffab9",
"assets/packages/rflutter_alert/assets/images/close.png": "13c168d8841fcaba94ee91e8adc3617f",
"assets/packages/rflutter_alert/assets/images/icon_error.png": "f2b71a724964b51ac26239413e73f787",
"assets/packages/rflutter_alert/assets/images/icon_info.png": "3f71f68cae4d420cecbf996f37b0763c",
"assets/packages/rflutter_alert/assets/images/icon_success.png": "8bb472ce3c765f567aa3f28915c1a8f4",
"assets/packages/rflutter_alert/assets/images/icon_warning.png": "ccfc1396d29de3ac730da38a8ab20098",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "46394dcc63119d4ec1cefe4033256c0a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "d3c0457edbb5c0fe0e18df9a0d2d3e65",
"/": "d3c0457edbb5c0fe0e18df9a0d2d3e65",
"main.dart.js": "9eb8ec3540557c1a326b87e351b2225a",
"manifest.json": "073bc2305adf116c638a9168ec0b6207",
"version.json": "e278ada0d4f08ddcbd4db3ba0eb5aa11"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
