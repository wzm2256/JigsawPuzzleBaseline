# Solving Jigsaw Puzzles By the Graph Connection Laplacian

This repository is a fork of the original implementation of the paper [Solving Jigsaw Puzzles By the Graph Connection Laplacian](https://github.com/vahanhuroyan/PuzzleDemoGCL)

I add the evaluation and batch processing code.

### Run the code
The main function is `puzzle_GCL_test_function.m` defined in `puzzle_GCL_test_function.m`. This function will cut a given image into patches, and then assemble will be reassembled using the algorithm.
``
puzzle_GCL_test_function(img_path, output_folder, patch_size, cols, rows)
``
where
1. img_path: image path
2. output_folder: the folder to place output
3. patch_size: patch size
4. cols: number of columns
5. rows: number of rows.

I also provide script `run_batch.m` to process all images in a folder and its sub folders.
