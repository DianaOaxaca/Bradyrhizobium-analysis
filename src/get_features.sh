#!/usr/bin/bash
#Diana Oaxaca 190422
#Script to get features of each genome 

echo -e Strain"\t"CDS"\t"RNA"\t"tRNA"\t"nod genes"\t"nif genes"\t"nod names"\t"nif names

STRAINS=$(ls analysis/03.EggNogg/*.tsv | sed 's/^.*.\///' | sed 's/\..*$//')
DIR1="analysis/03.RASTtk/"
DIR2="analysis/03.EggNogg"

for STRAIN in $STRAINS; do 
        CDS=$(grep -v "#" $DIR1/$STRAIN/$STRAIN.ec-stripped.gff | cut -f3 | sort | uniq -c | awk '$2 == "CDS" {print $1}')
        RNA=$(grep -v "#" $DIR1/$STRAIN/$STRAIN.ec-stripped.gff | cut -f3 | sort | uniq -c | awk '$2 == "RNA" {print $1}')
        tRNA=$(grep -v "#" $DIR1/$STRAIN/$STRAIN.ec-stripped.gff | cut -f3 | sort | uniq -c | awk '$2 == "tRNA" {print $1}')
        NODnumber=$(grep -v '##' $DIR2/$STRAIN.emapper.annotations.tsv | cut -f9 | grep 'nod' | wc -l)
        NODnames=$(grep -v '##' $DIR2/$STRAIN.emapper.annotations.tsv | cut -f9 | grep 'nod')
        NIFnumber=$(grep -v '##' $DIR2/$STRAIN.emapper.annotations.tsv | cut -f9 | grep 'nif' | wc -l)
        NIFnames=$(grep -v '##' $DIR2/$STRAIN.emapper.annotations.tsv | cut -f9 | grep 'nif')
        echo -e $STRAIN"\t"$CDS"\t"$RNA"\t"$tRNA"\t"$NODnumber"\t"$NIFnumber"\t"$NODnames"\t"$NIFnames
done
