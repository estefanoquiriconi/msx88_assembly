H_DATO EQU 40H
H_ESTADO EQU 41H

ORG 1000H
LETRAS DB ?
MSJ DB "Inicia el control del sistema"
DB 0AH
FIN DB ?
ENTER DB 0AH

ORG 2000H
MOV BX, OFFSET MSJ 
MOV AL, OFFSET FIN - OFFSET MSJ
INT 7

MOV BX, OFFSET LETRAS
MOV DL, 0
LOOP: INT 6
      MOV CL, [BX]
      INC BX
      INC DL
      CMP CL, ENTER
JNZ LOOP

MOV BX, OFFSET LETRAS
POLL:
  IN AL, H_ESTADO
  AND AL, 1
JNZ POLL
  MOV AL, [BX]
  OUT H_DATO, AL
  INC BX
  DEC DL
  CMP DL, 1
JNZ POLL          

INT 0
END