#!/bin/bash
#DianaOaxaca 060422

export LC_ALL=en_US.UTF-8

#FASTQ=$(ls data/short/*.fq | sed 's/_.*.$//' | sed 's/data\/short\///' | sort -u)
#echo $FASTQ
#declare -a FASTQs=("$FASTQ")

#for FILE in ${FASTQs[@]}; do
#       SPADESline='spades.py --plasmid --careful -1 data/short/'$FILE'_R1_val_1.fq -2 data/short/'$FILE'_R2_val_2.fq  -t 32 -o analysis/02.plasmidspades_assembly/'$FILE'_plasmidspades'
#       SPADESrun=$(spades.py --plasmid --careful -1 data/short/$FILE'_R1_val_1.fq' -2 data/short/$FILE'_R2_val_2.fq'  -t 32 -o analysis/02.plasmidspades_assembly/$FILE'_plasmidspades')
#       echo -e $FILE"\n"$SPADESline"\n"$SPADESrun
#done

#Assembly plasmids after clean chromosome of reads
spades.py  --plasmid --careful -1 data/plasmid/filter/1N3-inga_fltrchr_1.fastq -2 data/plasmid/filter/1N3-inga_fltrchr_2.fastq -t 32 -o analysis/02.plasmidspades_assembly/1N3-inga_plasmidspades_fltr
spades.py  --plasmid --careful -1 data/plasmid/filter/23-inga_fltrchr_1.fastq -2 data/plasmid/filter/23-inga_fltrchr_2.fastq --nanopore data/plasmid/filter/23-inga_minionfltrchr.fastq -t 32 -o analysis/02.plasmidspades_assembly/23-inga_plasmidspades_fltr_hybrid
