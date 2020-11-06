# MyMatlabScriptCollection

A personal collection of matlab scripts.

## Personal focus

- Image Processing (low-level preprocessing)
- Principal Component Analysis (PCA)
- Pattern Recognition, in an ad-hoc way, non-methodically, as I please.

## Directory and file organization

In order to minimize difficulty in cross platform and source control systems, 
all MATLAB package folders have their plus-prefix stripped while under source control.

## Post-download preparations before first-time use

To make MATLAB recognize these folders as package folders, it is recommended to 
create NTFS directory junctions that point into the source controlled folder.

To add the entire collection to the MATLAB search path (for the current user) 
at startup, create or edit the "startup.m" script, and add the following line:

```matlab
addpath(fullfile(userpath, 'MyMatlabScriptCollection'), '-end');
```

---

## Packages

#### Package: Ordinal Downsample

#### Package: PCA Sharpening

