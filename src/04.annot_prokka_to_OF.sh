##Run to new genomes to add OF results
#DianaOaxaca
#290422

#create output directory
mkdir -p analysis/04.Orthofinder/prokka2/

#rename extension files
for i in $(ls); do o=$(echo $i | sed 's/.fna/.fasta/g'); mv $i $o ; done

##Run prokka loop
INPUT=$(ls analysis/04.Orthofinder/fna2/*.fasta)
declare -a FILES=("$INPUT")

for FASTA in ${FILES[@]}; do
        OUT=$FASTA.prokka
        OUT_FILE=$(echo $OUT | sed 's/^.*\///g' | sed 's/.fasta//g')
        LOCUSTAG=$(echo $OUT_FILE | sed 's/.prokka//g')
        PROKKA='prokka --locustag '$LOCUSTAG' --prefix '$LOCUSTAG' --addgenes --kingdom Bacteria --genus Bradyrhizobium --usegenus --cpus 40  '$FASTA' --outdir analysis/04.Orthofinder/prokka2/'$OUT_FILE
        PROKKArun=$(prokka --locustag $LOCUSTAG --prefix $LOCUSTAG --addgenes  --kingdom Bacteria --genus Bradyrhizobium --usegenus --cpus 40 $FASTA --outdir analysis/04.Orthofinder/prokka/$OUT_FILE)
        echo -e $PROKKA"\n"$PROKKArun
done
