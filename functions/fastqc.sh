#!/bin/bash -l


dir=$1
name=$2

cd "$dir"

fastqc *fastq.gz

