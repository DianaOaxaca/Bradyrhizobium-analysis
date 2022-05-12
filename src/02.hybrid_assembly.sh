#!/bin/bash
#DianaOaxaca 270322

export LC_ALL=en_US.UTF-8

FASTQ=$(ls data/hybrid/*.fastq | sed 's/_.*.$//' | sed 's/data\/hybrid\///' | sort -u)
#echo $FASTQ
declare -a FASTQs=("$FASTQ")

for FILE in ${FASTQs[@]}; do
        UNICYCline='unicycler -1 data/hybrid/'$FILE'_R1_val_1.fq -2 data/hybrid/'$FILE'_R2_val_2.fq -l data/hybrid/'$FILE'_pc.fastq --vcf -t 24 -o analysis/03.hybrid_assembly/'$FILE'_unicycler'
        UNICYCrun=$(unicycler -1 data/hybrid/$FILE'_R1_val_1.fq' -2 data/hybrid/$FILE'_R2_val_2.fq' -l data/hybrid/$FILE'_pc.fastq' --vcf -t 24 -o analysis/03.hybrid_assembly/$FILE'_unicycler')
        echo -e $FILE"\n"$UNICYCline"\n"$UNICYCrun
done
