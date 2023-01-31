program execgcl, rclass
version 13.0
 	syntax [if] [in] ,  ///
		male(varname numeric)  	/// integer 0 or 1
		age(varname numeric)   	/// Years
		symp(varname numeric)   /// 0: Non-typical angina  1: Atypical angina or dyspnoea 2: Typical angina
		nb_rf(varname numeric) /// integer: 0-5 
		execg(varname numeric) /// integer: Normal=0, Inconclusive=1 and Abnormal =2
		[replace  	 		///  replaces variables created by cadptp if they already exist
		grp					/// Estimates the CL groups 0"Very low risk (<=5%)" 1 "Low risk (5- <=15%)" 2 "Low intermed (15- <=50%)" 3 "High intermed (50- <=85%)" 4 "High (>85%)" 
		suffix(str) *] ///   adds a suffix to the names of variables created by cadptp

		marksample touse 
	    markout `touse' `male' `symp' `age'
	
	

	
	
/* drop variables if option "replace" is chosen */
		 
if "`replace'" != "" { 


	
	
	
	
		capture confirm variable xecg_cl`suffix'
		if !_rc {	   
					   drop xecg_cl`suffix'
			   }
			   
		if "`grp'" !="" { 
		capture confirm variable xecg_cl_grp`suffix'
		if !_rc {		   
						drop xecg_cl_grp`suffix'
				   }
		}
		   
	
	

	

}



  
* Estimate PTP values
quietly {

	tempvar symp_non_anglinal  symp_typical nb_rf_3 normal_execg abnormal_exg

	label define cadptp_riskgrp 0 "Very low (<=5%)" 1 "Low (5- <=15%)" 2 "Low intermed (15- <=50%)" 3 "High intermed (50- <=85%)" 4 "High (>85%)"  , replace

		* One hot encoding symptoms
		gen `symp_non_anglinal' = (`symp'==0)
		gen `symp_typical' = (`symp'==2)
	

		gen `nb_rf_3'  =.
		replace `nb_rf_3' =1 if `nb_rf' < 2
		replace `nb_rf_3' =2 if `nb_rf' >= 2 & `nb_rf' < 4
		replace `nb_rf_3' =3 if `nb_rf' >= 4 
		
		gen `normal_execg' = (`execg'==0)
		gen `abnormal_exg' = (`execg'==2)

		gen xecg_cl`suffix' =.
		replace xecg_cl`suffix' = 1./(1+exp(-(-9.5260 + (1.6128*`male') + (0.08440*`age') +  (2.7112* `symp_typical' ) + (-0.4675*`symp_non_anglinal') + (1.4940*`nb_rf_3') + (-0.0187*`age'*`symp_typical') + (-0.0131 *`age'*`nb_rf_3') + (-0.2799*`symp_typical'*`nb_rf_3') + (-0.2091*`male'*`nb_rf_3') + (-0.3959*`normal_execg' )+(0.7909*`abnormal_exg') -0.1278 ))) if  `nb_rf' !=. &  `touse' 
		label variable xecg_cl`suffix' "Exercise ECG weighted clinical likelihood of coronary artery disease"
	
		if "`grp'" !="" { 	
			gen xecg_cl_grp`suffix'=.
			replace xecg_cl_grp`suffix' =0 if xecg_cl >=0.00 & xecg_cl <=.05
			replace xecg_cl_grp`suffix'=1 if xecg_cl >0.05 & xecg_cl <=0.15
			replace xecg_cl_grp`suffix' =2 if xecg_cl >0.15 & xecg_cl <=0.50
			replace xecg_cl_grp`suffix' =3 if xecg_cl >0.50 & xecg_cl<=0.85
			replace xecg_cl_grp`suffix' =4 if xecg_cl >0.85 & xecg_cl <=1.00

			label variable xecg_cl_grp`suffix' "Exercise ECG weighted clinical likelihood groups of coronary artery disease"
			label values xecg_cl_grp`suffix'  cadptp_riskgrp
		}

	 


 }
  
end
