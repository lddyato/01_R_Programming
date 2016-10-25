1. 
What value is returned by the following call to pollutantmean()? You should round your output to 3 digits.



1
pollutantmean("specdata", "sulfate", 1:10)

3.666

6.545

6.026

4.868

4.064

3.782
1
point
2. 
What value is returned by the following call to pollutantmean()? You should round your output to 3 digits.



1
pollutantmean("specdata", "nitrate", 70:72)

2.394

1.706

2.604

2.752

1.182

0.914
1
point
3. 
What value is returned by the following call to pollutantmean()? You should round your output to 3 digits.



1
pollutantmean("specdata", "sulfate", 34)

1.573

0.450

0.680

0.591

1.300

1.477
1
point
4. 
What value is returned by the following call to pollutantmean()? You should round your output to 3 digits.



1
pollutantmean("specdata", "nitrate")

1.774

1.703

2.233

2.493

1.842

2.363
1
point
5. 
What value is printed at end of the following code?



1
2
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

228 148 124 165 104 460 232

204 222 200 212 213 198 196

215 201 188 204 193 213 206

201 214 235 183 198 210 210

217 210 206 214 211 203 211

227 184 189 196 232 224 189
1
point
6. 
What value is printed at end of the following code?



1
2
cc <- complete("specdata", 54)
print(cc$nobs)

219

213

220

228

248

205
1
point
7. 
What value is printed at end of the following code?



1
2
3
4
5
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])

711 135 74 445 178 73 49 0 687 237

270 310 27 692 307 681 631 455 690 440

524 577 276 487 3 592 5 148 645 435

608 885 684 510 765 171 244 745 624 216

643 99 703 673 59 366 277 644 318 594
1
point
8. 
What value is printed at end of the following code?



1
2
3
4
5
cr <- corr("specdata")                
cr <- sort(cr)                
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

0.4474 0.4720 0.1239 0.5220 0.2538

-0.0203 0.5856 0.0983 0.3840 0.1137

0.1539 -0.0056 0.3023 0.4158 0.2558

0.3792 0.5118 0.3620 0.4726 0.5782

-0.0351 0.2736 -0.0176 0.5520 0.1828

0.2688 0.1127 -0.0085 0.4586 0.0447
1
point
9. 
What value is printed at end of the following code?



1
2
3
4
5
6
cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)                
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

229.0000 -0.2418 0.4496 0.8748 -0.3924 -0.5713

243.0000 0.2540 0.0504 -0.1462 -0.1680 0.5969

247.0000 0.1958 0.9304 -0.4851 -0.8229 -0.0679

242.0000 0.8233 0.3443 -0.2242 -0.7703 0.8735

225.0000 0.4216 0.4207 -0.0507 0.9377 0.0277

233.0000 -0.6377 0.3773 -0.0759 0.7335 0.2879
1
point
10. 
What value is printed at end of the following code?



1
2
3
4
5
cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))

2.0000 0.5596 -0.5655 -0.1241

3.0000 0.5342 -0.6713 0.3684

3.0000 -0.8907 0.4755 -0.0175

3.0000 -0.0206 -0.5881 0.5135

0.0000 -0.8974 0.8278 0.4519

0.0000 -0.0190 0.0419 0.1901
