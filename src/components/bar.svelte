
<script>
import { onMount } from "svelte";
import Event from "../events/event.svelte"

let note;
let teacherNote;

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

const noteStrings = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];

const G4 = {
    note: "G",
    octave: 4,
    height: 120,
}

const G4_index = noteStrings.indexOf(G4.note) + (G4.octave * 12);
const NoteStart = G4.height + (G4_index * 10);

const getNoteHeight = (note) => {
    if (!note || note.note == "-") {
        return -(1000 + heightOffset);
    }

    const noteIndex = noteStrings.indexOf(note.note);
    const octave = note.octave;
    const height = NoteStart - ((noteIndex * 10) + (octave * 120));

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


<Event on:note={(e) => note = e} />
<Event on:teacher={(e) => teacherNote = e} />

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
    {#each [...helperBars(note), ...helperBars(teacherNote)] as height}
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

    <use
        href="/symbols.svg#quarter_note"
        x="70"
        y="0"
        transform="scale(1.2)"
        transform-origin="0px 240px"
        style={`translate: ${(getNoteHeight(teacherNote) < 100 ? 100 : 25)}px ${getNoteHeight(teacherNote) + (heightOffset) + 5}px`}
        class={`b_inv f_med ${getNoteHeight(teacherNote) < 100 ? 'upper' : ''}`}
    />
</svg>

<style>
svg {
    width: 20%;
    overflow: visible;
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