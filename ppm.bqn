# list of numbers to space separated string
Str ← {¯1↓∾ ∾⟜' '∘•Repr¨ 𝕩}

# Convert array to PPM formatted string
# input: rank 2 array of 3 element rgb list
# each element is in [0,1]
PPM ← {
    output ← ⋈"P3"
    output ∾↩ ⋈Str ⌽≢𝕩
    output ∾↩ ⋈"255"
    {output∾↩⋈Str 𝕩⋄@}¨⌊255.999×𝕩
    ¯1↓∾∾⟜(@+10)¨ output
}