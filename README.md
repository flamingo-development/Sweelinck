
# Sweelinck
Named after the dutch composer [Jan Pieterszoon Sweelinck](https://en.wikipedia.org/wiki/Jan_Pieterszoon_Sweelinck). This is a small web app that is created to learn the notes on sheet music easily.

It does this by listening to the microphone and showing the note that is played.
It will give you a note to play and checks if you played the right note.

## Installation

### yarn

```bash
yarn
yarn run dev
```

### npm
```bash
npm install
npm run dev
```

### Docker (compose)
```bash
docker-compose up --build
```

## Uses

 - [Themes](https://github.com/hundredrabbits/Themes) for easy color themes
 - [PitchDetect](https://github.com/cwilso/PitchDetect/blob/main/js/pitchdetect.js#L287) for note detection
