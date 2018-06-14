# Generated by precisionFDA exporter (v1.0.3) on 2018-06-14 05:46:41 +0000
# The asset download links in this file are valid only for 24h.

# Exported app: varsim-art-clinvar-simulation, revision: 1, authored by: george.asimenos
# https://precision.fda.gov/apps/app-BkKYgQQ0xQ9BPQXG44xqBZGx

# For more information please consult the app export section in the precisionFDA docs

# Start with Ubuntu 14.04 base image
FROM ubuntu:14.04

# Install default precisionFDA Ubuntu packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
	aria2 \
	byobu \
	cmake \
	cpanminus \
	curl \
	dstat \
	g++ \
	git \
	htop \
	libboost-all-dev \
	libcurl4-openssl-dev \
	libncurses5-dev \
	make \
	perl \
	pypy \
	python-dev \
	python-pip \
	r-base \
	ruby1.9.3 \
	wget \
	xz-utils

# Install default precisionFDA python packages
RUN pip install \
	requests==2.5.0 \
	futures==2.2.0 \
	setuptools==10.2

# Add DNAnexus repo to apt-get
RUN /bin/bash -c "echo 'deb http://dnanexus-apt-prod.s3.amazonaws.com/ubuntu trusty/amd64/' > /etc/apt/sources.list.d/dnanexus.list"
RUN /bin/bash -c "echo 'deb http://dnanexus-apt-prod.s3.amazonaws.com/ubuntu trusty/all/' >> /etc/apt/sources.list.d/dnanexus.list"
RUN curl https://wiki.dnanexus.com/images/files/ubuntu-signing-key.gpg | apt-key add -

# Install app-specific Ubuntu packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
	openjdk-7-jre-headless

# Download app assets
RUN curl https://dl.dnanex.us/F/D/7956yFJpfQ491FFxJZbB66ZZ19Z7k8g8PG6q0xjj/clinvar-grch37-20151102.tar | tar xf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/983zPzgxjkB3zjybGJY0XQgX9YG1xG4B1Fbkg9q0/grch37-fasta.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/f48Zgf2Zfb6X9BP9g1PjvQ5yZz8YkY0VVz3vjyKF/art-chocolatecherrycake.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/V8kPV3jg5kq12KKKZkgv4KXJ0bjx8F1b3b93yb49/htslib-1.2.1.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/f2GK13JQ42JZ0gfvGvQgVFqYqqGpQFGgPVzggqp1/varsim-0.5.2.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions

# Download helper executables
RUN curl https://dl.dnanex.us/F/D/0K8P4zZvjq9vQ6qV0b6QqY1z2zvfZ0QKQP4gjBXp/emit-1.0.tar.gz | tar xzf - -C /usr/bin/ --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/bByKQvv1F7BFP3xXPgYXZPZjkXj9V684VPz8gb7p/run-1.2.tar.gz | tar xzf - -C /usr/bin/ --no-same-owner --no-same-permissions

# Write app spec and code to root folder
RUN ["/bin/bash","-c","echo -E \\{\\\"spec\\\":\\{\\\"input_spec\\\":\\[\\{\\\"name\\\":\\\"number_of_snvs\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Number\\ of\\ SNVs\\\",\\\"help\\\":\\\"The\\ number\\ of\\ SNVs\\ to\\ sample\\ from\\ ClinVar.\\\",\\\"default\\\":100\\},\\{\\\"name\\\":\\\"coverage\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Coverage\\\",\\\"help\\\":\\\"The\\ fold\\ coverage\\ level\\ to\\ simulate.\\\",\\\"default\\\":10\\},\\{\\\"name\\\":\\\"read_length\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Read\\ length\\\",\\\"help\\\":\\\"The\\ length\\ of\\ each\\ simulated\\ read.\\\",\\\"default\\\":150\\},\\{\\\"name\\\":\\\"sequencing_system\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Sequencing\\ system\\\",\\\"help\\\":\\\"The\\ sequencing\\ system\\ to\\ simulate.\\\",\\\"default\\\":\\\"HiSeq\\ 2500\\\",\\\"choices\\\":\\[\\\"Genome\\ Analyzer\\ I\\\",\\\"Genome\\ Analyzer\\ II\\\",\\\"HiSeq\\ 1000\\\",\\\"HiSeq\\ 2000\\\",\\\"HiSeq\\ 2500\\\",\\\"MiSeq\\\"\\]\\},\\{\\\"name\\\":\\\"mean_fragment_size\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Mean\\ fragment\\ size\\\",\\\"help\\\":\\\"The\\ mean\\ size\\ of\\ the\\ simulated\\ sequenced\\ DNA\\ fragments.\\ That\\ is,\\ this\\ is\\ the\\ distance\\ between\\ the\\ outer\\ edges\\ of\\ each\\ read.\\\",\\\"default\\\":500\\},\\{\\\"name\\\":\\\"stddev_fragment_size\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Standard\\ deviation\\ of\\ fragments\\ size\\\",\\\"help\\\":\\\"The\\ standard\\ deviation\\ of\\ simulated\\ DNA\\ fragment\\ sizes.\\\",\\\"default\\\":50\\},\\{\\\"name\\\":\\\"output_name\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Output\\ name\\\",\\\"help\\\":\\\"A\\ name\\ after\\ which\\ the\\ output\\ files\\ will\\ be\\ called\\ \\(name_1.fastq.gz,\\ name.vcf.gz,\\ etc.\\)\\\"\\}\\],\\\"output_spec\\\":\\[\\{\\\"name\\\":\\\"simulated_reads\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Simulated\\ FASTQ\\ first\\ mates\\\",\\\"help\\\":\\\"The\\ gzipped\\ FASTQ\\ containing\\ the\\ first\\ mates.\\\"\\},\\{\\\"name\\\":\\\"simulated_reads2\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Simulated\\ FASTQ\\ second\\ mates\\\",\\\"help\\\":\\\"The\\ gzipped\\ FASTQ\\ containing\\ the\\ second\\ mates.\\\"\\},\\{\\\"name\\\":\\\"truth_vcfgz\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Simulated\\ variants\\\",\\\"help\\\":\\\"A\\ bgzipped\\ VCF\\ file\\ containing\\ the\\ simulated\\ variants.\\\"\\},\\{\\\"name\\\":\\\"truth_tbi\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Simulated\\ variants\\ index\\\",\\\"help\\\":\\\"The\\ associated\\ TBI\\ file\\ for\\ the\\ simulated\\ variants.\\\"\\}\\],\\\"internet_access\\\":false,\\\"instance_type\\\":\\\"baseline-32\\\"\\},\\\"assets\\\":\\[\\\"file-BkKXx4Q0qVb5kJxP20xQ71BZ\\\",\\\"file-Bk5xvzQ0qVb5k0VYzZQG7BXJ\\\",\\\"file-BkKXJy00qVb121BVxJg3qBYy\\\",\\\"file-Bk5K5zQ0qVb7ZjyyzjpB4F9g\\\",\\\"file-BkKXP3j0qVb7XvYGyj7BPFp6\\\"\\],\\\"packages\\\":\\[\\\"openjdk-7-jre-headless\\\"\\]\\} \u003e /spec.json"]
RUN ["/bin/bash","-c","echo -E \\{\\\"code\\\":\\\"case\\ \\\\\\\"\\$sequencing_system\\\\\\\"\\ in\\\\n\\ \\ \\ \\ \\\\\\\"Genome\\ Analyzer\\ I\\\\\\\"\\)\\\\n\\ \\ \\ \\ \\ \\ \\ \\ art_ss\\+\\=\\\\\\\"GA1\\\\\\\"\\\\n\\ \\ \\ \\ \\ \\ \\ \\ \\;\\;\\\\n\\ \\ \\ \\ \\\\\\\"Genome\\ Analyzer\\ II\\\\\\\"\\)\\\\n\\ \\ \\ \\ \\ \\ \\ \\ art_ss\\+\\=\\\\\\\"GA2\\\\\\\"\\\\n\\ \\ \\ \\ \\ \\ \\ \\ \\;\\;\\\\n\\ \\ \\ \\ \\\\\\\"HiSeq\\ 1000\\\\\\\"\\)\\\\n\\ \\ \\ \\ \\ \\ \\ \\ art_ss\\+\\=\\\\\\\"HS10\\\\\\\"\\\\n\\ \\ \\ \\ \\ \\ \\ \\ \\;\\;\\\\n\\ \\ \\ \\ \\\\\\\"HiSeq\\ 2000\\\\\\\"\\)\\\\n\\ \\ \\ \\ \\ \\ \\ \\ art_ss\\+\\=\\\\\\\"HS20\\\\\\\"\\\\n\\ \\ \\ \\ \\ \\ \\ \\ \\;\\;\\\\n\\ \\ \\ \\ \\\\\\\"HiSeq\\ 2500\\\\\\\"\\)\\\\n\\ \\ \\ \\ \\ \\ \\ \\ art_ss\\+\\=\\\\\\\"HS25\\\\\\\"\\\\n\\ \\ \\ \\ \\ \\ \\ \\ \\;\\;\\\\n\\ \\ \\ \\ \\\\\\\"MiSeq\\\\\\\"\\)\\\\n\\ \\ \\ \\ \\ \\ \\ \\ art_ss\\+\\=\\\\\\\"MS\\\\\\\"\\\\nesac\\\\n\\\\nvarsim.py\\ \\\\\\\\\\\\n\\ \\ \\ \\ --reference\\ grch37.fa\\ \\\\\\\\\\\\n\\ \\ \\ \\ --read_length\\ \\\\\\\"\\$read_length\\\\\\\"\\ \\\\\\\\\\\\n\\ \\ \\ \\ --total_coverage\\ \\\\\\\"\\$coverage\\\\\\\"\\ \\\\\\\\\\\\n\\ \\ \\ \\ --mean_fragment_size\\ \\\\\\\"\\$mean_fragment_size\\\\\\\"\\ \\\\\\\\\\\\n\\ \\ \\ \\ --sd_fragment_size\\ \\\\\\\"\\$stddev_fragment_size\\\\\\\"\\ \\\\\\\\\\\\n\\ \\ \\ \\ --vc_in_vcf\\ clinvar_20151102.vcf.gz\\ \\\\\\\\\\\\n\\ \\ \\ \\ --simulator\\ art\\ \\\\\\\\\\\\n\\ \\ \\ \\ --simulator_executable\\ /opt/art/art_illumina\\ \\\\\\\\\\\\n\\ \\ \\ \\ --art_options\\ \\\\\\\"--seqSys\\ \\$art_ss\\\\\\\"\\ \\\\\\\\\\\\n\\ \\ \\ \\ --id\\ simulated_reads\\ \\\\\\\\\\\\n\\ \\ \\ \\ --disable_rand_dgv\\ \\\\\\\\\\\\n\\ \\ \\ \\ --vc_num_snp\\ \\\\\\\"\\$number_of_snvs\\\\\\\"\\ \\\\\\\\\\\\n\\ \\ \\ \\ --out_dir\\ varsim_out\\\\n\\ \\ \\ \\ \\\\ncat\\ varsim_out/\\*1.fq.gz\\ \\\\u003e\\ \\\\\\\"\\$output_name\\\\\\\"_1.fastq.gz\\\\nemit\\ simulated_reads\\ \\\\\\\"\\$output_name\\\\\\\"_1.fastq.gz\\\\nrm\\ -f\\ \\\\\\\"\\$output_name\\\\\\\"_1.fastq.gz\\\\n\\\\ncat\\ varsim_out/\\*2.fq.gz\\ \\\\u003e\\ \\\\\\\"\\$output_name\\\\\\\"_2.fastq.gz\\\\nemit\\ simulated_reads2\\ \\\\\\\"\\$output_name\\\\\\\"_2.fastq.gz\\\\nrm\\ -f\\ \\\\\\\"\\$output_name\\\\\\\"_2.fastq.gz\\\\n\\\\nbgzip\\ -c\\ varsim_out/simulated_reads.truth.vcf\\ \\\\u003e\\ \\\\\\\"\\$output_name\\\\\\\".truth.vcf.gz\\\\nemit\\ truth_vcfgz\\ \\\\\\\"\\$output_name\\\\\\\".truth.vcf.gz\\\\n\\\\ntabix\\ -p\\ vcf\\ \\\\\\\"\\$output_name\\\\\\\".truth.vcf.gz\\\\nemit\\ truth_tbi\\ \\\\\\\"\\$output_name\\\\\\\".truth.vcf.gz.tbi\\\\n\\\"\\} | python -c 'import sys,json; print json.load(sys.stdin)[\"code\"]' \u003e /script.sh"]

# Create directory /work and set it to $HOME and CWD
RUN mkdir -p /work
ENV HOME="/work"
WORKDIR /work

# Set entry point to container
ENTRYPOINT ["/usr/bin/run"]

VOLUME /data
VOLUME /work