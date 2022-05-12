#!/bin/bash
#DianaOaxaca 260322

export LC_ALL=en_US.UTF-8

FASTQ=$(ls data/short/*.fq | sed 's/_.*.$//' | sed 's/data\/short\///' | sort -u)
echo $FASTQ
declare -a FASTQs=("$FASTQ")

for FILE in ${FASTQs[@]}; do
        SPADESline='spades.py --careful -1 data/short/'$FILE'_R1_val_1.fq -2 data/short/'$FILE'_R2_val_2.fq -k 21,33,55,77,99,121 -t 24 -o analysis/03.spades_assembly/'$
        SPADESrun=$(spades.py --careful -1 data/short/$FILE'_R1_val_1.fq' -2 data/short/$FILE'_R2_val_2.fq' -k 21,33,55,77,99,121 -t 24 -o analysis/03.spades_assembly/$$
        echo -e $FILE"\n"$SPADESline"\n"$SPADESrun
done
