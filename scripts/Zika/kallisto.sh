#!/bin/bash

cd ~/reads/human
for i in SRR3191542  ; do
	mkdir ${i}/kallisto
	rm ${i}/kallisto/*
	kallisto pseudo -i ~/human/human_gtf.idx -o ${i}/kallisto -t 20 -l 187 -s 70 ${i}/${i}_1.fastq ${i}/${i}_2.fastq
	mv ${i}/kallisto/pseudoalignments.tsv ${i}/kallisto/matrix.full.tsv
	mv ${i}/kallisto/pseudoalignments.ec ${i}/kallisto/matrix.ec
	~/bam2tcc/build/src/debug -x ${i}/kallisto/matrix.full.tsv ${i}/kallisto/matrix.tsv
	echo "kallisto" > ${i}/kallisto/matrix.cells
	/home/lynnyi/kallisto_del/kallisto/build/src/kallisto pseudoquant -i ~/human/human_gtf.idx -o ${i}/kallisto -d ${i}/kallisto -t 20 -l 187 -s 70
done
