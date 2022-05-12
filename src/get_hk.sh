#DianaOaxaca
#030522
#Create directory
mkdir -p analysis/hkprokka

#Create file with gene names
touch analysis/hkprokka/genes.txt
echo -e rpoB"\n"gyrB"\n"glnII"\n"recA > analysis/hkprokka/genes.txt

#Create directory path variables
DIR1="analysis/prokka2"
DIR2="analysis/hkprokka"

STRAINS=$(ls $DIR1/ | sed 's/^.*.\///' | sed 's/\..*$//')
echo $STRAINS

for STRAIN in $STRAINS; do
        for NAME in $(cat $DIR2/genes.txt);do
                HK=$(grep -w CDS $DIR1/$STRAIN/$STRAIN.tsv | cut -f1,4 | grep $NAME | sort -u)
                HK=$(echo $HK | tr ' ' '\t' >> $DIR2/$STRAIN.gene_headers.txt)
                echo $GENES
        done
done

#Get  gene sequences
for STRAIN in $STRAINS; do
       HEADER=$(cut -f1 $DIR2/$STRAIN.gene_headers.txt > $DIR2/$STRAIN.only_gene_headers.txt)
       GENE_SEQ='seqtk-trinity subseq '$DIR1'/'$STRAIN'/'$STRAIN'.ffn  '$DIR2'/'$STRAIN'.only_gene_headers.txt > '$DIR2'/'$STRAIN'.hk_genes.fasta'
       GENE_SEQrun=$(seqtk-trinity subseq $DIR1/$STRAIN/$STRAIN'.ffn'  $DIR2/$STRAIN'.only_gene_headers.txt' > $DIR2/$STRAIN'.hk_genes.fasta')
       echo -e $GENE_SEQ"\n"$GENE_SEQrun
done
