# Compiler-Design-Project

To run the project :
->Install flex and bison with global environment variable setup.
-> Firsty open the folder of the project and open command promt there.
->Then write the below codes consecutively.

bison -d 1807109.y
flex 1807109.l
gcc 1807109.tab.c lex.yy.c -o output
output
