#!/usr/bin/bash
#DianaOaxaca 120422

#This  show the line code for assembly 23-inga and 1N3-inga strains after plasmid clean

#1N3-inga chromosome
spades.py --careful -1 data/plasmid/filter/1N3-inga_fltrplasm_1.fastq -2 data/plasmid/filter/1N3-inga_fltrplasm_2.fastq -k 21,33,55,77,99,121 -t 40 -o analysis/02.assembly_chr_fltr/1N3-inga_fltr_spades

#23-inga chromosome
conda activate unicycler
unicycler -1 data/plasmid/filter/23-inga_fltrplasm_1.fastq -2 data/plasmid/filter/23-inga_fltrplasm_2.fastq -l data/minion/23-inga_pc.fastq --mode bold -t 32 -o 23-inga_fltr_sinminlength_unicyc
