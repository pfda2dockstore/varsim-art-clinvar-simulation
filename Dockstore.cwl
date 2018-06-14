baseCommand: []
class: CommandLineTool
cwlVersion: v1.0
id: varsim-art-clinvar-simulation
inputs:
  coverage:
    default: 10
    doc: The fold coverage level to simulate.
    inputBinding:
      position: 2
      prefix: --coverage
    type: long
  mean_fragment_size:
    default: 500
    doc: The mean size of the simulated sequenced DNA fragments. That is, this is
      the distance between the outer edges of each read.
    inputBinding:
      position: 5
      prefix: --mean_fragment_size
    type: long
  number_of_snvs:
    default: 100
    doc: The number of SNVs to sample from ClinVar.
    inputBinding:
      position: 1
      prefix: --number_of_snvs
    type: long
  output_name:
    doc: A name after which the output files will be called (name_1.fastq.gz, name.vcf.gz,
      etc.)
    inputBinding:
      position: 7
      prefix: --output_name
    type: string
  read_length:
    default: 150
    doc: The length of each simulated read.
    inputBinding:
      position: 3
      prefix: --read_length
    type: long
  sequencing_system:
    default: HiSeq 2500
    doc: The sequencing system to simulate.
    inputBinding:
      position: 4
      prefix: --sequencing_system
    type: string
  stddev_fragment_size:
    default: 50
    doc: The standard deviation of simulated DNA fragment sizes.
    inputBinding:
      position: 6
      prefix: --stddev_fragment_size
    type: long
label: VarSim+ART | Simulate FASTQ files with ClinVar variants
outputs:
  simulated_reads:
    doc: The gzipped FASTQ containing the first mates.
    outputBinding:
      glob: simulated_reads/*
    type: File
  simulated_reads2:
    doc: The gzipped FASTQ containing the second mates.
    outputBinding:
      glob: simulated_reads2/*
    type: File
  truth_tbi:
    doc: The associated TBI file for the simulated variants.
    outputBinding:
      glob: truth_tbi/*
    type: File
  truth_vcfgz:
    doc: A bgzipped VCF file containing the simulated variants.
    outputBinding:
      glob: truth_vcfgz/*
    type: File
requirements:
- class: DockerRequirement
  dockerOutputDirectory: /data/out
  dockerPull: pfda2dockstore/varsim-art-clinvar-simulation:1
s:author:
  class: s:Person
  s:name: George Asimenos
