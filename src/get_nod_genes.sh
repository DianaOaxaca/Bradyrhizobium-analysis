#!/usr/bin/bash
#DianaOaxaca
#Get nod genes 

#Create directory path variables
DIR1="analysis/03.EggNogg"
DIR2="analysis/03.RASTtk/faa"

#STRAINS=$(ls analysis/03.EggNogg/*.tsv | sed 's/^.*.\///' | sed 's/\..*$//')

#Get headers of nod genes
for STRAIN in $STRAINS; do
       NOD=$(grep -v '##' $DIR/$STRAIN.emapper.annotations.tsv | cut -f1,9 | grep 'nod' | cut -f1)
       NOD=$(echo $NOD | tr ' ' '\n' > analysis/03.nod_genes/$STRAIN.nod_headers2.txt)
       echo $NOD
done

#Get nod genes sequences
mkdir -p analysis/03.RASTtk/faa/
ln -s analysis/03.RASTtk/*/*.faa analysis/03.nod_genes/

DIR3="analysis/03.nod_genes"

for STRAIN in $STRAINS; do
       NOD_SEQ='seqtk-trinity subseq '$DIR2'/'$STRAIN'.faa  '$DIR3'/'$STRAIN'.nod_headers2.txt > '$DIR3'/'$STRAIN'.nod_genes.faa'
       NOD_SEQrun=$(seqtk-trinity subseq $DIR2/$STRAIN'.faa'  $DIR3/$STRAIN'.nod_headers2.txt' > $DIR3/$STRAIN'.nod_genes.faa')
       echo -e $NOD_SEQ"\n"$NOD_SEQrun
done

#Add names to genes
for STRAIN in $STRAINS; do
       NAMES=$(grep -v '##' $DIR/$STRAIN.emapper.annotations.tsv | cut -f1,9 | grep 'nod' | tr '\t' '-')
       NAMES=$(echo $NAMES | tr ' ' '\n' > analysis/03.nod_genes/$STRAIN.new_headers.txt)
       echo $NAMES
done

#Paste headers
for STRAIN in $STRAINS; do
       paste -d "\t" $DIR3/$STRAIN.nod_headers.txt $DIR3/$STRAIN.new_headers.txt > $DIR3/$STRAIN.allheaders.txt
done

for STRAIN in $STRAINS; do
       sed -i -r 's/^/>/g' $DIR3/$STRAIN.allheaders.txt
       sed -i -r 's/\t/\t>/g' $DIR3/$STRAIN.allheaders.txt
       sed -i -r 's/^/>/g' $DIR3/$STRAIN.nod_headers.txt
done

#change header names
for STRAIN in $STRAINS;do
        REPLACE=$(awk 'FNR==NR{  a[">"$1]=$2;next}$1 in a{  sub(/>/,">"a[$1]"|",$1)}1' $DIR3/$STRAIN.allheaders.txt $DIR3/$STRAIN.nod_genes.faa)
        echo $REPLACE | tr " " "\n" > $DIR3/$STRAIN.nod.faa
done
