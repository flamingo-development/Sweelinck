
<script>
import Bar from '../components/bar.svelte';
import Button from '../components/button.svelte';
import Information from '../components/information.svelte';
import Notes from '../components/notes.svelte';
  import Teacher from '../components/teacher.svelte';
import ThemePicker from '../components/theme_picker.svelte';
import Visualizer from '../components/visualizer.svelte';

const start = () => {
    started = true;
}

let started = false;

</script>

{#if started}
    <Notes />
    <Teacher />
{/if}
<main>
    <div id="controls">
        {#if !started}
            <Button on:click={start}>
                Start
            </Button>
        {/if}
        <Information />
    </div>
    <div id="visuals">
        <Visualizer />
        <Bar />
    </div>
    <ThemePicker />
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