shader_type canvas_item;

// Dither pattern scale
uniform float dither_scale : hint_range(1, 20) = 4.0;
// How wide the dither border should be (in pixels)
uniform float border_width : hint_range(1, 16) = 4.0;
// How strong the dither effect should be
uniform float effect_strength : hint_range(0, 1) = 0.5;

// Bayer matrix for ordered dithering
float bayer2(vec2 coord) {
    coord = floor(coord);
    return fract(dot(coord, vec2(0.5, coord.y * 0.75)));
}

void fragment() {
    vec4 base_color = texture(TEXTURE, UV);
    COLOR = base_color;
    vec2 pixel_size = 1.0 / TEXTURE_PIXEL_SIZE;
    vec2 pixel_pos = UV * TEXTURE_PIXEL_SIZE;

    // Detect if we're near a tile edge
    vec2 tile_uv = fract(pixel_pos);
    vec2 edge_dist = min(tile_uv, 1.0 - tile_uv) * pixel_size;
    float is_border = 1.0 - smoothstep(0.0, border_width, min(edge_dist.x, edge_dist.y));

    if (is_border > 0.0) {
        // Sample adjacent tiles
        vec4 right_color = texture(TEXTURE, UV + vec2(pixel_size.x, 0.0));
        vec4 left_color = texture(TEXTURE, UV + vec2(-pixel_size.x, 0.0));
        vec4 top_color = texture(TEXTURE, UV + vec2(0.0, -pixel_size.y));
        vec4 bottom_color = texture(TEXTURE, UV + vec2(0.0, pixel_size.y));

        // Find the most different neighbor (for strongest contrast)
        vec4 neighbor_color = base_color;
        float max_diff = 0.0;

        if (right_color.a > 0.0) {
            float diff = distance(base_color.rgb, right_color.rgb);
            if (diff > max_diff) {
                max_diff = diff;
                neighbor_color = right_color;
            }
        }
        if (left_color.a > 0.0) {
            float diff = distance(base_color.rgb, left_color.rgb);
            if (diff > max_diff) {
                max_diff = diff;
                neighbor_color = left_color;
            }
        }
        if (top_color.a > 0.0) {
            float diff = distance(base_color.rgb, top_color.rgb);
            if (diff > max_diff) {
                max_diff = diff;
                neighbor_color = top_color;
            }
        }
        if (bottom_color.a > 0.0) {
            float diff = distance(base_color.rgb, bottom_color.rgb);
            if (diff > max_diff) {
                neighbor_color = bottom_color;
            }
        }

        if (max_diff > 0.01) {
            // Apply dither pattern at borders
            float dither = bayer2(FRAGCOORD.xy / dither_scale);
            float border_factor = is_border * effect_strength;
            float mix_amount = step(dither, border_factor);
            COLOR = mix(base_color, neighbor_color, mix_amount);
        }
    }
}