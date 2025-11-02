# Image Processing in MATLAB for Materials / Geoscience Applications

This repository contains two instructional MATLAB projects that demonstrate how **classical digital image processing** can be used to extract quantitative information from materials- and geology-related images.

The projects were developed for a course in **Digital Image Processing** and focus on real engineering tasks:
1. **Fracture Detection in Rocks using Digital Image Processing**
2. **Analysis of Ooid Iron in Ironstone**

Both projects show the full chain: image acquisition → preprocessing → feature extraction → visualization. They can be adapted to metallographic/SEM images from LPBF or corrosion studies.  
_Source: original course projects in this repository._ :contentReference[oaicite:2]{index=2}

---

## 1. Repository Contents

- `Fracture Detection in Rocks using Digital Image Processing/`  
  MATLAB scripts for:
  - converting to grayscale
  - noise reduction (filtering)
  - edge detection (Sobel/Canny)
  - morphological cleaning (dilation/erosion)
  - overlaying detected fractures on the original rock image

- `Analysis of Ooid Iron in Ironstone/`  
  MATLAB scripts for:
  - contrast enhancement
  - segmentation of ooids / iron-rich regions
  - labeling objects
  - measuring area / count / shape factors
  - exporting basic statistics

- `README.md`  
  (this file)

At the time of writing, the GitHub “About” section is empty; this README describes the actual scope. :contentReference[oaicite:3]{index=3}

---

## 2. Goals

- show **classical** (non–deep-learning) image processing in MATLAB,
- work with **realistic, non-perfect** material/rock images,
- produce **reproducible** analysis scripts students can modify,
- make it easy to plug in **your own SEM / metallography / LPBF micrographs**.

---

## 3. Requirements

- **MATLAB** (R2021a or newer recommended)
- **Image Processing Toolbox**
- sample images (provided in the project folders or replace with your own PNG/JPG/TIF)

No GPU is needed — these are classic image-processing pipelines.

---

## 4. How to Run

1. Clone the repo:
   ```bash
   git clone https://github.com/mengedagnaw/Image-processing-MATLAB.git
   cd Image-processing-MATLAB

