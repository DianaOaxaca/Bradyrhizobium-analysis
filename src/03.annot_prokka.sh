#/bin/bash
#DianaOaxaca 170422
#This script execute prokka anotation from fna directory files

INPUT=$(ls analysis/02.genomes/*.fasta)
declare -a FILES=("$INPUT")

for FASTA in ${FILES[@]}; do
        OUT=$FASTA.prokka
        OUT_FILE=$(echo $OUT | sed 's/^.*\///g' | sed 's/_.*$//g')
        LOCUSTAG=$(echo $OUT_FILE | sed 's/.prokka//g')
#        echo -e $FASTA"\n"$OUT_FILE"\n"$LOCUSTAG
        PROKKA='prokka --locustag '$LOCUSTAG'  --kingdom Bacteria --genus Bradyrhizobium --usegenus --cpus 40  '$FASTA' --outdir analysis/03.prokka/'$OUT_FILE
        PROKKArun=$(prokka --locustag $LOCUSTAG  --kingdom Bacteria --genus Bradyrhizobium --usegenus --cpus 40 $FASTA --outdir analysis/03.prokka/$OUT_FILE)
        echo -e $PROKKA"\n"$PROKKArun
done
