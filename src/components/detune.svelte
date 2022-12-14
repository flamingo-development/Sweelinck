
<script>

const detune_avg_count = 10;
let detune = [];
let detune_avg = 0;

export const updateDetune = (_detune) => {
    detune.push(_detune);
    if(detune.length > detune_avg_count) {
        detune.shift();
    }
    detune_avg = detune.reduce((a, b) => a + b, 0) / detune.length;
    console.log(detune_avg);
}

const width = 100;
const height = 14;
const strokeWidth = 2;
$: radius = (height - strokeWidth)/2;
$: sm_radius = (height - (strokeWidth*3))/2;

const map = (value, in_min, in_max, out_min, out_max) => {
    return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

const getDetune = (x) => {
    return map(x, -30, 30, radius, width - radius);
}

</script>

<svg
    width={width}
    height={height}
>

<g>
    <line 
        x1={1} 
        y1={0} 
        x2={1}
        y2={height}
        class="f_low"
        stroke-width={2}
    />
    <circle 
        cx={width/2}
        cy={height/2}
        r={radius}
        fill="none"
        class="f_low"
        stroke-width={strokeWidth}
    />
    <line 
        x1={width-1} 
        y1={0} 
        x2={width-1}
        y2={height}
        class="f_low"
        stroke-width={strokeWidth}
    />
    <circle 
        cx={getDetune(detune_avg)}
        cy={height/2}
        r={sm_radius}
        class="b_inv"
        stroke-width={strokeWidth}
    />
</g>

</svg>