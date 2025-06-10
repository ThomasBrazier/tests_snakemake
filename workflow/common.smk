def get_mean_cov(summary_file):

    if not Path(summary_file).exists():
        return -1

    with open(summary_file, "r") as f:
        for line in f:
            if line.startswith("total"):
                sample_mean = float(line.split("\t")[3])

    return sample_mean


def get_sample_from_sra(wildcards):
    return samples["sample_name"].loc[samples["sra"] == wildcards.sra]

def get_fastq_r1_from_sample(wildcards):
    sra_list = samples["sra"].loc[samples["sample_name"] == wildcards.sample]
    fastq_r1 = [wildcards.wdir + "/fastq/" + f + "_1.fastq.gz" for f in sra_list]
    fastq_r1 = " ".join(fastq_r1)
    return fastq_r1

def get_fastq_r2_from_sample(wildcards):
    sra_list = samples["sra"].loc[samples["sample_name"] == wildcards.sample]
    fastq_r2 = [wildcards.wdir + "/fastq/" + f + "_2.fastq.gz" for f in sra_list]
    fastq_r2 = " ".join(fastq_r2)
    return fastq_r2


def get_fastq_from_sample(wildcards):
    sra_list = samples["sra"].loc[samples["sample_name"] == wildcards.sample]
    fastq_r1 = ["{wdir}/fastq/" + f + "_1.fastq.gz" for f in sra_list]
    fastq_r2 = ["{wdir}/fastq/" + f + "_2.fastq.gz" for f in sra_list]
    return fastq_r1 + fastq_r2