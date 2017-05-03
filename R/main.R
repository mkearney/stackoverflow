##mwk


#' stackoverflow template
#'
#' @param qid The question number or URL.
#' @param topic Optional describing the topic of post.
#' @param when The date/time. Defaults to Sys.time().
#' @param live We'll do it live!
#' @param open Logical indicating whether to open the output.
#' @param RMD Path to RMD dir.
#' @return Saves Rmd template with meta information.
stackoverflow <- function(qid,
                          topic = NULL,
                          when = Sys.time(),
                          live = FALSE,
                          open = TRUE,
                          RMD = file.path("..", "RMD")) {
    stopifnot(is.character(qid))
    if (grepl("http", qid)) {
        url <- qid
    } else {
        url <- paste0("http://stackoverflow.com/questions/",
                      qid)
    }

    ## scrape
    r <- xml2::read_html(url)
    require(rvest)
    post_text <- r %>%
        html_nodes("div#question div.post-text p") %>%
        html_text("pre") %>%
        p_c()
    
    post_code <- r %>%
        html_nodes("div#question div.post-text pre code") %>%
        html_text() %>%
        p_c() %>%
        paste("```{r, eval = FALSE}\n", ., "```", sep = "\n")
    
    ## header
    pream <- paste("---",
                   "title: stack overflow",
                   "output: github_document",
                   "---",
                   sep = "\n")
    ## body
    txt <- paste(
        "\n", paste0("*URL*: [", url, "](", url, ")\n"),
        paste0("*Date*: ", when, "\n"),
        "### QUESTION\n\n",
        sep = "\n")

    if (!dir.exists(RMD)) {
        dir.create(RMD)
    }
    if (is.null(topic)) {
        topic <- strsplit(url, "\\/")[[1]][3]
    } else {
        topic <- gsub(" ", "-", topic)
    }
    date <- as.Date(when)
    file <- file.path(RMD, paste0(topic, ".Rmd"))

    ## fuck it we'll do it live!
    doitlive <- function() {
        con <- file("main.R")
        x <- readLines(con)
        close(con)
        n <- grep("^```", x)
        paste0(x[(n[1] + 1):(n[2] - 1)], "\n", collapse = "\n")
    }
    if (live) {
        answer <- doitlive()
    } else {
        answer <- ""
    }

    ## post
    post <- paste("### ANSWER\n",
                  "```{r}\n",
                  answer, 
                  "```", sep = "\n")

    ## combine
    txt <- paste(pream, txt, post_text, post_code, post,
                 sep = "\n")
    ## save
    cat(txt, fill = TRUE, file = file)    
    
    if (live) {
        rmarkdown::render(file)
        browseURL(gsub(".Rmd$", ".html", file))
        
    } else if (open) {
        browseURL(file, "emacs")
    } else {
        message("All done! File saved as: ", file)
    }
}


#' paste collapse
#'
#' @param x Vector to collapse into string
#' @return Scalar with appropriate number of line breaks
p_c <- function(x) {
        x[grep("\n$", x, invert = TRUE)] <- paste0(
            x[grep("\n$", x, invert = TRUE)], "\n")
        paste0(x, collapse = "")
}


```{r}
print("I SAID *** IT WE'LL DO IT LIVE. WE'LL DO IT LIVE!")
```


stackoverflow("43529972",
              topic = "set missing values for multiple labelled variables",
              live = TRUE)
