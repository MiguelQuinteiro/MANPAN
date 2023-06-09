
****************************************************
* PROGRAMA  : MANPAN.PRG
* CONTENIDO : MANEJO DE LA PANTALLA
* AUTOR     : MIGUEL ANGEL QUINTEIRO
* FECHA     : 06 - 05 - 2002
****************************************************

entsis()
titsis("B & M  SISTEMAS, C.A.","B I T A C O R A  D E  O P E R A C I O N E S")

DO WHILE .T.
	mnupri(10)
	IF confirma("DESEA SALIR DEL SISTEMA") = 1
		INKEY(0)
		CLEAR
		CLEAR ALL
		CLOSE DATABASE
		EXIT
	ENDIF
ENDDO


****************************************************

FUNCTION entsis
	*****************************************
	* Crea la pantalla de entorno del sistema
	*****************************************
	SET COLOR TO "GR+/B,BG+/R,BG"
	CLEAR
	CLEAR ALL
	filini := 0
	filfin := MAXROW()
	colini := 0
	colfin := MAXCOL()
	FOR i = filini TO filfin
		@ i,colini SAY REPLICATE("�",(colfin-colini) + 1)
	NEXT
RETURN

FUNCTION titsis(nomemp,nomsis)
	**********************************************
	* Coloca el Nombre del Sistema y de la Empresa
	**********************************************
	laremp := LEN(nomemp) +  2
	larsis := LEN(nomsis) +  2
	ventana(0,1                ,2,nomemp)
	ventana(0,MAXCOL()-larsis-3,2,nomsis)
RETURN

FUNCTION mnupri(filini)
	******************************************
	* Coloca el Menu Principal de tres Modulos
	******************************************
	titmod("MENU PRINCIPAL DEL SISTEMA")
	moduno    := "MODULO 01"
	moddos    := "MODULO 02"
	modtre    := "MODULO 03"
	larmoduno := LEN(moduno)
	larmoddos := LEN(moddos)
	larmodtre := LEN(modtre)
	menuno    := "PRIMER MODULO DEL SISTEMA"
	mendos    := "SEGUNDO MODULO DEL SISTEMA"
	mentre    := "TERCER MODULO DEL SISTEMA"
	escape    := "ESC para SALIR"
	larescape := LEN(escape)
	SET MESSAGE TO MAXROW()-3 CENTER
	op := 1
	DO WHILE op != 0
		ventana(MAXROW()-4, 1                    ,MAXROW()-2,SPACE(73)       )
		ventana(filini,MAXCOL()-larescape-5      ,filini+2  ,escape          )
		ventana(filini, 1                        ,filini+2  ,SPACE(larmoduno))
		ventana(filini, 1+larmoduno+6            ,filini+2  ,SPACE(larmoddos))
		ventana(filini, 1+larmoduno+6+larmoddos+6,filini+2  ,SPACE(larmodtre))
		@ filini+1,3                         PROMPT moduno MESSAGE menuno
		@ filini+1,3+larmoduno+6             PROMPT moddos MESSAGE mendos
		@ filini+1,3+larmoduno+6+larmoddos+6 PROMPT modtre MESSAGE mentre
		MENU TO op
		IF LASTKEY() = 27
			EXIT
		ENDIF
		DO CASE
			CASE op = 1
				espera("El modulo uno aun no esta listo, Pulsa una tecla")
			CASE op = 2
				espera("Pulsa una tecla")
			CASE op = 3
				espera("Pulsa una tecla")
		ENDCASE
	ENDDO
RETURN

FUNCTION titmod(texto)
	*****************************
	* Coloca el titulo del Modulo
	*****************************
	nommod := texto
	larmod := LEN(nommod) +  2
	ventana(5,((MAXCOL()-larmod)/2),7,nommod)
RETURN

FUNCTION ventana(filini,colini,filfin,texto)
	**************************************************
	* Abre una Ventana con sombra en el lugar indicado
	**************************************************
	lartxt := LEN(texto) + 2
	* Crea la SOMBRA
	SET COLOR TO W+/N
	@ filini+1,colini+1 CLEAR TO filfin+1,colini+lartxt+2
	* Crea el CUADRO
	SET COLOR TO "W+/B,N+/W"
	@ filini,colini CLEAR TO filfin,colini+lartxt+1
	@ filini,colini TO       filfin,colini+lartxt+1 DOUBLE
	* Coloca el texto
	@ filini+1,colini+2 SAY texto
	* Restablece el COLOR
	SET COLOR TO "GR+/B,BG+/R,BG"
RETURN

FUNCTION espera(texto)
	*******************************************************
	* Coloca un mensaje espera a que se presiones una tecla
	*******************************************************
	lartxt := LEN(texto) + 2
	colini := MAXCOL() - lartxt - 3
	filini := MAXROW() - 9
	pantalla = SAVESCREEN(filini,0,filini+4,79)
	SET CURSOR OFF
	ventana(filini,colini,filini+2,texto)
	INKEY(0)
	SET CURSOR ON
	RESTSCREEN(filini,0,filini+4,79,pantalla)
RETURN

FUNCTION confirma(texto)
	**********************************************
	* Coloca un mensaje y deja seleccionar Si o No
	**********************************************
	LOCAL fil,col,largo,pantalla
	* Pocisiona el Mensaje y Guarda la pantalla
	largo = LEN(texto) + 2
	fil   = (MAXROW()/2) - 2
	col   = (80-largo) / 2
	IF largo < 16
		largo = 16
	ENDIF
	pantalla = SAVESCREEN(fil,0,fil+4,79)
	ventana(fil,col,fil+3,texto)
	coluna = (largo - 9)/2
	@ fil+2,col+coluna   PROMPT "SI"
	@ fil+2,col+coluna+6 PROMPT "NO"
	MENU TO confirm
	RESTSCREEN(fil,0,fil+4,79,pantalla)
RETURN(confirm)
