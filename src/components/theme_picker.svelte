
<script>
import { onMount } from "svelte";

const themes = Object.keys(import.meta.glob('../../static/themes/*.svg'))
const prefix = (path) => path.replace('../../static/', '')
const text = (path) => path.replace('../../static/themes/', '').replace('.svg', '')

let current_theme = 'default'
const key = 'current_theme'

onMount(() => {
    current_theme = localStorage.getItem(key)
})

const installTheme = (e) => {
    current_theme = e.target.value
    if(!current_theme) return

    const file = prefix(current_theme)
    console.log(`Loading theme: ${file}`)

    if(current_theme === 'default') {
        localStorage.setItem(key, 'default')
        window.theme.load(window.theme.default)
        return
    }

    fetch(file).then(async (resp) => {
        const body = await resp.text()

        if(!!window.theme.parse(body)) {
            localStorage.setItem(key, current_theme)

            window.theme.load(body)
        }
    })
}

</script>

<select name="" id="" on:change={installTheme} bind:value={current_theme}>
    <option value="default">default</option>
    {#each themes as theme}
        <option value={theme}>{text(theme)}</option>
    {/each}
</select>

<style>
select {
    position: absolute;
    bottom: 5px;
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
}

select:hover {
    background-color: var(--b_inv);
    color: var(--b_low);
}
</style>