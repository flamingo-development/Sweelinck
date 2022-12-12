
<div on:click on:keydown, on:keyup on:keypress>
    <slot />
</div>

<style>

    div {
        display: inline-flex;
        margin: 3px 5px;
        padding: 8px 15px;
        border-radius: 10px;
        cursor: pointer;
        background-color: var(--b_med);
    }

    div:hover {
        background-color: var(--b_inv);
        color: var(--b_low);
    }

</style>