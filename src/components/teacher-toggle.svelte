
<script>
    import { dispatch } from '../events/event.svelte';
    
    function toggleTeacher(e) {
        const teacherEnabled = e.target.checked;
        dispatch('teacher_enabled', teacherEnabled)
    }

</script>
    
<input type="checkbox" name="" id="teacher_toggle" on:input={toggleTeacher}/>
<label for="teacher_toggle">
    Teacher Mode
</label>
    
<style>
    label {
        position: absolute;
        bottom: 45px;
        left: 5px;
        border: 0px;
        background-color: var(--b_med);
        color: var(--f_med);
        padding: 8px 12px;
        line-height: 1.1;
        border-radius: 10px;
        -moz-appearance: none; /* Firefox */
        -webkit-appearance: none; /* Safari and Chrome */
        appearance: none;
        user-select: none;
        outline: none;
        cursor: pointer;
        font-size: 0.9rem;
    }

    input[type="checkbox"] {
        display: none;
    }

    input[type="checkbox"]:checked + label {
        background-color: var(--b_inv);
        color: var(--b_low);
    }
    
    label:hover {
        background-color: var(--b_inv);
        color: var(--b_low);
    }
</style>