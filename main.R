##mwk


#' stackoverflow template
#'
#' @param what The question number or URL.
#' @param when The date/time. Defaults to Sys.time().
#' @return Saves Rmd template with meta information.
stackoverflow <- function(what, when = Sys.time()) {
    stopifnot(is.character(what))
    if (grepl("http", what)) {
        url <- what
    } else {
        url <- paste0("http://stackoverflow.com/questions/",
                      what)
    }
    txt <- c("## stack overflow question/answer",
             paste0("*URL*: [", url, "](", url, ")"),
             paste0("*Date*: ", when),
             "### QUESTION\n",
             "```{r}\n",
             "```")
    if (!dir.exists(file.path("..", "RMD"))) {
        file.create(file.path("..", "RMD"))
    }
    file <- file.path("RMD", paste0(what, when, ".Rmd")),
    cat(paste(txt, collapse = "\n"),
        fill = TRUE, file = file)
}
