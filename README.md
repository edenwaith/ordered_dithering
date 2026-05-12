# Ordered Dithering
Command line utility to create 1-bit images with various forms of ordered dithering.

**Original Photo of Geneva Lake, Colorado**  
Original photo by Todd Caudle &copy; [Skyline Press](https://www.skylinepress.com/product/colorado-wall-calendar/).  
![Photo of Geneva Lake by Todd Caudle](Geneva_Lake.png)

## Bayer

The granddaddy of ordered dithering matrices.

**2x2**  
![Geneva Lake with a 2x2 Bayer dither](Geneva_Lake_bayer_dithered_2x2.png)

**4x4**  
![Geneva Lake with a 4x4 Bayer dither](Geneva_Lake_bayer_dithered_4x4.png)

**16x16**  
![Geneva Lake with a 16x16 Bayer dither](Geneva_Lake_bayer_dithered_16x16.png)

**32x32**  
![Geneva Lake with a 32x32 Bayer dither](Geneva_Lake_bayer_dithered_32x32.png)


## Forced Field (Forced Random Dithering)

Based on the paper [Forced Random Dithering: Improved Threshold Matrices For Ordered Dithering](https://www.academia.edu/17104333/Forced_random_dithering_improved_threshold_matrices_for_ordered_dithering) by Werner Purgathofer, Robert F. Tobler, Manfred Geiler.

**8x8**  
![Geneva Lake with a 8x8 Forced Field dither](Geneva_Lake_force_dithered_8x8.png)

**16x16**  
![Geneva Lake with a 16x16 Forced Field dither](Geneva_Lake_force_dithered_16x16.png)

## Magic Square

A [magic square](https://www.dcode.fr/magic-square) is a matrix where each row and column adds up to the same number.

**3x3**  
![Geneva Lake with a 3x3 Magic Square dither](Geneva_Lake_magic_square_dithered_3x3.png)

**4x4**  
![Geneva Lake with a 4x4 Magic Square dither](Geneva_Lake_magic_square_dithered_4x4.png)

**5x5**  
![Geneva Lake with a 5x5 Magic Square dither](Geneva_Lake_magic_square_dithered_5x5.png)


## Shidoku

**4x4**  
![Geneva Lake with a 4x4 Shidoku dither](Geneva_Lake_shidoku_dithered_4x4.png)

## Void-and-Cluster

Method based on Robert Ulichney's paper [The void-and-cluster method for dither array generation](http://cv.ulichney.com/papers/1993-void-cluster.pdf) (1993).

**16x16**  
![Geneva Lake with a 16x16 Void-and-Cluster dither](Geneva_Lake_void_dithered_16x16.png)

**32x32**  
![Geneva Lake with a 32x32 Void-and-Cluster dither](Geneva_Lake_void_dithered_32x32.png)

**64x64**  
![Geneva Lake with a 64x64 Void-and-Cluster dither](Geneva_Lake_void_dithered_64x64.png)