library(optparse)
option_list <- list( 
  make_option(c("-p", "--path"), action="store", default='.',
              help="Absolute path of the file of the faq(ex. ~/cloud/text_import.csv)
                    Admitted extension csv - tsv - parquet
                    [default %default]")
)
input <- parse_args(OptionParser(option_list=option_list))

path <- input$path 

if(!file.exists(path)){
  stop("
       ██████  ██████  ███████ 
      ██    ██ ██   ██ ██      
      ██    ██ ██████  ███████ 
      ██    ██ ██           ██ 
       ██████  ██      ███████ 
Need to pass the path of an existing file")
  }

extension<-tools::file_ext(path)

if (extension %in% c('csv','tsv')){
  df<-data.table::fread(path)
  nrow<-nrow(df)
  ncol<-ncol(df)
}else if (extension == 'parquet'){
  df<-arrow::read_parquet(path)
  nrow<-nrow(df)
  ncol<-ncol(df)
}else{
  stop("
             ██████  ██████  ███████ 
            ██    ██ ██   ██ ██      
            ██    ██ ██████  ███████ 
            ██    ██ ██           ██ 
             ██████  ██      ███████ 
Need to pass the path of a file csv, tsv or parquet")
}

cat('Numero di righe: ',nrow,'\nNumero di colonne: ',ncol,'\n')


