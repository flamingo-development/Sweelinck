
<script>
import Bar from '../components/bar.svelte';
import Button from '../components/button.svelte';
import Notes from '../components/notes.svelte';
import Visualizer from '../components/visualizer.svelte';

let startNoteDetection;
let updateBuffer;
let updateNoteBar;

const updateNote = (note) => {
    updateBuffer(note.buffer);
    updateNoteBar(note);
}

</script>

<Notes bind:start={startNoteDetection} updateNote={updateNote} />

<Button on:click={startNoteDetection}>
    Start
</Button>


<main>
    <div>
        <Visualizer 
            bind:updateBuffer={updateBuffer} 
        />
        <Bar bind:updateNoteBar={updateNoteBar} />
    </div>
</main>

<style>
    main {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    div {
        display: flex;
        width: 80%;
    }
</style>