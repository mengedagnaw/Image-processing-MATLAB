
# Image Assets (Ooid Ironstone Analysis)

This folder contains image assets used by the **Ooid Iron in Ironstone** MATLAB workflow.

## What’s inside?

### 1) Embedded images extracted from the PDF
Files named like:

- `embedded_p01_01.jpeg`
- `embedded_p02_01.jpeg`
- `embedded_p04_01.png`
- ...

These are **figures/images extracted from the lab handout PDF** (e.g., screenshots of steps, example outputs, and reference visuals).  
They are included here to make the repository self-contained and reproducible.

### 2) (Optional) Raw microscope image(s)
If you add raw images for analysis, keep them here too (recommended naming):

- `min4.png` (example microscope image)
- `ironstone_sample_01.png` (your own naming)

## How these images are used in MATLAB

Scripts in `../scripts/` should load images using a **relative path** (recommended), for example:

```matlab
scriptDir = fileparts(mfilename('fullpath'));
imgPath = fullfile(scriptDir, "..", "images", "min4.png");
imgPath = string(imgPath);
I = imread(imgPath);
