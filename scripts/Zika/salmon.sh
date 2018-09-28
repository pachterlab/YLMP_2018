#!/bin/bash
cd ~/reads/human
for dataset in SRR3191542 SRR3191543 SRR3191544 SRR3191545 ; do
	echo "${dataset} running..."
	~/salmon-0.8.2_linux_x86_64/bin/salmon quant -i ~/human/salmon_0.8.2_idx.rel92.31/ -l IU -1 ${dataset}/${dataset}_1.fastq -2 ${dataset}/${dataset}_2.fastq -o ${dataset}/Salmon_0.8.2 --dumpEq
	~/llconv/build/src/debug -t ${dataset}/Salmon_0.8.2/aux_info/eq_classes.txt ${dataset}/Salmon_0.8.2/matrix ~/human/transcriptome_from_gtf.fa ~/human/kallisto.idx.ec
	echo "Salmon_0.8.2" > ${dataset}/Salmon_0.8.2/matrix.cells
	/home/lynnyi/kallisto_del/kallisto/build/src/kallisto pseudoquant -d ${dataset}/Salmon_0.8.2 -o ${dataset}/Salmon_0.8.2 -i ~/human/human_gtf.idx -t 20 -l 187 -s 70
done
