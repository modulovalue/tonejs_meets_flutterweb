# Tone.js meets Flutter Web (A simple piano demo)
[![License](https://img.shields.io/github/license/modulovalue/tonejs_meets_flutterweb?style=flat-square&logo=github)](https://github.com/modulovalue/tonejs_meets_flutterweb/blob/master/LICENSE) [![Github Stars](https://img.shields.io/github/stars/modulovalue/tonejs_meets_flutterweb?style=flat-square&logo=github)](https://github.com/modulovalue/tonejs_meets_flutterweb) [![Twitter Follow](https://img.shields.io/twitter/follow/modulovalue?style=social&logo=twitter)](https://twitter.com/modulovalue) [![GitHub Follow](https://img.shields.io/github/followers/modulovalue?style=social&logo=github)](https://github.com/modulovalue)

A quick and dirty demo on how to use a JavaScript library with Flutter Web

[tonejs_meets_flutterweb](https://modulovalue.com/tonejs_meets_flutterweb) (Please use Google Chrome)

![Screenshot](assets/screenshot1.jpg)


## How to use JavaScript in your Flutter Web App. (It's really easy)
1. Add the JavaScript to your [web/index.html](https://github.com/modulovalue/tonejs_meets_flutterweb/blob/13fc08e1eb3d0c7fc7dc4bbe836d787a07ae0269/web/index.html#L15)

(In this case tone.js)
```html
...
<body>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tone/14.4.9/Tone.js" type="application/javascript"></script>
  <script src="main.dart.js" type="application/javascript"></script>
  <script>
    function playNote(note, duration) {
      var synth = new Tone.Synth().toDestination();
      synth.triggerAttackRelease(note, duration);
    }
  </script>
</body>
...
```

2. Call your JavaScript in Dart

```dart
import 'dart:js' as js;
...
js.context.callMethod("playNote", ["C5", "8n"])
```

Easy!
