/* install_ado_files */
* FIL 341


/* until you know very well what you are doing in Stata, install ado files 
only this way:
ssc install replace_pkname [, all replace] */
/* if you want to uninstall ado files:
ssc uninstall replace_pkname                    */
/* if you want to see which ado files you already installed:
ado dir
*/

cd      // shows current directory
sysdir

/* select commands (text) you want to run and press:
on PC: control-D
on Mac: command-shift-D */


ssc install freduse
help freduse


/****************                   Examples                  *****************/

clear
freduse DJIA
br
twoway line DJIA daten 

clear
freduse GOLDAMGBD228NLBM
br
twoway line GOLDAMGBD228NLBM daten if daten > 16000
generate int datenx = daten 
br
/* January 1st, 1960 is day 0 for Stata */

clear
freduse LREM25TTCHQ156S
twoway line LREM25TTCHQ156S daten

clear
freduse LREM25TTUSM156S
twoway line LREM25TTUSM156S daten





clear
freduse TB3MS
twoway line TB3MS daten
clear
freduse A191RI1Q225SBEA
twoway line A191RI1Q225SBEA daten
clear
freduse GOLDAMGBD228NLBM
twoway line GOLDAMGBD228NLBM daten


/* we may try these later */
/*
ssc install estout
ssc install outreg2
*/
