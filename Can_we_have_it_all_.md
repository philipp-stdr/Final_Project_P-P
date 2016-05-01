# Can we have it all?
Philip Unger & Philipp Staender  
2 May 2016  





## Intro

<div class="black">
Research Question
</div>

*"Are career pursuits reconcilable with a happy life?"* 

<div class="black">
The debate
</div>

*'I still strongly believe that women can “have it all” (and that men can too). ... But not today, not with the way America’s economy and society are currently structured.'*

<div class="black">
Anne-Marie Slaughter - Former director of policy planning for the U.S. State Department
</div>


## Research Design | Data

<div class="black">
General Social Survey
</div>

- Cross-sectional survey of the adult population in the United States
- Conducted between 1972 to 2014
- Sample size around 60,000

<div class="black">
Current Population Survey
</div>

- used to generate income percentiles in age and educational groups (reference group income)



## Research Design 

<div class="black">
Methodology
</div>

- Graphical analysis
- Linear Probability Model

<div class="black">
Operationalization
</div>

- Defining career
- Sample heterogeneity 

# Descriptive statistics

## Measures of happiness

<div class="figure">
<img src="Can_we_have_it_all__files/figure-html/unnamed-chunk-2-1.png" alt="Figure 1: Distribution of reported happiness, job-satisfaction and happiness with marriage"  />
<p class="caption">Figure 1: Distribution of reported happiness, job-satisfaction and happiness with marriage</p>
</div>

## Gender and age
<div class="figure">
<img src="Can_we_have_it_all__files/figure-html/unnamed-chunk-3-1.png" alt="Figure 2: Happiness and age"  />
<p class="caption">Figure 2: Happiness and age</p>
</div>
*Notes: Sample restricted to college educated men and women*

## Labour-market affiliation
<div class="figure">
<img src="Can_we_have_it_all__files/figure-html/unnamed-chunk-4-1.png" alt="Figure 3: Happiness and labour-market affiliation"  />
<p class="caption">Figure 3: Happiness and labour-market affiliation</p>
</div>
*Notes: Sample restricted to college educated men and women*

## Family status and income
<div class="figure">
<img src="Can_we_have_it_all__files/figure-html/unnamed-chunk-5-1.png" alt="Figure 5: Happiness and family constellation"  />
<p class="caption">Figure 5: Happiness and family constellation</p>
</div>
*Notes: Sample restricted to college educated men and women*

# Regression analysis

## Model 1: Interaction effects of marriage and job income

<table style="text-align:center"><tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="2"><em>Dependent variable:</em></td></tr>
<tr><td></td><td colspan="2" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td colspan="2">Very happy</td></tr>
<tr><td style="text-align:left"></td><td>Women</td><td>Men</td></tr>
<tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">High-income</td><td>6.899<sup>***</sup></td><td>5.672<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(2.623)</td><td>(2.657)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Married</td><td>21.892<sup>***</sup></td><td>19.672<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(1.847)</td><td>(2.149)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">High-income*Married</td><td>-7.033<sup>**</sup></td><td>-1.069</td></tr>
<tr><td style="text-align:left"></td><td>(3.453)</td><td>(3.201)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Constant</td><td>82.482<sup>**</sup></td><td>-14.984</td></tr>
<tr><td style="text-align:left"></td><td>(34.487)</td><td>(30.006)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Age</td><td>Yes</td><td>Yes</td></tr>
<tr><td style="text-align:left">Age-squared</td><td>Yes</td><td>Yes</td></tr>
<tr><td style="text-align:left">Year</td><td>Yes</td><td>Yes</td></tr>
<tr><td style="text-align:left">Race</td><td>Yes</td><td>Yes</td></tr>
<tr><td style="text-align:left">Cohort</td><td>Yes</td><td>Yes</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>4,014</td><td>3,850</td></tr>
<tr><td style="text-align:left">R<sup>2</sup></td><td>0.062</td><td>0.053</td></tr>
<tr><td style="text-align:left">Adjusted R<sup>2</sup></td><td>0.052</td><td>0.042</td></tr>
<tr><td style="text-align:left">Residual Std. Error</td><td>47.220 (df = 3970)</td><td>46.267 (df = 3806)</td></tr>
<tr><td style="text-align:left">F Statistic</td><td>6.075<sup>***</sup> (df = 43; 3970)</td><td>4.960<sup>***</sup> (df = 43; 3806)</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="2" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
</table>
*Notes: Sample restricted to college educated men and women*

## Illustration of interaction effect

<div class="figure">
<img src="Can_we_have_it_all__files/figure-html/unnamed-chunk-7-1.png" alt="Figure 6: Interaction effects of marriage and job income on life satisfaction"  />
<p class="caption">Figure 6: Interaction effects of marriage and job income on life satisfaction</p>
</div>

## Outlook

- model specifications...
- double click on married people
    + 
