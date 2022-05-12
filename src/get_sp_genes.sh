#!/usr/bin/bash
#Get genes to phylogeny species

#Create directory
mkdir -p analysis/sp_genes

#Create file with gene names 
touch analysis/sp_genes/genes.txt
echo -e atpD"\n"dnaK"\n"glnII"\n"gyrB"\n"rpoB > analysis/sp_genes/genes.txt

#Create directory path variables
DIR1="analysis/03.EggNogg"
DIR2="analysis/03.RASTtk/faa"
DIR3="analysis/sp_genes"

#Create strain name variable
STRAINS=$(ls $DIR1/*.tsv | sed 's/^.*.\///' | sed 's/\..*$//')

#cut -f1,9 analysis/03.EggNogg/14-inga.emapper.annotations.tsv

#Get headers of interest genes
for STRAIN in $STRAINS; do
       for NAME in $(cat $DIR3/genes.txt);do
               GENES=$(grep -v '##' $DIR1/$STRAIN.emapper.annotations.tsv | cut -f1,9 | grep $NAME)
               GENES=$(echo $GENES | tr ' ' '\t'  >> $DIR3/$STRAIN.gene_headers.txt)
               echo $GENES
       done
done

#Get  gene sequences
for STRAIN in $STRAINS; do
       HEADER=$(cut -f1 $DIR3/$STRAIN.gene_headers.txt > $DIR3/$STRAIN.only_gene_headers.txt)
       GENE_SEQ='seqtk-trinity subseq '$DIR2'/'$STRAIN'.faa  '$DIR3'/'$STRAIN'.only_gene_headers.txt > '$DIR3'/'$STRAIN'.sp_genes.faa'
       GENE_SEQrun=$(seqtk-trinity subseq $DIR2/$STRAIN'.faa'  $DIR3/$STRAIN'.only_gene_headers.txt' > $DIR3/$STRAIN'.sp_genes.faa')
       echo -e $GENE_SEQ"\n"$GENE_SEQrun
done

#change header names
for STRAIN in $STRAINS;do
        REPLACE=$(awk 'FNR==NR{  a[">"$1]=$2;next}$1 in a{  sub(/>/,">"a[$1]"|",$1)}1' $DIR3/$STRAIN.gene_headers.txt $DIR3/$STRAIN.sp_genes.faa)
        echo $REPLACE | tr " " "\n" > $DIR3/$STRAIN.sp_genes_name.faa
done

#Move new files into specific directory
mkdir -p $DIR3/sp_names_faa
mv $DIR3/*_name.faa $DIR3/sp_names_faa
