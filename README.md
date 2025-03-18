# Sequence Classification using Ganon

## Overview
This project demonstrates sequence classification using [Ganon](https://pirovc.github.io/ganon/). While E. coli is used as an example, the methodology can be applied to other organisms as well. This code is part of a larger project set to be released soon, but this specific implementation was developed independently.

## Setup
Ensure you have Ganon installed. Follow the official [installation guide](https://pirovc.github.io/ganon/installation/) if needed.

## Workflow

### 1. Build Database
Instead of manually downloading genome files (as done in the beginning), we use `ganon build` to construct the database.

```sh
 ganon build --db-prefix example_db --taxonomy-source ncbi --organism "Escherichia coli"
```

#### Parameters:
- `--db-prefix example_db`: Defines the database name.
- `--taxonomy-source ncbi`: Pulls taxonomy from NCBI.
- `--organism "Escherichia coli"`: Specifies the organism (modifiable for other species).

For more details, refer to the [Ganon database documentation](https://pirovc.github.io/ganon/default_databases/).

### 2. Prepare Test Sequence File
- The test sequence file should be in FASTQ format.
- It is generated within the pipeline using a Ground Truth Generator, here the file was manually created as an example.

### 3. Classify Sequences
Run the following command to classify a test sequence file:

```sh
 ganon classify --db-prefix example_db --single-reads $test_sequence_file --output-prefix classification_output
```

#### Parameters:
- `--db-prefix example_db`: References the built database.
- `--single-reads $test_sequence_file`: Specifies the input file.
- `--output-prefix classification_output`: Defines output filenames.

### 4. Result Output
After classification, two files are generated:
- `classification_output.rep`: Contains metadata (e.g., number of classified sequences).
- `classification_output.tre`: Stores the phylogenetic tree.

### 5. Reports
Additional reports can be generated using Ganon:

```sh
 ganon report --db-prefix example_db --input-file classification_output.rep --output report_output
```

For details on report types, check the [Ganon reports documentation](https://pirovc.github.io/ganon/reports/).
In our case, we only needed the phylogenetic tree, so reports weren't neccessary.

### 6. Additional
This code was developed as part of a larger project aimed at evaluating the accuracy of commonly used classification tools. The full project, including a scientific paper intended for journal publication, is scheduled for release in the coming months.

To facilitate independent testing outside the broader pipeline, input files were manually created, and the database was limited to E. coli as a proof of concept. The code has since been integrated into the main pipeline, where it operates as expected within a larger, automated framework.

## License
This project is open-source. See `LICENSE` for details.



