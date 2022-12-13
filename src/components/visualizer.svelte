
<script>
import { onMount } from 'svelte';

const bufferMinimizeFactor = 32;
const frequencyMultiplier = 2
$: buffer = [];

export const updateBuffer = (_buffer) => {
    minimizeBuffer(_buffer);
}

export const width = ((2048 / bufferMinimizeFactor) * 5) + 20;
export const height = 200;

const getX = (i) => {
    return (i * width / buffer.length) + 5;
}

const getY = (line) => {
    return height / 2 - (line * frequencyMultiplier) * height / 2;
}

onMount(() => {
    minimizeBuffer(new Array(2048).fill(0));
})

const minimizeBuffer = (_buffer) => {
    buffer = _buffer.filter((_, i) => {
        return i % bufferMinimizeFactor === 0;
    })
}

</script>

<svg 
viewBox={`0 0 300 200`}
xmlns="http://www.w3.org/2000/svg"
>
    {#each buffer as line, i}
        <path 
            d={`M ${getX(i)} ${height / 2} L ${getX(i)} ${getY(line)}`}
            class="f_med"
            stroke-linecap="round"
        />
    {/each}
</svg>

<style>
svg {
    width: 80%;
}

@media (max-width: 768px) {
    svg {
        width: 100%;
    }
}

path {
    stroke-width: 5px;
}
</style>