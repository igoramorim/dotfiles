// Based on https://www.shadertoy.com/view/WlByDy
// that is based on https://www.shadertoy.com/view/wdfGzH

#define PI 3.14159265359
#define ALPHA 0.05 // Greater = more visible
#define SPEED 0.05

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uvorig = fragCoord / iResolution.xy;

    vec2 uv = (fragCoord.xy-.5*iResolution.xy)/iResolution.y;
    vec3 c = vec3(0.);
    float t = iTime;
    t = t*SPEED;
    
    float r = length(uv);
    float a = atan(uv.x, uv.y);
    
    c.r = smoothstep(0., 1., sin((a+.1)*4.+r*3.-(t*10.)));
    c.g = smoothstep(0., 1., sin((a+.2)*4.+r*3.-(t*10.)));
    c.b = smoothstep(0., 1., sin((a+.3)*4.+r*3.-(t*10.)));
    
    // c.r = smoothstep(0., 1., sin((a+.3)*10.+r*sin(2.1*r+t*3.)*3.-(t*4.)));
    // c.b = smoothstep(0., 1., sin((a+.3)*10.+r*sin(2.1*r+t*3.)*3.-(t*4.)));
    // c.g = smoothstep(0., 1., sin((a+.3)*10.+r*sin(2.1*r+t*3.)*3.-(t*4.)));
    
    // c.r = smoothstep(0., 1., sin((a+.1)*5.+r*sin(10.*r+t*3.)*5.-(t*4.))+sin(a*2.));
    // c.g = smoothstep(0., 1., sin((a+.2)*5.+r*sin(10.*r+t*3.)*6.-(t*4.))+sin(a*2.));
    // c.b = smoothstep(0., 1., sin((a+.3)*5.+r*sin(10.*r+t*3.)*7.-(t*4.))+sin(a*2.));
    
    vec4 terminalColor = texture(iChannel0, uvorig);
    vec3 blendedColor = mix(terminalColor.rgb, c, ALPHA);

    fragColor = vec4(blendedColor, terminalColor.a);
}
