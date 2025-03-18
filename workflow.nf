// I didnt manage to get the normal ganon build process to work so I instead did it with custom build
// -> For our project we should probably use the normal build process
// link: https://pirovc.github.io/ganon/default_databases/ 

process build_database {
    storeDir "database"
    container "https://depot.galaxyproject.org/singularity/ganon:2.1.0--py39ha35b9be_0"

    output:
    path "ecoli_db.*"

    input:
    path database_input_file

    script:
    """
    ganon build-custom --input $database_input_file --db-prefix ecoli_db    
    """
}       

// The classify process is used to classify sequences against a database
process classify {
    storeDir "output"
    container "https://depot.galaxyproject.org/singularity/ganon:2.1.0--py39ha35b9be_0"

    input:
    path test_sequence_file
    path database

    output:
    path "classification_output.*"

    script:
    """
    ganon classify --db-prefix ecoli_db --single-reads $test_sequence_file --output-prefix classification_output
    """
}


workflow {
    // Input files
    test_sequence_file = file("input/test_sequence_file.fastq")
    database_input_file = file("input/GCA_000005845.2_ASM584v2_genomic.fna")

    // processes
    database = build_database(database_input_file) 
    classify(test_sequence_file, database) 
}