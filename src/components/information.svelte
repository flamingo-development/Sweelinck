
<script>
  import Detune from "./detune.svelte";


let updateDetune;
let note;

export const updateNoteInfo = (_note) => {
    note = _note;
    if(updateDetune)
        updateDetune(note.detune);
}

let isOpen = false;

</script>

<div>
    {#if note}
        <table>
            <tr>
                <td>Note</td>
                <td>{note.note} {note.octave}</td>
            </tr>
            <tr>
                <td>Pitch</td>
                <td>{note.pitch.toFixed(2)} Hz</td>
            </tr>
            <tr>
                <td>Detune</td>
                <td>
                    <Detune 
                        bind:updateDetune={updateDetune}
                    />
                </td>
            </tr>
        </table>
    {/if}
</div>