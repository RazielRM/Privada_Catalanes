; ModuleID = 'marshal_methods.x86.ll'
source_filename = "marshal_methods.x86.ll"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i686-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [146 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [292 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 105
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 104
	i32 39109920, ; 2: Newtonsoft.Json.dll => 0x254c520 => 51
	i32 39485524, ; 3: System.Net.WebSockets.dll => 0x25a8054 => 113
	i32 42639949, ; 4: System.Threading.Thread => 0x28aa24d => 135
	i32 67008169, ; 5: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 33
	i32 72070932, ; 6: Microsoft.Maui.Graphics.dll => 0x44bb714 => 49
	i32 117431740, ; 7: System.Runtime.InteropServices => 0x6ffddbc => 122
	i32 122350210, ; 8: System.Threading.Channels.dll => 0x74aea82 => 134
	i32 142721839, ; 9: System.Net.WebHeaderCollection => 0x881c32f => 110
	i32 165246403, ; 10: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 57
	i32 182336117, ; 11: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 75
	i32 195452805, ; 12: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 30
	i32 199333315, ; 13: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 31
	i32 205061960, ; 14: System.ComponentModel => 0xc38ff48 => 90
	i32 230752869, ; 15: Microsoft.CSharp.dll => 0xdc10265 => 83
	i32 246610117, ; 16: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 120
	i32 280992041, ; 17: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 2
	i32 317674968, ; 18: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 30
	i32 318968648, ; 19: Xamarin.AndroidX.Activity.dll => 0x13031348 => 53
	i32 336156722, ; 20: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 15
	i32 342366114, ; 21: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 64
	i32 356389973, ; 22: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 14
	i32 379916513, ; 23: System.Threading.Thread.dll => 0x16a510e1 => 135
	i32 385762202, ; 24: System.Memory.dll => 0x16fe439a => 102
	i32 393699800, ; 25: Firebase => 0x177761d8 => 35
	i32 395744057, ; 26: _Microsoft.Android.Resource.Designer => 0x17969339 => 34
	i32 435591531, ; 27: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 26
	i32 442565967, ; 28: System.Collections => 0x1a61054f => 87
	i32 450948140, ; 29: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 63
	i32 451504562, ; 30: System.Security.Cryptography.X509Certificates => 0x1ae969b2 => 128
	i32 459347974, ; 31: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 126
	i32 469710990, ; 32: System.dll => 0x1bff388e => 140
	i32 478296930, ; 33: MQTTnet => 0x1c823b62 => 50
	i32 498788369, ; 34: System.ObjectModel => 0x1dbae811 => 115
	i32 500358224, ; 35: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 13
	i32 503918385, ; 36: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 7
	i32 513247710, ; 37: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 44
	i32 539058512, ; 38: Microsoft.Extensions.Logging => 0x20216150 => 41
	i32 592146354, ; 39: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 21
	i32 610194910, ; 40: System.Reactive.dll => 0x245ed5de => 52
	i32 627609679, ; 41: Xamarin.AndroidX.CustomView => 0x2568904f => 61
	i32 627931235, ; 42: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 19
	i32 662205335, ; 43: System.Text.Encodings.Web.dll => 0x27787397 => 131
	i32 663517072, ; 44: Xamarin.AndroidX.VersionedParcelable => 0x278c7790 => 76
	i32 672442732, ; 45: System.Collections.Concurrent => 0x2814a96c => 84
	i32 683518922, ; 46: System.Net.Security => 0x28bdabca => 108
	i32 688181140, ; 47: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 1
	i32 690569205, ; 48: System.Xml.Linq.dll => 0x29293ff5 => 137
	i32 706645707, ; 49: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 16
	i32 709557578, ; 50: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 4
	i32 722857257, ; 51: System.Runtime.Loader.dll => 0x2b15ed29 => 123
	i32 759454413, ; 52: System.Net.Requests => 0x2d445acd => 107
	i32 775507847, ; 53: System.IO.Compression => 0x2e394f87 => 99
	i32 777317022, ; 54: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 25
	i32 789151979, ; 55: Microsoft.Extensions.Options => 0x2f0980eb => 43
	i32 804715423, ; 56: System.Data.Common => 0x2ff6fb9f => 92
	i32 823281589, ; 57: System.Private.Uri.dll => 0x311247b5 => 116
	i32 830298997, ; 58: System.IO.Compression.Brotli => 0x317d5b75 => 98
	i32 904024072, ; 59: System.ComponentModel.Primitives.dll => 0x35e25008 => 88
	i32 926902833, ; 60: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 28
	i32 955402788, ; 61: Newtonsoft.Json => 0x38f24a24 => 51
	i32 967690846, ; 62: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 64
	i32 975874589, ; 63: System.Xml.XDocument => 0x3a2aaa1d => 139
	i32 992768348, ; 64: System.Collections.dll => 0x3b2c715c => 87
	i32 1012816738, ; 65: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 74
	i32 1019214401, ; 66: System.Drawing => 0x3cbffa41 => 96
	i32 1028951442, ; 67: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 40
	i32 1029334545, ; 68: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 3
	i32 1035644815, ; 69: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 54
	i32 1036536393, ; 70: System.Drawing.Primitives.dll => 0x3dc84a49 => 95
	i32 1044663988, ; 71: System.Linq.Expressions.dll => 0x3e444eb4 => 100
	i32 1052210849, ; 72: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 66
	i32 1082857460, ; 73: System.ComponentModel.TypeConverter => 0x408b17f4 => 89
	i32 1084122840, ; 74: Xamarin.Kotlin.StdLib => 0x409e66d8 => 80
	i32 1098259244, ; 75: System => 0x41761b2c => 140
	i32 1118262833, ; 76: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 16
	i32 1168523401, ; 77: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 22
	i32 1178241025, ; 78: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 71
	i32 1203215381, ; 79: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 20
	i32 1234928153, ; 80: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 18
	i32 1260983243, ; 81: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 2
	i32 1293217323, ; 82: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 62
	i32 1324164729, ; 83: System.Linq => 0x4eed2679 => 101
	i32 1373134921, ; 84: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 32
	i32 1376866003, ; 85: Xamarin.AndroidX.SavedState => 0x52114ed3 => 74
	i32 1406073936, ; 86: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 58
	i32 1408764838, ; 87: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 125
	i32 1430672901, ; 88: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 0
	i32 1452070440, ; 89: System.Formats.Asn1.dll => 0x568cd628 => 97
	i32 1458022317, ; 90: System.Net.Security.dll => 0x56e7a7ad => 108
	i32 1461004990, ; 91: es\Microsoft.Maui.Controls.resources => 0x57152abe => 6
	i32 1462112819, ; 92: System.IO.Compression.dll => 0x57261233 => 99
	i32 1469204771, ; 93: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 55
	i32 1470490898, ; 94: Microsoft.Extensions.Primitives => 0x57a5e912 => 44
	i32 1480492111, ; 95: System.IO.Compression.Brotli.dll => 0x583e844f => 98
	i32 1493001747, ; 96: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 10
	i32 1514721132, ; 97: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 5
	i32 1543031311, ; 98: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 133
	i32 1551623176, ; 99: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 25
	i32 1618516317, ; 100: System.Net.WebSockets.Client.dll => 0x6078995d => 112
	i32 1622152042, ; 101: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 68
	i32 1624863272, ; 102: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 78
	i32 1636350590, ; 103: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 60
	i32 1639515021, ; 104: System.Net.Http.dll => 0x61b9038d => 103
	i32 1639986890, ; 105: System.Text.RegularExpressions => 0x61c036ca => 133
	i32 1657153582, ; 106: System.Runtime => 0x62c6282e => 127
	i32 1658251792, ; 107: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 79
	i32 1677501392, ; 108: System.Net.Primitives.dll => 0x63fca3d0 => 106
	i32 1678508291, ; 109: System.Net.WebSockets => 0x640c0103 => 113
	i32 1679769178, ; 110: System.Security.Cryptography => 0x641f3e5a => 129
	i32 1729485958, ; 111: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 56
	i32 1736233607, ; 112: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 23
	i32 1743415430, ; 113: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 1
	i32 1763938596, ; 114: System.Diagnostics.TraceSource.dll => 0x69239124 => 94
	i32 1766324549, ; 115: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 75
	i32 1770582343, ; 116: Microsoft.Extensions.Logging.dll => 0x6988f147 => 41
	i32 1780572499, ; 117: Mono.Android.Runtime.dll => 0x6a216153 => 144
	i32 1782862114, ; 118: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 17
	i32 1788241197, ; 119: Xamarin.AndroidX.Fragment => 0x6a96652d => 63
	i32 1793755602, ; 120: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 9
	i32 1808609942, ; 121: Xamarin.AndroidX.Loader => 0x6bcd3296 => 68
	i32 1813058853, ; 122: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 80
	i32 1813201214, ; 123: Xamarin.Google.Android.Material => 0x6c13413e => 79
	i32 1818569960, ; 124: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 72
	i32 1824175904, ; 125: System.Text.Encoding.Extensions => 0x6cbab720 => 130
	i32 1824722060, ; 126: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 125
	i32 1828688058, ; 127: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 42
	i32 1842015223, ; 128: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 29
	i32 1853025655, ; 129: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 26
	i32 1858542181, ; 130: System.Linq.Expressions => 0x6ec71a65 => 100
	i32 1870277092, ; 131: System.Reflection.Primitives => 0x6f7a29e4 => 121
	i32 1875935024, ; 132: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 8
	i32 1910275211, ; 133: System.Collections.NonGeneric.dll => 0x71dc7c8b => 85
	i32 1939592360, ; 134: System.Private.Xml.Linq => 0x739bd4a8 => 117
	i32 1968388702, ; 135: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 37
	i32 2003115576, ; 136: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 5
	i32 2019465201, ; 137: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 66
	i32 2025202353, ; 138: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 0
	i32 2045470958, ; 139: System.Private.Xml => 0x79eb68ee => 118
	i32 2055257422, ; 140: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 65
	i32 2066184531, ; 141: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 4
	i32 2070888862, ; 142: System.Diagnostics.TraceSource => 0x7b6f419e => 94
	i32 2079903147, ; 143: System.Runtime.dll => 0x7bf8cdab => 127
	i32 2090596640, ; 144: System.Numerics.Vectors => 0x7c9bf920 => 114
	i32 2127167465, ; 145: System.Console => 0x7ec9ffe9 => 91
	i32 2131563149, ; 146: APPBASE.dll => 0x7f0d128d => 82
	i32 2142473426, ; 147: System.Collections.Specialized => 0x7fb38cd2 => 86
	i32 2159891885, ; 148: Microsoft.Maui => 0x80bd55ad => 47
	i32 2169148018, ; 149: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 12
	i32 2181898931, ; 150: Microsoft.Extensions.Options.dll => 0x820d22b3 => 43
	i32 2192057212, ; 151: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 42
	i32 2193016926, ; 152: System.ObjectModel.dll => 0x82b6c85e => 115
	i32 2201107256, ; 153: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 81
	i32 2201231467, ; 154: System.Net.Http => 0x8334206b => 103
	i32 2207618523, ; 155: it\Microsoft.Maui.Controls.resources => 0x839595db => 14
	i32 2266799131, ; 156: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 38
	i32 2270573516, ; 157: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 8
	i32 2279755925, ; 158: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 73
	i32 2295906218, ; 159: System.Net.Sockets => 0x88d8bfaa => 109
	i32 2303942373, ; 160: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 18
	i32 2305521784, ; 161: System.Private.CoreLib.dll => 0x896b7878 => 142
	i32 2353062107, ; 162: System.Net.Primitives => 0x8c40e0db => 106
	i32 2368005991, ; 163: System.Xml.ReaderWriter.dll => 0x8d24e767 => 138
	i32 2371007202, ; 164: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 37
	i32 2395872292, ; 165: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 13
	i32 2427813419, ; 166: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 10
	i32 2435356389, ; 167: System.Console.dll => 0x912896e5 => 91
	i32 2458678730, ; 168: System.Net.Sockets.dll => 0x928c75ca => 109
	i32 2471841756, ; 169: netstandard.dll => 0x93554fdc => 141
	i32 2475788418, ; 170: Java.Interop.dll => 0x93918882 => 143
	i32 2480646305, ; 171: Microsoft.Maui.Controls => 0x93dba8a1 => 45
	i32 2538310050, ; 172: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 120
	i32 2550873716, ; 173: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 11
	i32 2562349572, ; 174: Microsoft.CSharp => 0x98ba5a04 => 83
	i32 2570120770, ; 175: System.Text.Encodings.Web => 0x9930ee42 => 131
	i32 2585220780, ; 176: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 130
	i32 2593496499, ; 177: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 20
	i32 2605712449, ; 178: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 81
	i32 2617129537, ; 179: System.Private.Xml.dll => 0x9bfe3a41 => 118
	i32 2620871830, ; 180: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 60
	i32 2626831493, ; 181: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 15
	i32 2663698177, ; 182: System.Runtime.Loader => 0x9ec4cf01 => 123
	i32 2664396074, ; 183: System.Xml.XDocument.dll => 0x9ecf752a => 139
	i32 2665622720, ; 184: System.Drawing.Primitives => 0x9ee22cc0 => 95
	i32 2676780864, ; 185: System.Data.Common.dll => 0x9f8c6f40 => 92
	i32 2724373263, ; 186: System.Runtime.Numerics.dll => 0xa262a30f => 124
	i32 2732626843, ; 187: Xamarin.AndroidX.Activity => 0xa2e0939b => 53
	i32 2735172069, ; 188: System.Threading.Channels => 0xa30769e5 => 134
	i32 2737747696, ; 189: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 55
	i32 2752995522, ; 190: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 21
	i32 2758225723, ; 191: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 46
	i32 2764765095, ; 192: Microsoft.Maui.dll => 0xa4caf7a7 => 47
	i32 2778768386, ; 193: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 77
	i32 2785988530, ; 194: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 27
	i32 2801831435, ; 195: Microsoft.Maui.Graphics => 0xa7008e0b => 49
	i32 2806116107, ; 196: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 6
	i32 2810250172, ; 197: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 58
	i32 2831556043, ; 198: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 19
	i32 2853208004, ; 199: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 77
	i32 2861189240, ; 200: Microsoft.Maui.Essentials => 0xaa8a4878 => 48
	i32 2909740682, ; 201: System.Private.CoreLib => 0xad6f1e8a => 142
	i32 2916838712, ; 202: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 78
	i32 2919462931, ; 203: System.Numerics.Vectors.dll => 0xae037813 => 114
	i32 2959614098, ; 204: System.ComponentModel.dll => 0xb0682092 => 90
	i32 2978675010, ; 205: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 62
	i32 2997658596, ; 206: MQTTnet.dll => 0xb2aca3e4 => 50
	i32 3038032645, ; 207: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 34
	i32 3057625584, ; 208: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 69
	i32 3059408633, ; 209: Mono.Android.Runtime => 0xb65adef9 => 144
	i32 3059793426, ; 210: System.ComponentModel.Primitives => 0xb660be12 => 88
	i32 3077302341, ; 211: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 12
	i32 3090735792, ; 212: System.Security.Cryptography.X509Certificates.dll => 0xb838e2b0 => 128
	i32 3103600923, ; 213: System.Formats.Asn1 => 0xb8fd311b => 97
	i32 3159123045, ; 214: System.Reflection.Primitives.dll => 0xbc4c6465 => 121
	i32 3178803400, ; 215: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 70
	i32 3220365878, ; 216: System.Threading => 0xbff2e236 => 136
	i32 3258312781, ; 217: Xamarin.AndroidX.CardView => 0xc235e84d => 56
	i32 3305363605, ; 218: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 7
	i32 3316684772, ; 219: System.Net.Requests.dll => 0xc5b097e4 => 107
	i32 3317135071, ; 220: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 61
	i32 3322403133, ; 221: Firebase.dll => 0xc607d93d => 35
	i32 3346324047, ; 222: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 71
	i32 3357674450, ; 223: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 24
	i32 3358260929, ; 224: System.Text.Json => 0xc82afec1 => 132
	i32 3362522851, ; 225: Xamarin.AndroidX.Core => 0xc86c06e3 => 59
	i32 3366347497, ; 226: Java.Interop => 0xc8a662e9 => 143
	i32 3374999561, ; 227: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 73
	i32 3381016424, ; 228: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 3
	i32 3428513518, ; 229: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 39
	i32 3430777524, ; 230: netstandard => 0xcc7d82b4 => 141
	i32 3463511458, ; 231: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 11
	i32 3471940407, ; 232: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 89
	i32 3476120550, ; 233: Mono.Android => 0xcf3163e6 => 145
	i32 3479583265, ; 234: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 24
	i32 3484440000, ; 235: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 23
	i32 3485117614, ; 236: System.Text.Json.dll => 0xcfbaacae => 132
	i32 3509114376, ; 237: System.Xml.Linq => 0xd128d608 => 137
	i32 3580758918, ; 238: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 31
	i32 3596207933, ; 239: LiteDB.dll => 0xd659c73d => 36
	i32 3598340787, ; 240: System.Net.WebSockets.Client => 0xd67a52b3 => 112
	i32 3608519521, ; 241: System.Linq.dll => 0xd715a361 => 101
	i32 3629588173, ; 242: LiteDB => 0xd8571ecd => 36
	i32 3641597786, ; 243: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 65
	i32 3643446276, ; 244: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 28
	i32 3643854240, ; 245: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 70
	i32 3657292374, ; 246: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 38
	i32 3660523487, ; 247: System.Net.NetworkInformation => 0xda2f27df => 105
	i32 3672681054, ; 248: Mono.Android.dll => 0xdae8aa5e => 145
	i32 3697841164, ; 249: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 33
	i32 3700866549, ; 250: System.Net.WebProxy.dll => 0xdc96bdf5 => 111
	i32 3724971120, ; 251: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 69
	i32 3731644420, ; 252: System.Reactive => 0xde6c6004 => 52
	i32 3732100267, ; 253: System.Net.NameResolution => 0xde7354ab => 104
	i32 3748608112, ; 254: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 93
	i32 3786282454, ; 255: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 57
	i32 3792276235, ; 256: System.Collections.NonGeneric => 0xe2098b0b => 85
	i32 3802395368, ; 257: System.Collections.Specialized.dll => 0xe2a3f2e8 => 86
	i32 3819260425, ; 258: System.Net.WebProxy => 0xe3a54a09 => 111
	i32 3823082795, ; 259: System.Security.Cryptography.dll => 0xe3df9d2b => 129
	i32 3841636137, ; 260: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 40
	i32 3849253459, ; 261: System.Runtime.InteropServices.dll => 0xe56ef253 => 122
	i32 3885497537, ; 262: System.Net.WebHeaderCollection.dll => 0xe797fcc1 => 110
	i32 3889960447, ; 263: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 32
	i32 3896106733, ; 264: System.Collections.Concurrent.dll => 0xe839deed => 84
	i32 3896760992, ; 265: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 59
	i32 3921031405, ; 266: Xamarin.AndroidX.VersionedParcelable.dll => 0xe9b630ed => 76
	i32 3928044579, ; 267: System.Xml.ReaderWriter => 0xea213423 => 138
	i32 3931092270, ; 268: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 72
	i32 3955647286, ; 269: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 54
	i32 3980434154, ; 270: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 27
	i32 3987592930, ; 271: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 9
	i32 4025784931, ; 272: System.Memory => 0xeff49a63 => 102
	i32 4046471985, ; 273: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 46
	i32 4054681211, ; 274: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 119
	i32 4068434129, ; 275: System.Private.Xml.Linq.dll => 0xf27f60d1 => 117
	i32 4073602200, ; 276: System.Threading.dll => 0xf2ce3c98 => 136
	i32 4094352644, ; 277: Microsoft.Maui.Essentials.dll => 0xf40add04 => 48
	i32 4099507663, ; 278: System.Drawing.dll => 0xf45985cf => 96
	i32 4100113165, ; 279: System.Private.Uri => 0xf462c30d => 116
	i32 4102112229, ; 280: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 22
	i32 4125707920, ; 281: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 17
	i32 4126470640, ; 282: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 39
	i32 4147896353, ; 283: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 119
	i32 4150914736, ; 284: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 29
	i32 4181436372, ; 285: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 126
	i32 4182413190, ; 286: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 67
	i32 4213026141, ; 287: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 93
	i32 4266170833, ; 288: APPBASE => 0xfe4899d1 => 82
	i32 4271975918, ; 289: Microsoft.Maui.Controls.dll => 0xfea12dee => 45
	i32 4274976490, ; 290: System.Runtime.Numerics => 0xfecef6ea => 124
	i32 4292120959 ; 291: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 67
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [292 x i32] [
	i32 105, ; 0
	i32 104, ; 1
	i32 51, ; 2
	i32 113, ; 3
	i32 135, ; 4
	i32 33, ; 5
	i32 49, ; 6
	i32 122, ; 7
	i32 134, ; 8
	i32 110, ; 9
	i32 57, ; 10
	i32 75, ; 11
	i32 30, ; 12
	i32 31, ; 13
	i32 90, ; 14
	i32 83, ; 15
	i32 120, ; 16
	i32 2, ; 17
	i32 30, ; 18
	i32 53, ; 19
	i32 15, ; 20
	i32 64, ; 21
	i32 14, ; 22
	i32 135, ; 23
	i32 102, ; 24
	i32 35, ; 25
	i32 34, ; 26
	i32 26, ; 27
	i32 87, ; 28
	i32 63, ; 29
	i32 128, ; 30
	i32 126, ; 31
	i32 140, ; 32
	i32 50, ; 33
	i32 115, ; 34
	i32 13, ; 35
	i32 7, ; 36
	i32 44, ; 37
	i32 41, ; 38
	i32 21, ; 39
	i32 52, ; 40
	i32 61, ; 41
	i32 19, ; 42
	i32 131, ; 43
	i32 76, ; 44
	i32 84, ; 45
	i32 108, ; 46
	i32 1, ; 47
	i32 137, ; 48
	i32 16, ; 49
	i32 4, ; 50
	i32 123, ; 51
	i32 107, ; 52
	i32 99, ; 53
	i32 25, ; 54
	i32 43, ; 55
	i32 92, ; 56
	i32 116, ; 57
	i32 98, ; 58
	i32 88, ; 59
	i32 28, ; 60
	i32 51, ; 61
	i32 64, ; 62
	i32 139, ; 63
	i32 87, ; 64
	i32 74, ; 65
	i32 96, ; 66
	i32 40, ; 67
	i32 3, ; 68
	i32 54, ; 69
	i32 95, ; 70
	i32 100, ; 71
	i32 66, ; 72
	i32 89, ; 73
	i32 80, ; 74
	i32 140, ; 75
	i32 16, ; 76
	i32 22, ; 77
	i32 71, ; 78
	i32 20, ; 79
	i32 18, ; 80
	i32 2, ; 81
	i32 62, ; 82
	i32 101, ; 83
	i32 32, ; 84
	i32 74, ; 85
	i32 58, ; 86
	i32 125, ; 87
	i32 0, ; 88
	i32 97, ; 89
	i32 108, ; 90
	i32 6, ; 91
	i32 99, ; 92
	i32 55, ; 93
	i32 44, ; 94
	i32 98, ; 95
	i32 10, ; 96
	i32 5, ; 97
	i32 133, ; 98
	i32 25, ; 99
	i32 112, ; 100
	i32 68, ; 101
	i32 78, ; 102
	i32 60, ; 103
	i32 103, ; 104
	i32 133, ; 105
	i32 127, ; 106
	i32 79, ; 107
	i32 106, ; 108
	i32 113, ; 109
	i32 129, ; 110
	i32 56, ; 111
	i32 23, ; 112
	i32 1, ; 113
	i32 94, ; 114
	i32 75, ; 115
	i32 41, ; 116
	i32 144, ; 117
	i32 17, ; 118
	i32 63, ; 119
	i32 9, ; 120
	i32 68, ; 121
	i32 80, ; 122
	i32 79, ; 123
	i32 72, ; 124
	i32 130, ; 125
	i32 125, ; 126
	i32 42, ; 127
	i32 29, ; 128
	i32 26, ; 129
	i32 100, ; 130
	i32 121, ; 131
	i32 8, ; 132
	i32 85, ; 133
	i32 117, ; 134
	i32 37, ; 135
	i32 5, ; 136
	i32 66, ; 137
	i32 0, ; 138
	i32 118, ; 139
	i32 65, ; 140
	i32 4, ; 141
	i32 94, ; 142
	i32 127, ; 143
	i32 114, ; 144
	i32 91, ; 145
	i32 82, ; 146
	i32 86, ; 147
	i32 47, ; 148
	i32 12, ; 149
	i32 43, ; 150
	i32 42, ; 151
	i32 115, ; 152
	i32 81, ; 153
	i32 103, ; 154
	i32 14, ; 155
	i32 38, ; 156
	i32 8, ; 157
	i32 73, ; 158
	i32 109, ; 159
	i32 18, ; 160
	i32 142, ; 161
	i32 106, ; 162
	i32 138, ; 163
	i32 37, ; 164
	i32 13, ; 165
	i32 10, ; 166
	i32 91, ; 167
	i32 109, ; 168
	i32 141, ; 169
	i32 143, ; 170
	i32 45, ; 171
	i32 120, ; 172
	i32 11, ; 173
	i32 83, ; 174
	i32 131, ; 175
	i32 130, ; 176
	i32 20, ; 177
	i32 81, ; 178
	i32 118, ; 179
	i32 60, ; 180
	i32 15, ; 181
	i32 123, ; 182
	i32 139, ; 183
	i32 95, ; 184
	i32 92, ; 185
	i32 124, ; 186
	i32 53, ; 187
	i32 134, ; 188
	i32 55, ; 189
	i32 21, ; 190
	i32 46, ; 191
	i32 47, ; 192
	i32 77, ; 193
	i32 27, ; 194
	i32 49, ; 195
	i32 6, ; 196
	i32 58, ; 197
	i32 19, ; 198
	i32 77, ; 199
	i32 48, ; 200
	i32 142, ; 201
	i32 78, ; 202
	i32 114, ; 203
	i32 90, ; 204
	i32 62, ; 205
	i32 50, ; 206
	i32 34, ; 207
	i32 69, ; 208
	i32 144, ; 209
	i32 88, ; 210
	i32 12, ; 211
	i32 128, ; 212
	i32 97, ; 213
	i32 121, ; 214
	i32 70, ; 215
	i32 136, ; 216
	i32 56, ; 217
	i32 7, ; 218
	i32 107, ; 219
	i32 61, ; 220
	i32 35, ; 221
	i32 71, ; 222
	i32 24, ; 223
	i32 132, ; 224
	i32 59, ; 225
	i32 143, ; 226
	i32 73, ; 227
	i32 3, ; 228
	i32 39, ; 229
	i32 141, ; 230
	i32 11, ; 231
	i32 89, ; 232
	i32 145, ; 233
	i32 24, ; 234
	i32 23, ; 235
	i32 132, ; 236
	i32 137, ; 237
	i32 31, ; 238
	i32 36, ; 239
	i32 112, ; 240
	i32 101, ; 241
	i32 36, ; 242
	i32 65, ; 243
	i32 28, ; 244
	i32 70, ; 245
	i32 38, ; 246
	i32 105, ; 247
	i32 145, ; 248
	i32 33, ; 249
	i32 111, ; 250
	i32 69, ; 251
	i32 52, ; 252
	i32 104, ; 253
	i32 93, ; 254
	i32 57, ; 255
	i32 85, ; 256
	i32 86, ; 257
	i32 111, ; 258
	i32 129, ; 259
	i32 40, ; 260
	i32 122, ; 261
	i32 110, ; 262
	i32 32, ; 263
	i32 84, ; 264
	i32 59, ; 265
	i32 76, ; 266
	i32 138, ; 267
	i32 72, ; 268
	i32 54, ; 269
	i32 27, ; 270
	i32 9, ; 271
	i32 102, ; 272
	i32 46, ; 273
	i32 119, ; 274
	i32 117, ; 275
	i32 136, ; 276
	i32 48, ; 277
	i32 96, ; 278
	i32 116, ; 279
	i32 22, ; 280
	i32 17, ; 281
	i32 39, ; 282
	i32 119, ; 283
	i32 29, ; 284
	i32 126, ; 285
	i32 67, ; 286
	i32 93, ; 287
	i32 82, ; 288
	i32 45, ; 289
	i32 124, ; 290
	i32 67 ; 291
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.4xx @ 82d8938cf80f6d5fa6c28529ddfbdb753d805ab4"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"NumRegisterParameters", i32 0}
