rule download_sra_rnaseq:
    """
    Download the RNA seq raw data (fastq) from the SRA archive
    """
    output:
        "{wdir}/fastq/{sra}_1.fastq.gz",
        "{wdir}/fastq/{sra}_2.fastq.gz"
    conda:
        "../envs/download.yaml"
    shell:
        """
        mkdir --parents {wdir}/fastq
        fastq-dump {wildcards.sra} -v --split-files --gzip --outdir {wdir}/fastq/
        """


rule download_genome:
    """
    Download the genome from the NCBI genome assembly database
    """
    output:
        "{wdir}/genome/{genome}.fna",
        temp("{wdir}/genome/{genome}.zip"),
        "{wdir}/genome/{genome}_config.yaml",
        "{wdir}/genome/{genome}_assembly_data_report.jsonl",
        "{wdir}/genome/{genome}_sequence_report.jsonl"
    conda:
        "../envs/download.yaml"
    shell:
        """
        datasets download genome accession {genome} --filename {wdir}/genome/{genome}.zip --include genome,gff3,seq-report
	    unzip -o {wdir}/genome/{genome}.zip -d {wdir}/genome/
	    cp {wdir}/genome/ncbi_dataset/data/{genome}/*_genomic.fna {wdir}/genome/{genome}.fna
        if test -f {wdir}/genome/ncbi_dataset/data/{genome}/genomic.gff
        then
        echo "GFF annotation exists."
        cp {wdir}/genome/ncbi_dataset/data/{genome}/genomic.gff {wdir}/genome/{genome}.gff
        fi
	    cp {wdir}/genome/ncbi_dataset/data/assembly_data_report.jsonl {wdir}/genome/{genome}_assembly_data_report.jsonl
	    cp {wdir}/genome/ncbi_dataset/data/{genome}/sequence_report.jsonl {wdir}/genome/{genome}_sequence_report.jsonl
        cp config/config.yaml {wdir}/genome/{genome}_config.yaml
        """
