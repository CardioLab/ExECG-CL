{smcl}
{* *! version 1.0.0 6 May 2020}{...}


{title:Title}

{p2colset 5 20 30 2}{...}
{p2col:{hi:execgcl} {hline 2}}ExECG-CL: Exercise ECG weighted clinical likelihood of coronary artery disease {p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
execgcl using data in memory

{p 8 17 2}
				{cmdab:execgcl}
				{ifin}
				{cmd:,}
				{opt m:ale}({it:varname}) 
				{opt age:}({it:varname}) 
				{opt symp:}({it:varname}) 
				{opt nb_rf:}({it:varname}) 
				{{opt execg:}({it:varname}) 
                                [{opt suff:ix}({it:string})
				{opt replace}
				{opt grp} 
				]



{pstd}



{synoptset 21 tabbed}{...}
{synopthdr:execgcl options}
{synoptline}
{syntab:Required}
{synopt:{opt m:ale(varname)}}gender, where male = 1 and female = 0{p_end}
{synopt:{opt age:}(varname)}age in years{p_end}
{synopt:{opt symp:}(varname)} Symptoms, where Non-typical angina=0, Atypical angina or dyspnoea=1 and Typical angina =2{p_end}
{synopt:{opt nb_rf}(varname)} Number of risk factors (0-5) (Riskfactors: Family history of early CAD, Smoking, Dyslipidaemia, Hypertension or Diabetes) {p_end}
{synopt:{opt execg:}(varname)} Result of Exercise ECG, where Normal=0, Inconclusive=1 and Abnormal =2{p_end}

{syntab:Optional}
{synopt:{opt suffix}(string)} Adds a suffix to the names of variables created by {cmd:execgcl}{p_end}
{synopt:{opt replace}} Replaces variables created by {cmd:execgcl} if they already exist{p_end}
{synopt:{opt grp}} Estimates the Ex-ECG clinical likelihood groups: 0"Very low risk (<=5%)" 1 "Low risk (5- <=15%)" 2 "Low intermed (15- <=50%)" 3 "High intermed (50- <=85%)" 4 "High (>85%)" {p_end}
{synoptline}
{p 4 6 2}



	
{title:Description}

{pstd}
The {cmd:execgcl} command calculates Exercise ECG weighted clinical likelihood of having obstructive coronary artery disease in patients with chronic coronary syndrome (symptoms suggestive of obstructive coronary artery disease) without previously documented coronary artery disease. The model is an extension of the Risk factor-weighted clinical likelihood model [1] to include Exercise ECG.  

 [1] Winther et al. Incorporating Coronary Calcification Into Pre-Test Assessment of the Likelihood of Coronary Artery Disease, Journals of the American College of Cardiology, 76.21 (2020): 2421-2432.

{title:Examples}

    {hline}
	


{pstd}  {com}. use https://vbn.aau.dk/files/513117263/SyntheticExECGdata.dta
        {txt}(Synthetic dataset of patients with chronic coronary syndrome )
		{p_end}


{pstd}Run {cmd:execgcl} using data in memory  {p_end}
{phang2}{cmd:. execgcl , male(male_sex) age(age) symp(symp) nb_rf(nb_rf)  execg(execg) }

{pstd}Run command, specifying the variable suffix {p_end}
{phang2}{cmd:. execgcl , male(male_sex) age(age) symp(symp) nb_rf(nb_rf)  execg(execg) suffix("_newStudy")}

{pstd}Run {cmd:execgcl} using data in memory and replace existing estimates{p_end}
{phang2}{cmd:. execgcl , male(male_sex) age(age) symp(symp) nb_rf(nb_rf)  execg(execg) replace }

{pstd}Run {cmd:execgcl} using data in memory, replace existing estimates and estimates the clinical likelihood groups  {p_end}
{phang2}{cmd:. execgcl , male(male_sex) age(age) symp(symp) nb_rf(nb_rf)  execg(execg) replace  grp}



    {hline}



{title:Stored results}

{pstd}
{cmd:execgcl} stores the following in memory:

{synoptset 15 tabbed}{...}

{synopt:{cmd:xecg_cl}} Exercise ECG weighted clinical likelihood {p_end}
{synopt:{cmd:xecg_cl_grp}} Exercise ECG weighted clinical likelihood group when requested  {p_end}


{marker citation}{title:Citation of {cmd:execgcl}}

{p 4 8 2}{cmd:execgcl} is not an official Stata command. It is a free contribution
to the research community, like a paper. Please cite it as such: {p_end}

{p 4 8 2}{it}
Schmidt SE, Rasmussen LD & Winther S (2023). execgcl: Stata module for calculating Exercise ECG weighted clinical likelihood of coronary artery disease, github.com/CardioLab/execgcl  {p_end} {reset}



   {hline}
{title:Authors}

{p 4 8 2}	Samuel Emil Schmidt, Aalborg Univerisity, DK {p_end}
{p 4 8 2} {browse "mailto:sschmidt@hst.aau.dk":sschmidt@hst.aau.dk}{p_end}
{p 4 8 2}	Laust D Rasmussen, Hospital Unit West, DK {p_end}
{p 4 8 2} {browse "mailto:laust.dupont@midt.rm.dk":laust.dupont@midt.rm.dk}{p_end}
{p 4 8 2}	Simon Winther, Hospital Unit West, DK {p_end}
{p 4 8 2}{browse "mailto:sw@dadlnet.dk":sw@dadlnet.dk}{p_end}



