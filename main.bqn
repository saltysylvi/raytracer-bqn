ppm ← •Import "ppm.bqn"

Hit_Sphere ← {center‿radius‿ray:
    origin‿direction ← ray
    oc ← center - origin
    a ← +´×˜direction
    h ← direction+´∘×oc
    c ← (+´×˜oc) - ×˜radius
    discriminant ← (h⋆2)-a×c
    {discriminant < 0 ? ¯1 ; (h-√discriminant)÷a}
}

Ray_Color ← {origin‿direction:
    t ← Hit_Sphere⟨0‿0‿¯1, 0.5, origin‿direction⟩
    {
        t>0 ?
        n ← ÷⟜(+´⌾(×˜))(origin+t×direction)-0‿0‿¯1
        0.5×1‿1‿1+n
        ;
        unit_direction ← ÷⟜(+´⌾(×˜)) direction
        a ← 0.5×1+1⊑unit_direction
        ((1-a)×1‿1‿1)+a×0.5‿0.7‿1
    }
}

# Image
aspect_ratio ← 16 ÷ 9
image_width ← 400
image_height ← 1 ⌈ image_width ⌊∘÷ aspect_ratio

# Camera
focal_length ← 1.0
viewport_height ← 2.0
viewport_width ← viewport_height × image_width ÷ image_height
camera_center ← 0‿0‿0

viewport_u ← ⟨viewport_width, 0, 0⟩
viewport_v ← ⟨0, -viewport_height, 0⟩

pixel_delta_u ← viewport_u ÷ image_width
pixel_delta_v ← viewport_v ÷ image_height

viewport_upper_left ← camera_center - 0‿0‿focal_length + (viewport_u÷2) + viewport_v÷2
pixel00_loc ← viewport_upper_left + 0.5 × pixel_delta_u + pixel_delta_v

# Render
img ← {i‿j:
    pixel_center ← pixel00_loc + (i×pixel_delta_u) + j×pixel_delta_v
    ray_direction ← pixel_center - camera_center
    r ← ⟨camera_center, ray_direction⟩
    Ray_Color r
}¨⍉↕image_width‿image_height

•Out PPM img
