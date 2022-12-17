%{
    #include<stdio.h> 
    #include<math.h>
    #include<stdlib.h>
	#include<string.h>
    void yyerror(char *s);
    int sym[26];
    int carry[100];
    int i = 0;

    int yylex(void);


    // int ptr = 0;
    // int value[1000];
    // char varlist[1000][1000];

    // ///if already declared  return 1 else return 0
    // int isdeclared(char str[1000]){
    //     int i;
    //     for(i = 0; i < ptr; i++){
    //         if(strcmp(varlist[i],str) == 0) return 1;
    //     }
    //     return 0;
    // }

    // /// if already declared return 0 or add new value and return 1;
    // int addnewval(char str[1000],int val){
    //     if(isdeclared(str) == 1) return 0;
    //     strcpy(varlist[ptr],str);
    //     value[ptr] = val;
    //     ptr++;
    //     return 1;
    // }

    // ///get the value of corresponding string
    // int getval(char str[1000]){
    //     int indx = -1;
    //     int i;
    //     for(i = 0; i < ptr; i++){
    //         if(strcmp(varlist[i],str) == 0) {
    //             indx = i;
    //             break;
    //         }
    //     }
	// 	if(indx==-1)
	// 	{
	// 		return 0;
	// 	}
    //     return value[indx];
    // }
    // int setval(char str[1000], int val){
    // 	int indx = -1;
    //     int i;
    //     for(i = 0; i < ptr; i++){
    //         if(strcmp(varlist[i],str) == 0) {
    //             indx = i;
    //             break;
    //         }
    //     }
	// 	if(indx!=-1)
    //     value[indx] = val;

    // }

%}


%union { 
  int v;
  double d;  
  float f; 
}

%token<v>NUMBER
%token<d>VARIABLE
%token<f>FL

%type<v>statement
%type<v>expression


%token SCAN INTEGER FLOAT CHARACTER FLOOP WLOOP INCR DECR IMPORT PLUS MINUS MUL DIV POW MOD JODI NAHOLE OTHOBA GT LT PRINT EQL GEQL LEQL CHNG CASE END BREAK DEFAULT BODY FUNCTION MAX MIN SINE COSINE TANGENT LON LB10 GCD LCM FACTORIAL AND OR NOT SLC MLC ENDP
%nonassoc JODI
%nonassoc NAHOLE 
%nonassoc OTHOBA
%nonassoc FLOOP
%nonassoc WLOOP 
%left PLUS MINUS '-' INCR DECR GT LT EQL PRINT GEQL LEQL CASE END BREAK DEFAULT BODY MAX MIN OR
%left MUL DIV AND
%left POW
%left MOD




%%


program:    
        
	program statement '\n'   //BODY ':' '\n' ststement er age just bosai dilei hobe//
       
        | BODY ':' '\n' statement '\n'  
        | BODY ':' '\n' statement '\n' ENDP {printf("...Program Ended...\n")}

        ;


statement:

         expression                      { printf("%d\n",$1);$$=$1;}


         | VARIABLE '=' expression       {  printf("Value of the %d : %d\n",$1,$3);
                                            int x=$1;
					                        sym[x]=$3;
					                        $$=$3; }

         | INTEGER VARIABLE '=' expression END {
                                            char ch = $2 + 97;
                                            printf("Value of the %c : %d\n",ch,$4);
                                            int x=$2;
					                        sym[x]=$4;
					                        $$=$4; }       

         | FLOAT VARIABLE '=' FL END  {      
                                            char ch = $2 + 97;
                                            printf("Value of the %c : %lf\n",ch,$4);
                                            int x=$2;
					                        sym[x]=$4;
					                        $$=$4; }    

        

        | FLOOP '('  NUMBER ':'  NUMBER ')' INCR NUMBER '{' '\n' statement '\n' '}' {
			for(int i = $3;i<=$5;i+=$8){
				printf("%d ",i);
			}
            printf("\n");
		} 
        | FLOOP '('  NUMBER ':'  NUMBER ')' DECR NUMBER '{' '\n' statement '\n' '}' {
			for(int i = $5;i>=$3;i-=$8){
				printf("%d ",i);
			}
            printf("\n");
		} 

        | WLOOP '('  NUMBER LEQL NUMBER ')' '{' '\n' statement '\n' '}'{
			for(int i = $3;i<=$5;i=i+1){
				printf("%d ",i);
			}
            printf("\n");
		}

        //IF
        | JODI '(' expression ')' '{' '\n'  statement '\n' '}' END {
            if($3)
            {
				printf("TRUE\n");
			}
			else{
				printf("FALSE\n");
			}
        }

        
        //IF ELSE
        | JODI '(' expression ')' '{' '\n' statement '\n' '}' '\n' NAHOLE '{' '\n' statement '\n' '}' {
            if($3){
            printf("TRUE\n");
            }
            else{
            printf("FALSE\n");
            }
        }  

       // IF , ELSE-IF , ELSE

        | JODI '(' expression ')' '{' '\n' statement '\n' '}' '\n' OTHOBA '(' expression ')' '{' '\n' statement '\n' '}' '\n' NAHOLE '{' '\n' statement '\n' '}' {
            if($3){
            printf("IN IF CONDITION\n");
            }
            else if($13){
            printf("IN ELSE-IF CONDITION\n");
            }
            else{
            printf("IN ELSE CONDITION\n");
            }
        }


        | PRINT '(' expression ')' END {printf("");}  

        | SLC {}
        | MLC {}

        //SWITCH CASE

        | CHNG '(' NUMBER ')' '{' '\n' casestatement  '\n' '}' {
            printf("SWITCH CASE SELECTION: %d\n",$3);
		    int is = 1 ; 
            for(int j=0;j<100;j++){
                if(carry[j] == $3){
                    printf("Finally Choose Case number :-> %d\n",$3);
                    is = 0;
                    break;
                }
            }
            if(is){
                printf("Finally Choose DEFAULT case \n");
            }

            for(int ii = 0 ;ii < 100; ii++){
                carry[ii] = 0;
            }
        }

        
	    | FUNCTION VARIABLE '(' expression ',' expression ')' '{' '\n' statement '\n' '}' {
            char chr = $2 + 97;
		    printf("FUNCTION NAME :  %c\n",chr);
		    printf("Function Parameter : %d %d\n",$4,$6);
		    printf("Function internal statement : %d\n",$10);
		    }                                                                                   
       
        ;

casestatement:      casegr
 	        |casegr defaultgr
 	        ;
casegr: 
 			| casegr casenum
 			;
casenum: CASE NUMBER ':'  expression END '\n' {
            carry[i++] = $2;
            printf("Case No : %d & expression value :%d \n",$2,$4);}
            
 			;
defaultgr: DEFAULT ':' expression END '\n'{
 				printf("Default CASE & expression value : %d\n",$3);
 			}
 		;
       


expression:
       
        NUMBER         { $$ = $1; }

        | VARIABLE     { int x=$1;$$ = sym[x]; }

        | expression PLUS expression END     {printf("Addition of %d and %d = ",$1,$3); $$ = $1 + $3; }

        | expression MINUS expression END    {printf("Subtraction of %d and %d = ",$1,$3); $$ = $1 - $3; }

        | expression MUL expression END    {printf("Multiplication of %d and %d = ",$1,$3); $$ = $1 * $3; }

        | expression DIV expression END    {printf("Division of %d and %d = ",$1,$3); $$ = $1 / $3; }

        | expression POW expression END    {printf("Power of %d to the power %d = ",$1,$3); $$ = pow($1,$3);}

        | expression MOD expression END    {printf("MOD of of %d and %d = ",$1,$3); $$ = $1 % $3; }

        | expression AND expression END    {printf("LOGICAL AND of %d , %d = ",$1,$3); $$ = $1 && $3; }

        | expression OR expression END    {printf("LOGICAL OR of %d , %d = ",$1,$3); $$ = $1 || $3; }

        | NOT expression END    {printf("LOGICAL NOT of %d = ",$2); $$ = ! $2; }

        | expression LT expression	{printf("Less Than %d < %d ",$1,$3,$1 < $3); $$ = $1 < $3 ; }

	    | expression GT expression	{printf("Greater than %d > %d  ",$1,$3,$1 > $3); $$ = $1 > $3;} 

        | expression LEQL expression	{printf("Less than eqal %d > %d  ",$1,$3,$1 <= $3); $$ = $1 <= $3;} 

        | expression GEQL expression	{printf("Greater than equal %d > %d  ",$1,$3,$1 >= $3); $$ = $1 >= $3;} 

        | expression EQL expression	{printf("Equal %d == %d  ",$1,$3,$1 == $3); $$ = $1 == $3;} 

        | SINE '(' expression ')' END {

            #define PI 3.141592654

            double x_in_radians;
            double x_in_degrees;
            double sin_value;

            x_in_degrees = $3;  

            x_in_radians = x_in_degrees * (PI / 180);
    
            sin_value = sin(x_in_radians);
    
            printf("The value of sin in %.2f radians or in %.2f degrees = %.2f\n", x_in_radians, x_in_degrees, sin_value);
    
        }

        | COSINE '(' expression ')' END {

            double arg = $3, result;
            int deg = arg;
            // Converting to radian
            arg = (arg * PI) / 180;
            result = cos(arg);

            printf("cos of %d degree in %.2lf radian = %.2lf",deg, arg, result);

        }

        | TANGENT '(' expression ')' END {


            double arg = $3, result;
            int deg = arg;
            // Converting to radian
            arg = (arg * PI) / 180;
            result = tan(arg);

            printf("tan of %d degree in %.2lf radian = %.2lf",deg, arg, result);

        }

        | LON '(' expression ')' END {

            double value = $3;
            double result = log(value);
            printf("The Natural Logarithm ln of %f is %f\n", value, result);
            $$=result;

        }

        | LB10 '(' expression ')' END {

            double value = $3;
            double result = log10(value);
            printf("The 10 Base Logarithm of %f is %f\n", value, result);
            $$=result;

        }

        |  GCD '(' expression ',' expression ')' END {
            int n1=$3,n2=$5,gcd;
            for(i=1; i <= n1 && i <= n2; ++i)
            {
              // Checks if i is factor of both integers
              if(n1%i==0 && n2%i==0)
                  gcd = i;
            }

            printf("G.C.D of %d and %d is : ", n1, n2);
            $$ = gcd;
        } 

        |  LCM '(' expression ',' expression ')' END {
            int n1=$3,n2=$5,max;
            max = (n1 > n2) ? n1 : n2;

            while (1) {
                if ((max % n1 == 0) && (max % n2 == 0)) {
                 printf("The LCM of %d and %d is : ", n1, n2);
                 $$ = max;
                 break;
                }
                ++max;
            }
        }

        | FACTORIAL '(' expression ')' END {
            int i;
		    int f=1;
		    for(i=1;i<=$3;i++)
		    {
			    f=f*i;
		    }
		    printf("FACTORIAL of %d is : ",$3);
            $$ = f;    
        } 




	    | '-' expression    { $$ = -$2;}

        | '(' expression ')'        { $$ = $2; }

        

        | FUNCTION '(' expression ',' expression ')' '{' '\n' PRINT END'\n' '}' '\n' MAX FUNCTION '(' ')' END {
            if($3 > $5){
                printf("Maximum num between %d and %d : ",$3,$5);$$=$3;
            }
            else{
                printf("Maximum num between %d and %d : ",$3,$5);$$=$5;
            }
        }

        | FUNCTION '(' expression ',' expression ')' '{' '\n' PRINT END'\n' '}' '\n' MIN FUNCTION '(' ')' END {
            if($3 < $5){
                printf("Minimum num between %d and %d : ",$3,$5);$$=$3;
            }
            else{
                printf("Minimum num between %d and %d : ",$3,$5);$$=$5;
            }
        }
        
        ;


%%



void yyerror(char *s) {

    fprintf(stderr, "%s\n", s);

}

int main(void) {

    	freopen("input.txt","r",stdin);
	    freopen("output.txt","w",stdout);
        yyparse();

}

