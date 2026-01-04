# Image Assets (Fracture Detection)

This folder contains image assets used by the **Fracture Detection in Rock Samples** MATLAB workflow.

## What’s inside?

### 1) Extracted figures/images from the lab PDF
Files such as:
- `embedded_p01_01.png`
- `embedded_p02_01.jpg`
- ...

These were extracted from the *Lab 1a Fracture detection* PDF to keep the repository self-contained and reproducible.

### 2) Raw crack images used for testing
Recommended naming examples:
- `crack3.png`
- `no_crack.png`
- `rock_sample_01.png`

## How to load images in MATLAB (recommended: relative paths)

If your script is in `../scripts/`, use:

```matlab
scriptDir = fileparts(mfilename('fullpath'));
imgPath = fullfile(scriptDir, "..", "images", "crack3.png");
imgPath = string(imgPath);
I = imread(imgPath);
