
<script>

let note;

export const updateNoteInfo = (_note) => {
    note = _note;
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
                <td>{note.detune}</td>
            </tr>
        </table>
    {/if}
</div>