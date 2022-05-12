#!/usr/bin/bash
#DianaOaxaca 080422
#This script was done to plasmid mapping in order to separate chromosome of plasmid 

STRAINS=$(ls data/plasmid/query/ | sed 's/-plasm.fasta//')
ALLREADS="data/plasmid/full"
QUERY="data/plasmid/query"
FLTREADS="data/plasmid/filter"

for STRAIN in $STRAINS; do
        #Plasmid reference index
       BW2build='bowtie2-build '$QUERY'/'$STRAIN'-plasm.fasta '$FLTREADS'/'$STRAIN'-plasm.fasta --threads 30'
       BW2buildrun=$(bowtie2-build $QUERY/$STRAIN'-plasm.fasta' $FLTREADS/$STRAIN'-plasm.fasta' --threads 30)
        #Map reads to plasmid reference
       BW2map='bowtie2 -x '$FLTREADS'/'$STRAIN'-plasm.fasta -1 '$ALLREADS'/'$STRAIN'_R1_val_1.fq -2 '$ALLREADS'/'$STRAIN'_R2_val_2.fq -p 24 -S '$FLTREADS'/'$STRAIN'-plasm.sam'
       BW2maprun=$(bowtie2 -x $FLTREADS/$STRAIN'-plasm.fasta' -1 $ALLREADS/$STRAIN'_R1_val_1.fq' -2 $ALLREADS/$STRAIN'_R2_val_2.fq' -p 24 -S $FLTREADS/$STRAIN'-plasm.sam')
        #Get stats
       SAMstats='samtools stats '$FLTREADS'/'$STRAIN'-plasm.sam '$FLTREADS'/'$STRAIN'-plasm.stats'
       SAMstatsrun=$(samtools stats $FLTREADS/$STRAIN'-plasm.sam' $FLTREADS/$STRAIN'-plasm.stats')
        #Convert sam to bam files
       BAM='samtools view -bS '$FLTREADS'/'$STRAIN'-plasm.sam > '$FLTREADS'/'$STRAIN'-plasm.bam'
       BAMrun=$(samtools view -bS $FLTREADS/$STRAIN'-plasm.sam' > $FLTREADS/$STRAIN'-plasm.bam')
        #Extract unmapped reads
       UNMAP='samtools view -b -f 12 -F 256 '$FLTREADS'/'$STRAIN'-plasm.bam -@ 24 -o '$FLTREADS'/'$STRAIN'.unmapped.bam'
       UNMAPrun=$(samtools view -b -f 12 -F 256 $FLTREADS/$STRAIN'-plasm.bam' -@ 24 -o $FLTREADS/$STRAIN'.unmapped.bam')
        #Sort bam files to obtain paired end reads
       SORT='samtools sort -n '$FLTREADS'/'$STRAIN'.unmapped.bam -@24 -o '$FLTREADS'/'$STRAIN'.unmapped.sorted.bam'
       SORTrun=$(samtools sort -n $FLTREADS/$STRAIN'.unmapped.bam' -@24 -o $FLTREADS/$STRAIN'.unmapped.sorted.bam')
        #Separate fordware and reverse reads
       READS='bedtools bamtofastq -i '$FLTREADS'/'$STRAIN'.unmapped.sorted.bam -fq '$FLTREADS'/'$STRAIN'_fltrplasm_1.fastq -fq2 '$FLTREADS'/'$STRAIN'_fltrplasm_2.fastq'
       READSrun=$(bedtools bamtofastq -i $FLTREADS/$STRAIN'.unmapped.sorted.bam' -fq $FLTREADS/$STRAIN'_fltrplasm_1.fastq' -fq2 $FLTREADS/$STRAIN'_fltrplasm_2.fastq')
        #Extract mapped reads
       MAP='samtools view -b -F 4 '$FLTREADS'/'$STRAIN'-plasm.bam -@ 24 -o '$FLTREADS'/'$STRAIN'.mapped.bam'
       MAPrun=$(samtools view -b  -F 4 $FLTREADS/$STRAIN'-plasm.bam' -@ 24 -o $FLTREADS/$STRAIN'.mapped.bam')
        #Sort bam files to obtain paired end reads
       SORT2='samtools sort -n '$FLTREADS'/'$STRAIN'.mapped.bam -@24 -o '$FLTREADS'/'$STRAIN'.mapped.sorted.bam'
       SORT2run=$(samtools sort -n $FLTREADS/$STRAIN'.mapped.bam' -@24 -o $FLTREADS/$STRAIN'.mapped.sorted.bam')
        #Separate fordware and reverse reads
       READS_MAP='bedtools bamtofastq -i '$FLTREADS'/'$STRAIN'.mapped.sorted.bam -fq '$FLTREADS'/'$STRAIN'_fltrchr_1.fastq -fq2 '$FLTREADS'/'$STRAIN'_fltrchr_2.fastq'
       READS_MAPrun=$(bedtools bamtofastq -i $FLTREADS/$STRAIN'.mapped.sorted.bam' -fq $FLTREADS/$STRAIN'_fltrchr_1.fastq' -fq2 $FLTREADS/$STRAIN'_fltrchr_2.fastq')
       echo -e $BW2build"\n"$BW2buildrun"\n"$BW2map"\n"$BW2maprun"\n"$SAMstats"\n"$SAMstatsrun"\n"$BAM"\n"$BAMrun"\n"$UNMAP"\n"$UNMAPrun"\n"$SORT"\n"$SORTrun"\n"$READS"\n"$READSrun"\n"$MAP"\n"$MAPrun"\n"$SORT2"\n"$SORT2run"\n"$READS_MAP"\n"$READS_MAPrun

done

#Map to minion reads
minimap2 -ax map-ont data/plasmid/query/23-inga-plasm.fasta data/minion/23-inga_pc.fastq | samtools sort -@40 -O BAM -o data/plasmid/filter/23-inga_plasmvsont.bam

#Get map reads, so ont plasmid reads
samtools view -b  -F 4 data/plasmid/filter/23-inga_plasmvsont.bam -@ 40 -o data/plasmid/filter/23-inga_plasmid_minion_reads.bam
bedtools bamtofastq -i data/plasmid/filter/23-inga_plasmid_minion_reads.bam -fq data/plasmid/filter/23-inga_plasmid_minion_reads.fastq

#Get unmap reads, so ont chr reads
samtools view -b  -f 4 data/plasmid/filter/23-inga_plasmvsont.bam -@ 40 -o data/plasmid/filter/23-inga_chromosome_minion.bam
bedtools bamtofastq -i data/plasmid/filter/23-inga_chromosome_minion.bam -fq data/plasmid/filter/23-inga_chromosome_minion_reads.fastq
