
<script>
import Detune from "./detune.svelte";
import Event from "../events/event.svelte"

let note;

</script>

<Event on:note={(e) => note = e} />

<div>
    {#if note}
        <table>
            <tr>
                <td>Note</td>
                <td id="note">
                    <span>{note.note}</span>
                    <span>{note.octave}</span>
                </td>
            </tr>
            <tr>
                <td>Pitch</td>
                <td id="hz">{note.pitch.toFixed(2)} Hz</td>
            </tr>
            <tr>
                <td>Detune</td>
                <td>
                    <Detune />
                </td>
            </tr>
        </table>
    {/if}
</div>

<style>
#note {
    display: flex;
    justify-content: space-between;
}

#hz {
    text-align: right;
}
</style>