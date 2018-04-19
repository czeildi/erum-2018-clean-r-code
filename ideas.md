egészen kevés dologra nézzünk meg sok kulonbozo megoldast, es hogy melyiket hogyan lehet improvolni?

lesz internet?

batoritsuk parmunkat

gist-ben kodreszlet, amit be kell huzniuk, irunk hozza kodot?
kulonbozo brancheken legyenek a lepesek, es legyen R fuggveny arra, hogy git checkout 
<adott step>

elemzesi cel szerint bontsunk

globális változó: ha nem módosítjuk, csak read only, akkor érvényes?

struktúra: feladat, önálló munka, refaktor tippek, önálló munka, refaktorálás megbeszélés, adott refaktorálásról pici "elméleti"  háttér, esetleg refaktorálásnál megbeszélni a résztvevők által adott megoldásokat, hogy mi benne a jó, hogy lehetne mágjobb

4-5 30 perces modul fér bele

közepén legyen 15 perces szünet

Az fontos, hogy ha valaki egy adott lépésnél lemarad, utána még tudja folytatni

- [ ] végig rmarkdown?
- elején függvény, elnevezés
- legvége parametrized rmarkdown: egyes ügyfeleknek akarunk bizonyos időszakra reportot küldeni
- [ ] keyboard shortcutok közben végig, minden résznél 2-3ra fókuszálunk?
  - send code to console
  - rename variable in scope
  - extract function
  - new R script
  - go to file/ function
  - reindent lines
  - insert pipe / insert assignment
  - move lines up / down
  - restart R
  - go to function / file (F2)
- fuggvenyek ott maradjanak ugyanabban a fajlban? nem, rögtön kerüljenek ki külön fájlba
- 2 elemzesunk van --> elson tanulsz, masodikon gyakorolsz
- 3 fo lepes: adatbeolvasas, summarise, plot
- mukodo kodot kapjanak
- make changes in parallel to two versions: one clean and not so clean
- dropboxon keresztül időnként újabb és újabb hintek, code snippetek, megoldások?

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
