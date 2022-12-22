
<script context="module">
const callbacks = {};

const addCallback = (event, callback) => {
    if (!callbacks[event]) {
        callbacks[event] = [];
    }
    callbacks[event].push(callback);
}

const removeCallback = (event, callback) => {
    if (!callbacks[event]) {
        return;
    }

    const index = callbacks[event].indexOf(callback);
    if (index > -1) {
        callbacks[event].splice(index, 1);
    }
}

export const dispatch = (event, data) => {
    if (!callbacks[event]) {
        return;
    }
    callbacks[event].forEach(callback => {
        callback(data);
    });
}

</script>

<script>
    import { current_component, onDestroy, onMount } from "svelte/internal";

    const callbacks = current_component.$$.callbacks;

    onMount(() => {
        if(!callbacks) return
        const keys = Object.keys(callbacks);
        keys.forEach(key => {
            addCallback(key, callbacks[key].pop());
        });
    })

    onDestroy(() => {
        if(!callbacks) return
        const keys = Object.keys(callbacks);
        keys.forEach(key => {
            removeCallback(key, callbacks[key].pop());
        });
    })
</script>

<slot />
