Please set the current folder to XXX/HW1_105062527 and run the script HW1.m.
 
HW1.m: 
The main function.
It is a script that contain Part1.A to Part1.F and Part2.A to Part2F segments.
And when each segment is complete, it will print a message: 'Part n. X. is finished'.

dirPiOne.m:
Scales angle of direction image from -pi:pi to 0:1.
Called by Part1.B.

SobelMask.m:
Use sobel mask to approximate the gradient of given image.
Called by Part1.B., Part1.E

sCorner.m:
Constructs the image with elements of the smaller eigenvalue of Harris matrix.
Can decide the window size of corner detection
Called by Part1.C., Part1.E.

nonMaxSup.m:
Implement non-maximun suppression, which can decide the cover region(odd square).
Called by Part1.D., Part1.E.

plotCorner.m:
Remain the complete origin color or only the red part of the image,
and plot corner pints with given RGB color.
Called by Part1.D., Part1.E., Part1.F

lbp.m:
Constructs LBP image.
Called by Part2.A.

myHist.m:
Constructs normalized LBP histogram vector according to cells number.
Called by Part2.B., Part2.C., Part2.E., Part2.F.

ulbp.m:
Constructs uniform LBP image.
Called by Part2.D.