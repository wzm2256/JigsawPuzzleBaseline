# Jigsaw puzzles with pieces of unknown orientation

This repository is a fork of the original implementation of the paper **Jigsaw puzzles with pieces of unknown orientation**

I add the evaluation and batch processing code.

### Run the code
The main function is `puzzle` defined in `puzzle.m`. This function will cut a given image into patches, and then assemble will be reassembled using the algorithm.
``
puzzle(imlist, output_folder, PP, nc, nr)
``
where
1. imlist: image path
2. output_folder: the folder to place output
3. PP: patch size
4. nc: number of columns
5. nr: number of rows.

I also provide script `run_batch.m` to process all images in a folder and its sub folders.
