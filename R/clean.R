show_rows_with_missing_value <- function(df) {
    df[!complete.cases(df), ]
}
