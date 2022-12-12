<script>

export let updateNote = () => {};

const bufferLength = 2048;

export const start = async () => {
    const audioContext = new AudioContext();

    const stream = await navigator.mediaDevices.getUserMedia({
        audio: {
            mandatory: {
                googEchoCancellation: 'false',
                googAutoGainControl: 'false',
                googNoiseSuppression: 'false',
                googHighpassFilter: 'false'
            },
            optional: []
        }
    }).catch((err) => {
        console.log(err);
    });

    const source = audioContext.createMediaStreamSource(stream);
    const analyser = audioContext.createAnalyser();
    analyser.fftSize = bufferLength;

    source.connect(analyser);
    loop(audioContext, analyser);
}

//source: https://github.com/cwilso/PitchDetect/blob/main/js/pitchdetect.js#L287
const autoCorrelate = (buffer, sampleRate) => {
    let size = buffer.length;
    let rms = 0;

    for(let i = 0; i < size; i++) {
        let val = buffer[i];
        rms += val * val;
    }

    rms = Math.sqrt(rms / size);
    if(rms < 0.01) return -1;

    let r1 = 0;
    let r2 = size - 1;
    let threshold = 0.2;

    for(let i = 0; i < (size / 2); i++) {
        if(Math.abs(buffer[i]) < threshold) {
            r1 = i;
            break;
        }
    }

    for(let i = 1; i < (size / 2); i++) {
        if(Math.abs(buffer[size - i]) < threshold) {
            r2 = size - i;
            break;
        }
    }

    buffer = buffer.slice(r1, r2);
    size = buffer.length;

    let c = new Array(size).fill(0);
    for(let i = 0; i < size; i++) {
        for(let j = 0; j < size - i; j++) {
            c[i] = c[i] + buffer[j] * buffer[j + i];
        }
    }

    let d = 0;
    while(c[d] > c[d + 1]) d++;
    let maxval = -1;
    let maxpos = -1;
    for(let i = d; i < size; i++) {
        if(c[i] > maxval) {
            maxval = c[i];
            maxpos = i;
        }
    }

    let T0 = maxpos;

    let x1 = c[T0 - 1];
    let x2 = c[T0];
    let x3 = c[T0 + 1];
    let a = (x1 + x3 - 2 * x2) / 2;
    let b = (x3 - x1) / 2;
    if(a) T0 = T0 - b / (2 * a);

    return sampleRate / T0;
}

var noteStrings = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];

const noteFromPitch = (frequency) => {
    let noteNum = 12 * (Math.log(frequency / 440) / Math.log(2));
    return Math.round(noteNum) + 69;
}

function frequencyFromNoteNumber( note ) {
	return 440 * Math.pow(2,(note-69)/12);
}

function centsOffFromPitch( frequency, note ) {
	return Math.floor( 1200 * Math.log( frequency / frequencyFromNoteNumber( note ))/Math.log(2) );
}

const loop = (audioContext, analyser) => {
    const buffer = new Float32Array(bufferLength);

    const internal_loop = () => {
        analyser.getFloatTimeDomainData(buffer);
        let ac = autoCorrelate(buffer, audioContext.sampleRate);

        if(ac != -1) {
            let pitch = ac;
            let note = noteFromPitch(pitch);
            let detune = centsOffFromPitch(pitch, note);

            let noteName = noteStrings[note % 12];
            updateNote({
                pitch: pitch,
                note: noteName,
                detune: detune,
                buffer: buffer,
            });
        }else{
            updateNote({
                pitch: 0,
                note: "-",
                detune: 0,
                buffer: buffer,
            });
        }

        requestAnimationFrame(internal_loop);
    }

    requestAnimationFrame(internal_loop);
}

</script>