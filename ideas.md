structure:
- principles
- refactor
- used principles again

blocks:
- we describe task and look at naive code
- they refactor in pairs
- we perform the refactor and explain our decisions and used keyboard shorcuts as well

legyen parameterkent atadott fuggveny?

batoritsuk parmunkat

kiemelhetjuk, hogy package, production rendszer esetén más elvek (is) lesznek, pl input checking, error handling, unit testing etc

minden elvhez tartoznak smellek: altalaban könnyebb felismerni, ha valami nem jó, nem teljesít egy elvet, mint hogy minden tökéletes (ami amúgy is ritka)

## Principles

ezekbol keves slide, esetleg cheatsheet?

- single responsibility, do one thing: smell, ha kulonbozo szintu absztrakciok vannak
- nem kell 3x ismétlődés, hogy érdemes legyen valamit függvénybe kiemelni
- self contained results (do not depend on specific order to run) - you can run the same piece twice: do not reassign change result to same variable, it also supports being able to check intermediate variables
- all parameters are passed to function (or very explicitly labeled as global variable?)
- each "business" logic is defined at exactly one place
- könyvként olvasható, ha nem muszáj, nem vagy részletekkel terhelve
- egy függvényeket tartalmazó fájlban elején legfontosabb, segédfüggvények lentebb
- nem kell refaktorálást se túlzásba vinni, de boy scout rule, ha valamit amúgy is módosítasz, gondold át a refaltor lehetőségeket
- a kód magas szinten R-t nem ismerők számára is legyen érthető: pl dplyr::filter-t mondjuk nem kell függvénybe kiemelni, de egy apply(dt, 2, fun) azt már talán inkább
- explain in code better than comment
- eloszor mukodjon, utana refaktor
- egy fuggvenynek ne legyen sok parametere, egyutt mozgo parametereket be lehet közös listaba tenni
- named constants instead of magic numbers
- ne legyenek alig kulonbozo nevek, pl egyes szam, tobbes szam, input1, input2 stb
- clearly separate functions with side effects and function which return a value
- valtozo elnevezes data frame oszlopnevekre is vonatkozik!
- olyan neveket valasszunk, ami nem utkozik keyworddel, base fuggvennyel
- ugyanarra a tevekenysegre ne legyen ket kulon ige
- coords vs coordinates: legyen kiejtheto,felolvashato
- joinnak tobb szerepe is lehet: szures, vagy uj oszlop behozasa —> egyetlen sort is erdemes fuggvenybe kiemelni, hogy mutassuk a célt


### infrastruktúra

- digital Ocean, 1 docker image / user

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
