#!/bin/bash
#DianaOaxaca 250322

export LC_ALL=en_US.UTF-8

FASTQ=$(ls data/illumina/ | sed 's/_.*.$//' | sed 's/data\/illumina\///' | sort -u)
#echo $FASTQ
declare -a FASTQs=("$FASTQ")

for FILE in ${FASTQs[@]}; do
        FASTQCline='fastqc data/illumina/'$FILE'_R1.fastq  data/illumina/'$FILE'_R2.fastq -o analysis/01.fastqc/'
        TRIMline='trim_galore --fastqc --illumina --paired --retain_unpaired -j 12 data/illumina/'$FILE'_R1.fastq  data/illumina/'$FILE'_R2.fastq -o analysis/02.trimgal$
        #echo -e $FILE"\n"$FASTQCline"\n"$TRIMline 
        FASTQCrun=$(fastqc data/illumina/$FILE'_R1.fastq'  data/illumina/$FILE'_R2.fastq' -o analysis/01.fastqc/)
        TRIMrun=$(trim_galore --fastqc --illumina --paired --retain_unpaired  data/illumina/$FILE'_R1.fastq'  data/illumina/$FILE'_R2.fastq' -o analysis/02.trimgalore/$$
        echo -e $FILE"\n"$FASTQCline"\n"$FASTQCrun"\n"$TRIMline"\n"$TRIMrun
done
