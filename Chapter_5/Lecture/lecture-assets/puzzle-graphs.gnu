#!/usr/bin/gnuplot
#
#    
#    	G N U P L O T
#    	Version 6.0 patchlevel 0    last modified 2023-12-09 
#    
#    	Copyright (C) 1986-1993, 1998, 2004, 2007-2023
#    	Thomas Williams, Colin Kelley and many others
#    
#    	gnuplot home:     http://www.gnuplot.info
#    	faq, bugs, etc:   type "help FAQ"
#    	immediate help:   type "help"  (plot window: hit 'h')
 set terminal pngcairo truecolor nocrop enhanced butt size 640,480 font "arial,14.0" 
unset clip points
set clip one
unset clip two
unset clip radial
set errorbars front 1.000000 
set border 31 front lt black linewidth 1.000 dashtype solid
set cornerpoles
set zdata 
set ydata 
set xdata 
set y2data 
set x2data 
set boxwidth
set boxdepth 0
set style fill  empty border
set style rectangle back fc  bgnd fillstyle   solid 1.00 border lt -1
set style circle radius graph 0.02 
set style ellipse size graph 0.05, 0.03 angle 0 units xy
set dummy x, y
set format x "% h" 
set format y "% h" 
set format x2 "% h" 
set format y2 "% h" 
set format z "% h" 
set format cb "% h" 
set format r "% h" 
set ttics format "% h"
set timefmt "%d/%m/%y,%H:%M"
set angles radians
set tics back
unset grid
unset raxis
set theta counterclockwise right
set style parallel front  lt black linewidth 2.000 dashtype solid
set key notitle
set key fixed right bottom vertical Right noreverse enhanced autotitle nobox
set key noinvert samplen 4 spacing 1 width 0 height 0
set key maxcolumns 0 maxrows 0
set key noopaque
unset style line
unset style arrow
set style histogram clustered gap 2 title textcolor lt -1
unset object
unset walls
set style textbox  transparent margins  1.0,  1.0 border  lt -1 linewidth  1.0
set offsets 0, 0, 0, 0
set pointsize 1
set pointintervalbox 1
set encoding default
unset parametric
unset polar
unset spiderplot
unset decimalsign
unset micro
unset minussign
set view 60, 30, 1, 1
set view azimuth 0
set rgbmax 255
set samples 100, 100
set isosamples 10, 10
set surface implicit
set surface
set mapping cartesian
set datafile separator whitespace
set datafile nocolumnheaders
unset hidden3d

unset contour
set cntrlabel  format '%8.3g' font '' start 5 interval 20
set cntrparam order 4
set cntrparam linear
set cntrparam levels 5
set cntrparam levels auto
set cntrparam firstlinetype 0 unsorted
set cntrparam points 5
set size ratio 0 1,1
set origin 0,0
set contourfill auto 5
set contourfill palette
set style data points
set style function lines
unset xzeroaxis
unset yzeroaxis
unset zzeroaxis
unset x2zeroaxis
unset y2zeroaxis
set xyplane relative 0.5
set tics scale  1, 0.5, 1, 1, 1
set mxtics default
set mytics default
set mztics default
set mx2tics default
set my2tics default
set mcbtics default
set mrtics default
set nomttics
set xtics border in scale 1,0.5 mirror norotate  autojustify
set xtics  norangelimit autofreq 
set ytics border in scale 1,0.5 mirror norotate  autojustify
set ytics  norangelimit autofreq 
set ztics border in scale 1,0.5 nomirror norotate  autojustify
set ztics  norangelimit autofreq 
unset x2tics
unset y2tics
set cbtics border in scale 1,0.5 mirror norotate  autojustify
set cbtics  norangelimit autofreq 
set rtics axis in scale 1,0.5 nomirror norotate  autojustify
set rtics  norangelimit autofreq 
unset ttics
set title "" 
set title  font "" textcolor lt -1 norotate
set timestamp bottom 
set timestamp "" 
set timestamp  font "" textcolor lt -1 norotate
set trange [ * : * ] noreverse nowriteback
set urange [ * : * ] noreverse nowriteback
set vrange [ * : * ] noreverse nowriteback
set xlabel "x" 
set xlabel  font "" textcolor lt -1 norotate
set x2label "" 
set x2label  font "" textcolor lt -1 norotate
set xrange [ 0.00000 : 10.0000 ] noreverse writeback
set x2range [ * : * ] noreverse writeback
#set ylabel "f(x)" 
set ylabel "y" 
set ylabel  font "" textcolor lt -1 norotate
set y2label "" 
set y2label  font "" textcolor lt -1 rotate
set yrange [ 0.00000 : 10.5000 ] noreverse writeback
set y2range [ * : * ] noreverse writeback
set zlabel "" 
set zlabel  font "" textcolor lt -1 norotate
set zrange [ * : * ] noreverse writeback
set cblabel "" 
set cblabel  font "" textcolor lt -1 rotate
set cbrange [ * : * ] noreverse writeback
set rlabel "" 
set rlabel  font "" textcolor lt -1 norotate
set rrange [ * : * ] noreverse writeback
unset logscale
unset jitter
set zero 1e-08
set lmargin  -1
set bmargin  -1
set rmargin  -1
set tmargin  -1
set pm3d explicit at s
set pm3d scansautomatic
set pm3d interpolate 1,1 flush begin noftriangles noborder corners2color mean
set pm3d clip z 
set pm3d nolighting
set palette positive nops_allcF maxcolors 0 gamma 1.5 color model RGB 
set palette rgbformulae 7, 5, 15
set colorbox default
set colorbox vertical origin screen 0.9, 0.2 size screen 0.05, 0.6 front  noinvert bdefault
set style boxplot candles range  1.50 outliers pt 7 separation 1 labels auto unsorted
set chi_shapes fraction 0.60
set loadpath 
set fontpath
set psdir
set fit brief errorvariables nocovariancevariables errorscaling prescale nowrap v5
GNUTERM = "qt"
I = {0.0, 1.0}
VoxelDistance = 0.0
GridDistance = 0.0

a = -log(9)
b = 0.1*log(9)
c = 10
d = 1
f(x) = c/(1.+exp(-(a+b*x)))+d

xmax = 25
set yrange [0:12]
set xrange [0:xmax]
set ytics 1
unset arrow
set arrow 1 from 0.00000, d+0.5*c, 0.00000 to -a/b, d+0.5*c, 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 2 from -a/b, 0, 0.00000 to -a/b, d+0.5*c, 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 3 from 0.00000, c+d, 0.00000 to xmax, c+d, 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype 2
#set label 2 "11" at 1,c+0.5*d
 set output 'puzzle_logistic.png'
plot f(x) w l lw 3 lc rgb "#ee8800" ti "f(x)"

xmax = 10
ymax= 9
set yrange [0:ymax]
set xrange [0:xmax]
unset label
unset arrow
h(x) = a*(1.-exp(-b*x))
a=8
b=log(2)

set arrow 1 from log(2)/b, 0, 0.00000 to log(2)/b, h(log(2)/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 2 from 0, h(log(2)/b), 0.00000 to log(2)/b, h(log(2)/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid

set arrow 3 from 2*log(2)/b, 0, 0.00000 to 2*log(2)/b, h(2*log(2)/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 4 from 0, h(2*log(2)/b), 0.00000 to 2*log(2)/b, h(2*log(2)/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid

set arrow 5 from 3*log(2)/b, 0, 0.00000 to 3*log(2)/b, h(3*log(2)/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 6 from 0, h(3*log(2)/b), 0.00000 to 3*log(2)/b, h(3*log(2)/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid

set arrow 7 from 4*log(2)/b, 0, 0.00000 to 4*log(2)/b, h(4*log(2)/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 8 from 0, h(4*log(2)/b), 0.00000 to 4*log(2)/b, h(4*log(2)/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid

set arrow 9 from 0, a, 0.00000 to xmax,a, 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype 2

 set output 'puzzle_normalExponential.png'
plot h(x) w l lw 3 lc rgb "#ee8800" ti "h_1(x)"


set key top right
h2(x) = a*(1.-exp(-b*sqrt(x)))
set xtics 1
unset arrow
set arrow 1 from log(2)/b, 0, 0.00000 to log(2)/b, h2(log(2)/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 2 from 0, h2(log(2)/b), 0.00000 to log(2)/b, h2(log(2)/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid

set arrow 3 from 9*log(2)/b, 0, 0.00000 to 9*log(2)/b, h2(9*log(2)/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 4 from 0, h2(9*log(2)/b), 0.00000 to 9*log(2)/b, h2(9*log(2)/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid

set arrow 7 from 4*log(2)/b, 0, 0.00000 to 4*log(2)/b, h2(4*log(2)/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 8 from 0, h2(4*log(2)/b), 0.00000 to 4*log(2)/b, h2(4*log(2)/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid

set arrow 9 from 0, a, 0.00000 to xmax,a, 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype 2

 set output 'puzzle_stretchedExponential.png'
plot h2(x) w l lw 3 lc rgb "#ee8800" ti "h_2(x)"



set key top right
xmax = 10
ymax= 4
set xtics 2
set yrange [0:ymax]
set xrange [0:xmax]
unset label
unset arrow
g(x) = a*x*exp(-b*x)
gPrime(x) = a*(-b*x+1)*exp(-b*x)
a=5
b=0.5
lTan = 1.5
set arrow 1 from 0.00000, 10*exp(-1), 0.00000 to 1/b, 10*exp(-1), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 2 from 1/b, 0, 0.00000 to 1/b, 10*exp(-1), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 3 from 2/b, 0, 0.00000 to 2/b, g(2/b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 4 from 0, 0, 0.00000 to 0.5, 0.5*a, 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 5 from 2/b -lTan,-lTan*gPrime(2/b)+g(2/b),0 to 2/b+lTan,lTan*gPrime(2/b)+g(2/b),0 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set label 1 "10/e" at -0.900000, 10*exp(-1), 0.00000 left norotate back nopoint
set label 2 "5" at 0.1, 2.2, 0.00000 left norotate back nopoint
 set output 'puzzle_ricker.png'
plot g(x) w l lw 3 lc rgb "#ee8800" ti "g(x)"

j(x) = a*x/(b+x)**2
j2(x) = a2*x/(b2+x**2)
j2x(x) = a3*x/(b3+x**(1.3333333))
jPrime(x) = a*(b**2-x**2)/(b+x)**4
j2Prime(x) = a2*(b2-x**2)/(b2+x**2)**2
j2xPrime(x) = a3*(b3-1./3*x**(4./3))/(b3+x**(4./3))**2
set xrange [0:20]
set xtics 5
lTan=0.9
lTan2=5
a=60.
b=5.
a2=30.
b2=25.
b3=(0.3333333)*b**(1.3333333)
a3=a/b**2*b3
unset arrow
unset label
set arrow 1 from 0, 0, 0.00000 to lTan, lTan*jPrime(0), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 2 from b, 0, 0.00000 to b, j(b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 3 from 0, j(b), 0.00000 to b, j(b), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 4 from 2*b-lTan2,-lTan2*jPrime(2.*b)+j(2.*b) to 2*b+lTan2,lTan2*jPrime(2.*b)+j(2.*b) nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 5 from 2*b,0 to 2*b,j(2*b) nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid

#set label 1 "12/5" at 0.3, 2.4, 0.00000 left norotate back nopoint
set label 1 "12/5" at 0.3, 0.3, 0.00000 left norotate back nopoint
 set output 'puzzle_hassell.png'
plot j(x) w l lw 3 lc rgb "#ee8800" ti "j(x)"


set arrow 6 from sqrt(3)*sqrt(b2)-lTan2,-lTan2*j2Prime(sqrt(3)*sqrt(b2))+j2(sqrt(3)*sqrt(b2)) to sqrt(3)*sqrt(b2)+lTan2,lTan2*j2Prime(sqrt(3)*sqrt(b2))+j2(sqrt(3)*sqrt(b2)) nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 7 from sqrt(3)*sqrt(b2),0 to sqrt(3)*sqrt(b2),j2(sqrt(3)*sqrt(b2)) nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 8 from 0, 0, 0.00000 to 2*lTan, 2*lTan*j2Prime(0), 0.00000 nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid

set label 1 "12/5" at 1.2, 0.7, 0.00000 left norotate back nopoint #color rgb "#ee8800"
set label 2 "6/5" at 1.5, 0.3, 0.00000 left norotate back nopoint #color rgb "#aa0000" 
#set label 3 "{/Symbol @\\\\326\140}3 *5" at 8.5,1 left rotate by 90 back nopoint 

set output 'puzzle_hassell-shepherd.png'
plot j(x) w l lw 3 lc rgb "#ee8800" ti "j(x)=ax/(b+x)^2", \
j2(x) w l lw 3 lc rgb "#aa0000" ti "j_2(x)=ax/(b+x^2)"

unset label 2
unset arrow 6
unset arrow 7
unset arrow 8

set arrow 6 from 9.44-lTan2,-lTan2*j2xPrime(9.44)+j2x(9.44) to 9.44+lTan2,lTan2*j2xPrime(9.44)+j2x(9.44) nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid
set arrow 7 from 9.44,0 to 9.44,j2x(9.44) nohead back nofilled linecolor rgb "#0033aa"  linewidth 1.000 dashtype solid

set output 'puzzle_hassell-shepherd2.png'
plot j(x) w l lw 3 lc rgb "#ee8800" ti "j(x)=ax/(b+x)^2", \
j2x(x) w l lw 3 lc rgb "#aa0000" ti "j_2(x)=ax/(b+x^{4/3})"


