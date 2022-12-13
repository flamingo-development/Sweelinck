
<script>
import { onMount } from "svelte";

let note;

export const updateNoteBar = (_note) => {
    note = _note;
}

onMount(() => {
    window.TestFrequency = (hz) => {
        note = {
            pitch: hz,
            note: `${hz} Hz`,
        }
    }
})

const heightOffset = 40
const heights = [
    60,
    80,
    100,
    120,
    140,
]

//Based on 440 hz: https://pages.mtu.edu/~suits/notefreqs.html
const pitches = {
    246.94: 200, // B3
    261.63: 190, // C4
    277.18: 180, // C#4
    293.66: 170, // D4
    311.13: 160, // D#4
    329.63: 150, // E4
    349.23: 140, // F4
    369.99: 130, // F#4
    392: 120, // G4
    415.30: 110, // G#4
    440: 100, // A4
    466.16: 90, // A#4
    493.88: 80, // B4
    523.25: 70, // C5
    554.37: 60, // C#5
    587.33: 50, // D5
    622.25: 40, // D#5
    659.25: 30, // E5
    698.46: 20, // F5
    739.99: 10, // F#5
    783.99: 0, // G5
    830.61: -10, // G#5
    880: -20, // A5
    932.33: -30, // A#5
    987.77: -40, // B5
    1046.50: -50, // C6
    1108.73: -60, // C#6
    1174.66: -70, // D6
    1244.51: -80, // D#6
    1318.51: -90, // E6
}

const closestPitchHeight = (pitch) => {
    const pitchesArray = Object.keys(pitches).map((key) => {
        return parseFloat(key);
    });

    const closestPitch = pitchesArray.reduce((prev, curr) => {
        return (Math.abs(curr - pitch) < Math.abs(prev - pitch) ? curr : prev);
    });

    return pitches[closestPitch];
}

const getNoteHeight = (note) => {
    if (!note || note.note == "-") {
        return -(1000 + heightOffset);
    }

    const pitch = note.pitch;
    const height = closestPitchHeight(pitch);

    return height;
}

const helperBars = (note) => {
    if (!note || note.note == "-") {
        return [];
    }

    //create new bar heights each at a multiple of 20 until it reaches the note height starting from 100 going up or down
    const noteHeight = getNoteHeight(note);
    const barHeights = [];

    const lowest = heights.reduce((prev, curr) => {
        return (curr < prev ? curr : prev);
    });

    const highest = heights.reduce((prev, curr) => {
        return (curr > prev ? curr : prev);
    });

    if(noteHeight < lowest) {
        const bars = Math.floor((lowest - noteHeight) / 20);
        for(let i = 0; i < bars; i++) {
            barHeights.push(lowest - (20*(i+1)))
        }
    }else if(noteHeight > highest) {
        const bars = Math.floor((noteHeight - highest) / 20);
        for(let i = 0; i < bars; i++) {
            barHeights.push(highest + (20*(i+1)))
        }
    }

    return barHeights
}

</script>


<svg id="bar" viewBox="0 0 180 300" xmlns="http://www.w3.org/2000/svg">
    <use 
        href="/symbols.svg#g_clef" 
        x="0"
        y={4 + heightOffset}
        transform="scale(1.8)"
        class="b_inv"
        fill="none"
    />
    {#each heights as height}
        <line 
            x1="70" 
            y1="{height + heightOffset}" 
            x2="165" 
            y2="{height + heightOffset}" 
            class="f_low" 
            stroke-linecap="round"
        />
    {/each}
    {#each helperBars(note) as height}
    <line 
        x1="105" 
        y1="{height + heightOffset}" 
        x2="135" 
        y2="{height + heightOffset}" 
        class="f_low" 
        stroke-linecap="round"
    />
    {/each}
    <use
        href="/symbols.svg#quarter_note"
        x="70"
        y="0"
        transform="scale(1.2)"
        transform-origin="0px 240px"
        style={`translate: ${(getNoteHeight(note) < 100 ? 100 : 25)}px ${getNoteHeight(note) + (heightOffset) + 5}px`}
        class={`b_inv ${getNoteHeight(note) < 100 ? 'upper' : ''}`}
    />
</svg>

<style>
svg {
    width: 20%;
}

@media (max-width: 768px) {
    svg {
        width: 50%;
    }
}

line {
    stroke-width: 3px;
}

.upper {
    transform-origin: 49px 15px;
    transform: rotate(180deg);
}
</style>