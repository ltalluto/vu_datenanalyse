<style>
	td p {margin: 0px;}
	.sm {margin: 0px 5px; font-size: x-small}
	.nmhead {margin: 0px; font-weight: bold}
	.srb {color: #beaed4; margin: 0px}
	.rr18 {color: #c57a3e; margin: 0px}
	.rr19 {color: #2baad3; margin: 0px}
	.rr20 {color: #ca5478; margin: 0px}
	.rr21 {color: #73a450; margin: 0px}
/*	.pr5 {color: #fdc086; margin: 0px}*/
	table {font-size: small;}
</style>

<p class="nmhead">Instructors</p>
Gabriel Singer, Lauren Talluto, Thomas Fuß <br/>


### Course description

This course covers various univariate and multivariate statistical analyses appropriate for common applied problems in ecology. We discuss the theoretical foundations of the analyses, assumptions, applications. We also introduce data preparation and visualisation. Via worked examples, students learn to perform analyses in R, as well as in Canoco (for some multivariate analyses). 

### Learning objectives
Following the course, students should be able to:

* Describe common univariate statistical tests, including the hypotheses tested and assumptions required.
* Implement tests in R, including reading and preparing data.
* Interpret the output of tests, draw conclusions in terms of the ecological hypotheses being tested, and describe the results in plain language.
* Use visualisation tools in R for exploratory analysis and final presentation.
* Decide when the structure of the data requires multivariate analysis, and choose an appropriate method.
* Apply multivariate statistics in R.
* Interpret (with the help of visualisation) multivariate analyses in terms of the original variables.

### Assessment
Students will be graded based on their participation during the exercise sessions (40%) and on completion of three protocols (one per unit, 20% each, total of 60%). These protocols can  be completed individually or in small groups (max. 3 students per group) and will be due on **14 February 2025**. Details about the assignments and expectations will be provided on the first day of class.

Note that attendence is mandatory.


### Course Outline


<table>
	<tr>
		<th> </th> 
		<th> </th> 
		<th> Topics </th> 
		<th> Exercises (in-class) </th>
		<th> Protocol </th>
	</tr>
	<tr>
		<td rowspan = 3>
			<p><strong>Unit 1</strong></p>
			<p class="sm prb">Talluto</p>
		</td>
		<td>
			Day 1
			<p class="sm rr18">G0: 13.01 14:30–18:45, RR18</p>
			<p class="sm rr18">G1: 16.01 8:00–11:45, RR18</p>
		</td>
		<td>
			<p><a href="unit_1/lec1a_basics.html">The Basics</a></p>
			<p class="sm">Introduction to R</p>
			<p class="sm">Populations, samples</p>
			<p class="sm">Descriptive statistics</p>
		</td>
		<td>
			<p><a href="unit_1/worksheet_1_1.html">Exercises 1.1</a></p>
<!-- 			<p class="sm">R Base Graphics</p>
			<p class="sm">Programming basics</p>
			<p class="sm">Sampling</p> -->
		</td>
		<td rowspan = 3>Protocol 1</td>
	</tr>
	<tr>
		<td>
			Day 2
			<p class="sm rr20">G0: 14.01 8:00–11:45, RR20</p>
			<p class="sm rr18">G1: 17.01 12:00–15:15, RR18</p>
		</td>
		<td>
			<p><a href="unit_1/lec1b_univariate.html">Univariate statistics</a></p>
			<p class="sm">Confidence intervals</p>
			<p class="sm">Significance tests</p>
			<p class="sm">Type I and II errors</p>
		</td>
		<td>
			<p><a href="unit_1/worksheet_1_2.html">Exercises 1.2</a></p>
		</td>
	</tr>
	<tr>
		<td>
			Day 3
			<p class="sm rr18">G0: 15.01 8:00–11:45, RR18</p>
			<p class="sm rr18">G1: 20.01 13:45–18:30, RR18</p>
		</td>
		<td>
			<p><a href="unit_1/lec1c_basics2.html">The Basics part II</a></p>
			<p class="sm">Data structures</p>
			<p class="sm">Visualisation</p>
			<p class="sm">Association and Correlation</p>
		</td>
		<td>
			<p><a href="unit_1/worksheet_1_3.html">Exercises 1.3</a></p>
		</td>
	</tr>
	<tr>
		<td rowspan = 3>
			<p><strong>Unit 2</strong></p>
			<p class="sm prb">Singer</p>
		</td>
		<td>
			Day 4
			<p class="sm rr18">G0: 22.01 13:45–17:30, RR18</p>
			<p class="sm rr18">G1: 23.01 8:00–11:45, RR18</p>
		</td>
		<td>
			<p><a href="unit_1/lec1a_basics.html">Linear Models I</a></p>
			<p class="sm">Linear regression</p>
		</td>
		<td>
			<p><a href="unit_1/worksheet_2_1.html">Exercises 2.1</a></p>
<!-- 			<p class="sm">R Base Graphics</p>
			<p class="sm">Programming basics</p>
			<p class="sm">Sampling</p> -->
		</td>
		<td rowspan = 3>Protocol 2</td>
	</tr>
	<tr>
		<td>
			Day 5
			<p class="sm rr18">G0: 23.01 13:45–18:00, RR18</p>
			<p class="sm rr19">G1: 24.01 14:30–18:45, RR19</p>
		</td>
		<td>
			<p><a href="unit_1/lec1b_univariate.html">Linear Models II</a></p>
			<p class="sm">Multiple linear regression</p>
			<p class="sm">Model selection</p>
		</td>
		<td>
			<p><a href="unit_1/worksheet_2_2.html">Exercises 2.2</a></p>
		</td>
	</tr>
	<tr>
		<td>
			Day 6
			<p class="sm srb">G0: 24.01 8:00–11:45, SRB</p>
			<p class="sm rr18">G1: 27.01 8:00–11:45, RR18</p>
		</td>
		<td>
			<p><a href="unit_1/lec1a_basics.html">Analysis of Variance</a></p>
			<p class="sm">ANOVA</p>
			<p class="sm">ANCOVA</p>
			<p class="sm">Nonparametric location tests</p>
		</td>
		<td>
			<p><a href="unit_1/worksheet_2_3.html">Exercises 2.3</a></p>
		</td>
	</tr>
	<tr>
		<td rowspan = 3>
			<p><strong>Unit 3</strong></p>
			<p class="sm prb">Fuß</p>
		</td>
		<td>
			Day 7
			<p class="sm rr18">G0: 27.01 12:00–16:15, RR18</p>
			<p class="sm rr21">G1: 29.01 13:00–17:15, RR21</p>
		</td>
		<td>
			<p><a href="unit_1/lec1a_basics.html">Multivariate Stats I</a></p>
			<p class="sm">Principle components analysis (PCA)</p>
			<p class="sm">Redundancy analysis (RDA)</p>
		</td>
		<td>
			<p><a href="unit_1/worksheet_3_1.html">Exercises 3.1</a></p>
<!-- 			<p class="sm">R Base Graphics</p>
			<p class="sm">Programming basics</p>
			<p class="sm">Sampling</p> -->
		</td>
		<td rowspan = 3>Protocol 3</td>
	</tr>
	<tr>
		<td>
			Day 8
			<p class="sm rr20">G0: 28.01 8:00–11:45, RR20</p>
			<p class="sm rr18">G1: 30.01 8:00–11:45, RR18</p>
		</td>		
		<td>
			<p><a href="unit_1/lec1a_basics.html">Multivariate Stats II</a></p>
			<p class="sm">RDA continued</p>
			<p class="sm">Permutation tests</p>
		</td>
		<td>
			<p><a href="unit_1/worksheet_3_2.html">Exercises 3.2</a></p>
		</td>
	</tr>
	<tr>
		<td>
			Day 9
			<p class="sm rr21">G0: 29.01 8:00–11:45, RR21</p>
			<p class="sm rr18">G1: 31.01 8:00–11:45, RR18</p>
		</td>
		<td>
			<p><a href="unit_1/lec1a_basics.html">Multivariate Stats III</a></p>
			<p class="sm">Nonmetric multidimensional scaling (NMDS)</p>
		</td>
		<td>
			<p><a href="unit_1/worksheet_3_3.html">Exercises 3.3</a></p>
		</td>
	</tr>
	<tr>
		<td colspan=5>
			<p class="nmhead">Meeting locations</p>
			<p class="sm rr18">Rechneraum 18, Architekturgebäude UG (RR18)</p>
			<p class="sm rr19">Rechneraum 19, Architekturgebäude UG (RR19)</p>
			<p class="sm rr20">Rechneraum 20, Architekturgebäude UG (RR20)</p>
			<p class="sm rr21">Rechneraum 21, Architekturgebäude UG (RR21)</p>
			<p class="sm srb">Seminarraum Biologie, EG, Technikerstr. 25 (SRB)</p>
		</td>
	</tr>
</table>






