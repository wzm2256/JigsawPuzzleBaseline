# DiffAssemble: A Unified Graph-Diffusion Model for 2D and 3D Reassembly

This repository is a fork of the original implementation of the paper [DiffAssemble: A Unified Graph-Diffusion Model for 2D and 3D Reassembly](https://github.com/IIT-PAVIS/DiffAssemble). 

I fix a bug and provide a checkpoint and some training details.



### Environment

The newer version of pytorch-lightning is not supported.
```cmd
pip install pytorch-lightning==1.6.5.post0 kornia timm transformers
```


### Bug fixing and cleaning

I did some cleaning and fixed some bugs to run the code. The principle is to make minimal changes to the code while making it runable and easier to read.

1. The `Adafactor` optimizer causes error as reported in the [issue](https://github.com/IIT-PAVIS/DiffAssemble/issues/1). So I use `Adagrad`, which was commented out in the original code. 

3. Remove useless code for readability. I commented out a huge amount of code like the `Puzzle_Dataset_MP`, `Puzzle_Dataset`, `Puzzle_Dataset_ROT` classes, which are only different by a few lines, and are not used anywhere in the main experiments.
4. Training script. I only focus on the general task where rotation and piece missing are allowed. As for the WikiArt dataset, there are two versions of training script in folders `singularity/gianscarpe` and `singularity/francesco`, which are only slightly different. I follow `singularity/gianscarpe/train_wikiart_rot.sh` where I remove the `grad_acc` is ignored because it does not exist in the training script. The default parameters are changed according to those parameters.

### Training, checkpoint and results
I train the model on 6x6 puzzles of WikiArt (each piece is rotated and translated, missing 0% pieces) for 600 epochs. 

The loss and accuracy are shown below. The training takes 3 days on 1 Nvidia A100 GPU.



| Accuracy | Loss |
| --- | --- |
|<img src="result\acc.png" width="256"/> | <img src="result\loss.png" width="256"/> |


The training log and the checkpoint file can be downloaded from https://drive.google.com/file/d/1tWTfMOr42DXD4ibQ-BaJBxmh2SS1HNwX/view?usp=sharing


Generally speaking, most of the results are bad, the accuracy (the percentage of pieces that are correctly placed) is about 2%, which is significantly different from the result reported in Tab. 3 in the paper (90.65%), and there is no qualitative results in the paper.

The script for keep training and evaluation is in `a.txt`.




A result is shown below. Note that the method uses a matching algorithm to place each piece in the correct discrete grid. This is not mentioned in the paper. All 17116 test results can be downloaded from https://drive.google.com/file/d/1QIVtY3rr8NpIu4yc9OEMDchUFCV2mcb3/view?usp=sharing. 


| GT | After matching | Before matching|
| --- | --- | --- | 
| <img src="result\600-0_gt.png" width="256"/> | <img src="result\600-0_calibrate.png" width="256"/> |<img src="result\600-0_raw.png" width="256"/> | 



### Summary

If you are seeking a powerful tool to assemble your puzzle, then this algorithm is not what you are looking for.
