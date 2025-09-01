# Jigsaw puzzle baselines

This repository collects several methods for solving jigsaw puzzles, making them easier to run by adding evaluation code and fixing bugs.





### Methods

More details can be found in each folder.
#### 1. Square pieces
1. MGC: `Square/PuzzleDemoMGC`
2. GCL:  `Square/PuzzleDemoGCL`
3. DiffAssemble: `Square/DiffAssemble`




#### 2. Arbitrary pieces
Working in progress!




### Evaluation

#### 1. Square piece
For square-piece problem, the evaluation metric is the ratio of pieces that are correctly placed. I use a rotation invariant version of this metric: each image has four GT solutions, which are 0/90/180/270-degree rotations of the original image. A result is compared to these four GTs, and the highest accuracy is taken as the result.

Here is the result for 6x6 pieces puzzles of the WikiArt datasets. Note that for MGC and GCL, errors sometimes occur for some samples, then the accuracy of those samples are recorded as 0.

| Method | acc |
| --- | --- |
|MGC | 0.63 |
|GCL | 0.89 |
|DA | 0.01 |






### Citation

DiffAssemble:
```
@InProceedings{scarpellini2024diffassemble,
    author    = {Gianluca Scarpellini and Stefano Fiorini and Francesco Giuliari and Pietro Morerio and Alessio {Del Bue}},
    title     = {DiffAssemble: A Unified Graph-Diffusion Model for 2D and 3D Reassembly},
    booktitle = {Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition (CVPR)},
    month     = {June},
    year      = {2024},
}
```

GCL:
```
@article{huroyan2020solving,
  title={Solving jigsaw puzzles by the graph connection laplacian},
  author={Huroyan, Vahan and Lerman, Gilad and Wu, Hau-Tieng},
  journal={SIAM Journal on Imaging Sciences},
  volume={13},
  number={4},
  pages={1717--1753},
  year={2020},
  publisher={SIAM}
}
```


MGC:
```
@inproceedings{gallagher2012jigsaw,
  title={Jigsaw puzzles with pieces of unknown orientation},
  author={Gallagher, Andrew C},
  booktitle={2012 IEEE Conference on computer vision and pattern recognition},
  pages={382--389},
  year={2012},
  organization={IEEE}
}
```
