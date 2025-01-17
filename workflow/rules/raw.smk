rule join_and_annotate:
    input: unpack(get_annot_input)
    output:
        annot_tsv = config["datadir"]+"/{tissue}/results/{tissue}-annotation.tsv",
        annot_rdata = config["datadir"]+"/{tissue}/rdata/annot.RData",
        raw_rdata=config["datadir"]+"/{tissue}/rdata/raw_full_unfiltered.RData"
    log:
        config['datadir']+"/{tissue}/log/join_annotate.log"
    params:
        tissue_dir=get_tissue_dir,
        is_xena=is_xena_tissue
    script:
        "../scripts/addAnnotations.R"

rule get_raw_matrix:
    input: get_raw_matrix_input
    output: 
        matrix = config["datadir"]+"/{tissue}/results/{tissue}-{type}-matrix.tsv",
        samples = config["datadir"]+"/{tissue}/results/{tissue}-{type}-samples.tsv",
    params:
        tissue_dir=get_tissue_dir,
        tissue=get_tissue_name,
        type="{type}",
        is_xena=is_xena_tissue, 
        primary=get_xena_primary,
        extended_type=get_xena_extended_type
    threads: 3
    log:
        config['datadir']+"/{tissue}/log/raw_matrix_{type}.log"
    script:
            "../scripts/getRawMatrix.R"
   
