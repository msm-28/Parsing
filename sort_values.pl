#!/usr/bin/env/perl -w

use strict;
use warnings;
 my @infile = $ARGV[0];

open(FH,"<",@infile);
open(RH1,">","1.dat");#true dimer
open(RH2,">","2.dat");#lipid/loose dimer
open(RH3,">","3.dat");#ICL3 dimer
open(RH4,">","4.dat");#monomer

while(<FH>)
{
	if($_=~m/(.*)\t(.*)\t(.*)\n/)
	{	
		if(eval($2 > 0.6))
		{
			print RH4 $_;
		}
			
		elsif(eval($2 < 0.6 || $2 == 0.6) && eval($3 < 0.6 || $3 == 0.6))
		{
			print RH1 $_;
		
		}


		elsif(($2 < 0.6 || $2 == 0.6) && ($3 > 0.6) && ($3 < 1.5 || $3 == 1.5))
		{
			print RH2 $_;
		
		}

		elsif(($2 < 0.6) && ($3 > 1.5))
		{
			print RH3 $_;
		
		}

		else
		{
			print $_;
		
		}
	
	}

}


 
