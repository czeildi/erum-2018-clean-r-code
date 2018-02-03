## Meta

- legyen főpróba a CEUn
- use packrat for development, but remove packrat from final workshop version
- make changes in parallel to two versions: one clean and not so clean

## Principles

- self contained results (do not depend on specific order to run), you can run the same piece twice
- all parameters are passed to function
- each "business" logic is defined at exactly one place
- könyvként olvasható
- egy függvényeket tartalmazó fájlban elején legfontosabb, segédfüggvények lentebb

------------------------------------------------------------------------------

## Abstract

### Detailed Outline

During the tutorial the participants will perform a guided data analysis task and make several refactoring steps as we progress. They will immediately experience the benefit of applying the shown techniques. The tutorial will cover launguage-agnostic and R-specific topics as well.

Some of the language-agnostic topics covered:

- extract code into functions
- organize code into files and folders
- organize functions within an R file
- how to choose variable and function names
- single responsibility principle
- what is a pure function

Some R-specific topics covered:

- how to extract some ggplot2 layers into functions
- how to create functions operating on different columns of a data frame
- parametrized rmarkdown documents
- useful RStudio keyboard shortcuts  

### Pre-requisites

Participants should be able to create simple R functions and use R for data analysis. We believe the tutorial is useful for beginners as well as for more experienced R programmers.

### Justification

Most R users do not have a formal background in software engineering, however, coding is a significant part of their job. We believe every R user can benefit from writing cleaner and simpler code which also makes it more reusable and less error-prone. Writing clean code also helps with reproducibility. Refactoring early and often makes the life of your future self and your collaborators as well as others wishing to understand your code easier.
