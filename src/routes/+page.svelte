
<script>
import Bar from '../components/bar.svelte';
import Button from '../components/button.svelte';
  import Information from '../components/information.svelte';
import Notes from '../components/notes.svelte';
import Visualizer from '../components/visualizer.svelte';

let startNoteDetection;
let updateBuffer;
let updateNoteBar;
let updateNoteInfo;

const updateNote = (_note) => {
    updateBuffer(_note.buffer);
    updateNoteBar(_note);
    updateNoteInfo(_note);
}

const start = () => {
    startNoteDetection();
    started = true;
}

let started = false;

</script>

<Notes bind:start={startNoteDetection} updateNote={updateNote} />
<main>
    <div id="controls">
        {#if !started}
            <Button on:click={start}>
                Start
            </Button>
        {/if}
        <Information bind:updateNoteInfo={updateNoteInfo} />
    </div>
    <div id="visuals">
        <Visualizer 
            bind:updateBuffer={updateBuffer} 
        />
        <Bar bind:updateNoteBar={updateNoteBar} />
    </div>
</main>

<style>
main {
    width: 100%;
    height: 100%;
}

#controls {
    width: 50%;
    margin: auto;
}

#visuals {
    display: flex;
    width: 50%;
    margin: auto;
    justify-content: center;
    align-items: center;
}

@media (max-width: 768px) {
    #controls {
        width: 100%;
    }

    #visuals{
        width: 100%;
        display: block;
        text-align: center;
    }
}

</style>