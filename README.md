# Ordered Dithering
Command line utility to create 1-bit images featuring five different forms of ordered dithering: `Bayer`, `Forced Field`, `Magic Square`, `Shidoku`, and `Void-and-Cluster`.

To compile: ` gcc -w -framework Foundation -framework AppKit -framework QuartzCore ordered_dither.m -o ordered_dither`

To run: `./ordered_dither --dither <dither name> --size <matrix size> <original_image_file>`

Example: `./ordered_dither --dither void --size 32 Beartooth_pass.jpg`

**Original color photo of Geneva Lake, Colorado**  
Original photo by Todd Caudle &copy; [Skyline Press](https://www.skylinepress.com/product/colorado-wall-calendar/).  
![Photo of Geneva Lake by Todd Caudle](Geneva_Lake.png)

## Bayer

The granddaddy of ordered dithering matrices, based on the paper [An optimum method for two-level rendition of continuous-tone pictures](https://web.archive.org/web/20130512190753/http://white.stanford.edu/~brian/psy221/reader/Bayer.1973.pdf) (1973) by Bryce Bayer.  When one thinks of ordered dithering, this is the typical algorithm which creates a distinctive crosshatch pattern.

**2x2**  
![Geneva Lake with a 2x2 Bayer dither](Geneva_Lake_bayer_dithered_2x2.png)

**3x3**  
![Geneva Lake with a 3x3 Bayer dither](Geneva_Lake_bayer_dithered_3x3.png)

**4x4**  
![Geneva Lake with a 4x4 Bayer dither](Geneva_Lake_bayer_dithered_4x4.png)

**8x8**  
![Geneva Lake with a 8x8 Bayer dither](Geneva_Lake_bayer_dithered_8x8.png)

**16x16**  
![Geneva Lake with a 16x16 Bayer dither](Geneva_Lake_bayer_dithered_16x16.png)

**32x32**  
![Geneva Lake with a 32x32 Bayer dither](Geneva_Lake_bayer_dithered_32x32.png)


## Forced Field (Forced Random Dithering)

Based on the paper [Forced Random Dithering: Improved Threshold Matrices For Ordered Dithering](https://www.academia.edu/17104333/Forced_random_dithering_improved_threshold_matrices_for_ordered_dithering) and Chapter  VI.1 from <u>Graphics Gems V</u> by Werner Purgathofer, Robert F. Tobler, Manfred Geiler.

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

A portmanteau of "shi" (the Japanese word for "four") and "sudoku", which creates a 4x4 matrix where each row and column contains the numbers 1 through 4.

**4x4**  
![Geneva Lake with a 4x4 Shidoku dither](Geneva_Lake_shidoku_dithered_4x4.png)

## Void-and-Cluster

Method based on Robert Ulichney's paper [The void-and-cluster method for dither array generation](http://cv.ulichney.com/papers/1993-void-cluster.pdf) (1993).

**8x8**  
![Geneva Lake with a 8x8 Void-and-Cluster dither](Geneva_Lake_void_dithered_8x8.png)

**16x16**  
![Geneva Lake with a 16x16 Void-and-Cluster dither](Geneva_Lake_void_dithered_16x16.png)

**32x32**  
![Geneva Lake with a 32x32 Void-and-Cluster dither](Geneva_Lake_void_dithered_32x32.png)

**64x64**  
![Geneva Lake with a 64x64 Void-and-Cluster dither](Geneva_Lake_void_dithered_64x64.png)