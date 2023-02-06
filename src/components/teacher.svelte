<script>
  import Event, { dispatch } from "../events/event.svelte";

const _instruments = {
    piano: {
        name: 'Piano',
        playable: [

        ]
    },
    violin: {
        name: 'Violin',
        playable: [
            'G3', 'D4', 'A4', 'E5',
            'G#3', 'D#4', 'A#4', 'F5',
            'A3', 'E4', 'B4', 'F#5',
            'A#3', 'F4', 'C5', 'G5',
            'B3', 'F#4', 'C#5', 'G#5',
            'C4', 'G4', 'D5', 'A5',
            'C#4', 'G#4', 'D#5', 'A#5',
            'D4', 'A4', 'E5', 'B5',
            'D#4', 'A#4', 'F5', 'C6',
            'E4', 'B4', 'F#5', 'C#6',
            'F4', 'C5', 'G5', 'D6',
            'F#4', 'C#5', 'G#5', 'D#6',
            'G4', 'D5', 'A5', 'E6',
            'G#4', 'D#5', 'A#5', 'F6',
            'A4', 'E5', 'B5', 'F#6',
            'A#4', 'F5', 'C6', 'G6',
            'B4', 'F#5', 'C#6', 'G#6',
            'C5', 'G5', 'D6', 'A6',
            'C#5', 'G#5', 'D#6', 'A#6',
            'D5', 'A5', 'E6', 'B6',
            'D#5', 'A#5', 'F6', 'C7',
            'E5', 'B5', 'F#6', 'C#7',
            'F5', 'C6', 'G6', 'D7',
            'F#5', 'C#6', 'G#6', 'D#7',
            'G5', 'D6', 'A6', 'E7',
            'G#5', 'D#6', 'A#6', 'F7',
            'A5', 'E6', 'B6', 'F#7',
            'A#5', 'F6', 'C7', 'G7',
            'B5', 'F#6', 'C#7', 'G#7',
            'C6', 'G6', 'D7', 'A7',
        ]
    },
    guitar: {
        name: 'Guitar',
        playable: [

        ]
    },
}

export let instrument = 'violin'

const _instrument = _instruments[instrument]

let currentNote = null
let played = {
    note: null,
    octave: 0,
    time: Date.now(),
}
const seconds = 3

const newRandomNote = () => {
    const index = Math.floor(Math.random() * _instrument.playable.length)
    const note = _instrument.playable[index]

    const octave = note[note.length - 1]
    const noteName = note.slice(0, note.length - 1)

    currentNote = {
        note: noteName,
        octave,
    }

    dispatch('teacher', currentNote)
    return currentNote
}

export const getNote = () => {
    return currentNote
}

const checkNote = (n) => {
    if (currentNote === null) {
        currentNote = newRandomNote()
    }

    if (n === '-') {
        return
    }

    const [note, octave] = [n.note, n.octave]

    const requirements = [
        note === currentNote.note,
        octave === currentNote.octave,
        Date.now() - played.time > seconds * 1000,
    ]

    if (requirements.every(r => r)) {
        newRandomNote()
        return
    }

    if (played.note != note || played.octave != octave) {
        played = {
            note: null,
            octave: 0,
            time: Date.now(),
        }
    }
}

</script>

<Event on:note={(e) => checkNote(e.note)} />