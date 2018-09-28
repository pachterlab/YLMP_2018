#!/bin/bash

cd ~/reads/human/
for i in SRR3191542 SRR3191543 SRR3191544 SRR3191545 SRR4045930 SRR4045931 ; do
	echo "${i} running"
	~/thing/bin/thing -g ~/human/Homo_sapiens.GRCh38.92.chr.gtf -S ${i}/HISAT2/HISAT2.bam -o ${i}/HISAT2/matrix -t ~/human/transcriptome_from_gtf.fa -e ~/human/kallisto.idx.ec -p 20
	/home/lynnyi/kallisto_del/kallisto/build/src/kallisto pseudoquant -i ~/human/human_gtf.idx -d ${i}/HISAT2 -o ${i}/HISAT2 -t 20 -l 187 -s 70
	~/thing/bin/thing -g ~/human/Homo_sapiens.GRCh38.92.chr.gtf -S ${i}/STAR/STAR.bam -o ${i}/STAR/matrix -t ~/human/transcriptome_from_gtf.fa -e ~/human/kallisto.idx.ec -p 20
	/home/lynnyi/kallisto_del/kallisto/build/src/kallisto pseudoquant -i ~/human/human_gtf.idx -d ${i}/STAR -o ${i}/STAR -t 20 -l 187 -s 70
done
