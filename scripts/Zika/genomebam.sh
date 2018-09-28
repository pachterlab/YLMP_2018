#!/bin/bash
cd ~/reads/human
for dataset in SRR3191542 ; do
	mkdir ${dataset}/quant
	kallisto quant -i ~/human/human_gtf.idx -o ${dataset}/quant -t 20 -l 187 -s 70 --genomebam --gtf ~/human/Homo_sapiens.GRCh38.92.chr.gtf ${dataset}/${dataset}_1.fastq ${dataset}/${dataset}_2.fastq
	mv ${dataset}/quant/abundance.tsv ${dataset}/quant/abundance_quant.original.tsv
	mv ${dataset}/quant/abundance.h5 ${dataset}/quant/abundance_quant.original.h5
	mv ${dataset}/quant/pseudoalignments.bam.bai ${dataset}/quant/quant.bam.bai
	mv ${dataset}/quant/pseudoalignments.bam ${dataset}/quant.bam
	~/bam2tcc/build/src/bam2tcc -g ~/human/Homo_sapiens.GRCh38.92.chr.gtf -S ${dataset}/quant.bam -o ${dataset}/quant/matrix -p 20 -t ~/human/transcriptome_from_gtf.fa -e ~/human/kallisto.idx.ec -k
	/home/lynnyi/kallisto_del/kallisto/build/src/kallisto pseudoquant -i ~/human/human_gtf.idx -d ${dataset}/quant -o ${dataset}/quant ~/human/human_gtf.idx -t 20 -l 187 -s 70
done
