INCLUDE ..\Irvine32.inc

.data

; PONCUTATIONS
P_PURPLE DWORD 10
P_BLUE DWORD 20
P_GREEN DWORD 30
P_YELLOW DWORD 50
P_RED DWORD 80
MEDAL_GOLD = 90
MEDAL_SILVER = 55
MEDAL_BRONZE = 20

; ENUM: Bricks
B_WHITE = 0
B_PURPLE = 1
B_BLUE = 2
B_GREEN = 3
B_YELLOW = 4
B_RED = 5

; Game Constants
LEN_Q_LANES = 3 ; LANES NUMBER
LEN_B_COLORS = B_RED+1 ; BRICK COLORS NUMBER
LEN_I_BRICKS = 7 ; BRICKS PER INVENTORY
LEN_L_BRICKS = 29 ; BRICKS PER LANE
MAIN_TIME_STEP = 40; OUR DELAY TIME BETWEEN STEPS (miliseconds)
BLOCKED_STEPS = 10 ; STEPS THE PLAYER WILL BE BLOCKED WHEN OVERFLOWED

; Enum: QueueElem
Q_BRICK = 0 ; LANE * Brick
Q_NEXT = Q_BRICK+(LEN_Q_LANES*LEN_B_COLORS) ; ADVANCE STEP
Q_REPEAT_X = Q_NEXT+1 ; CREATE X EMPTY STEPS
Q_EOG = 255 ; END OF LEVEL

; Enum: InventoryElem
I_EMPTY = 0
I_REMOVING = 1
I_COLOR = 2

; Enum: PerLaneQueueElem
L_EMPTY = 0
L_EOG = 1
L_COLOR = 2

; GAME STATES
PLAYER_POS BYTE ? ; WHICH LANE (0..LEN_Q_LANES)
MAIN_Q_ESI DWORD offset LEVEL_EASY ; CURRENT LEVEL QUEUE + INDEX
MAIN_Q_REPEAT_COUNTER BYTE 0 ; EMPTY STEPS LEFT COUNTER
PLAYER_BLOCKED_X BYTE 0 ; HOW MANY STEPS PLAYER WILL CONTINUE BLOCKED
PLAYER_INVENTORY BYTE LEN_Q_LANES DUP (LEN_I_BRICKS DUP (I_EMPTY)) ; IVENTORY ON EACH LANE
PLAYER_INVENTORY_0 = offset PLAYER_INVENTORY
PLAYER_INVENTORY_1 = (offset PLAYER_INVENTORY + 7)
PLAYER_INVENTORY_2 = (offset PLAYER_INVENTORY + 14)
PLAYER_POINTS DWORD 0 ; PONCUTATION ACCUMULATOR
GAME_LANES BYTE LEN_Q_LANES DUP (LEN_L_BRICKS DUP (L_EOG)) ; WHAT WE HAVE QUEUED ON EACH LANE
GAME_LANES_0 = offset GAME_LANES
GAME_LANES_1 = (offset GAME_LANES + LEN_L_BRICKS)
GAME_LANES_2 = (offset GAME_LANES + (LEN_L_BRICKS * 2))
MATCH_COUNTER DWORD 0;

; GLYPHS
G_INV_EMPTY = 176
G_INV_NODE = 219
G_INV_SPLT = 175
G_LANE_EMPTY = ' '
G_LANE_NODE = 177
G_LANE_EOG = 250
G_LANE_BORDER = 205
G_LANE_SPLT = 196
G_FRAME = 254
G_EOG = 250

GLYPH_PLAYER_EMPTY \
	BYTE 4 DUP (" "), 0
GLYPH_PLAYER \
	BYTE 3 DUP (178), 254, 0

GLYPH_LANE_BORDER BYTE 80 DUP (G_LANE_BORDER), 0
GLYPH_LANE_SPLT BYTE 80 DUP (G_LANE_SPLT), 0
GLYPH_INV_SPLT BYTE G_INV_SPLT, 0

; LEVELS
LEVEL_EASY \
	BYTE(B_GREEN), (B_YELLOW + LEN_B_COLORS), Q_NEXT
	BYTE Q_REPEAT_X + 3
	BYTE(B_RED + LEN_B_COLORS), (B_YELLOW + (LEN_B_COLORS * 2)), Q_NEXT
	BYTE Q_REPEAT_X + 31, Q_EOG
LEVEL_NORMAL BYTE Q_REPEAT_X+31,Q_EOG
LEVEL_HARD BYTE Q_REPEAT_X+31,Q_EOG

; MUSIC FILES
MUSIC_TITLE BYTE "title.mp3", 0
MUSIC_EASY BYTE "easy.mp3", 0
MUSIC_NORMAL BYTE "normal.mp3", 0
MUSIC_HARD BYTE "hard.mp3", 0

; METAS
META_EASY \
	BYTE "Listen to your heart", 0
	BYTE "Roxette", 0
	BYTE "1988", 0

META_NORMAL \
	BYTE "Seven Nation Army", 0
	BYTE "The White Stripes", 0
	BYTE "2003", 0

META_HARD \
	BYTE "I Love Rock 'n' Roll ", 0
	BYTE "Joan Jett & The Blackhearts", 0
	BYTE "1981", 0

PTS_TOTAL_EASY = 7000
PTS_TOTAL_NORMAL = 8000
PTS_TOTAL_HARD = 15000

; TEXTS
TXT_LOGO \
	BYTE "    ____        __          _____            ____", 0
	BYTE "   / __ )__  __/ /____     / ___/__  _______/ __/__  _____", 0
	BYTE "  / __  / / / / __/ _ \    \__ \/ / / / ___/ /_/ _ \/ ___/", 0
	BYTE " / /_/ / /_/ / /_/  __/   ___/ / /_/ / /  / __/  __/ /", 0
	BYTE "/_____/\__, /\__/\___/   /____/\__,_/_/  /_/  \___/_/", 0
	BYTE "      /____/", 0
LQ_LOGO = 6

TXT_TITLE_MIDDLE \
	BYTE "  PRESS F1 FOR INSTRUCTIONS!",0
	BYTE "OR CHOOSE A DIFFICULTY TO PLAY:",0
	BYTE "           1 - EASY",0
	BYTE "          2 - NORMAL",0
	BYTE "           3 - HARD",0
LQ_TITLE_MIDDLE = 5

TXT_AUTHORS \
	BYTE "Created by: Bianca Garcia Martins                         LAB ARQ2", 0
	BYTE "            Pedro Henrique Lara Campos               Prof. Luciano Neris", 0
	BYTE "            Rebecca Fernandes                              2017/2", 0
LQ_AUTHORS = 3

TXT_INSTRUCTIONS \
	BYTE "INSTRUCTIONS:", 0
	BYTE 0
	BYTE "  Press the UP and DOWN keys to move your spaceship across the roadway.", 0
	BYTE 0
	BYTE "  Earn points collecting bricks forming clusters of the same colors.", 0
	BYTE 0
	BYTE "  The bigger is the cluster and the hotter its color then more points will be", 0
	BYTE "  received.", 0
	BYTE 0
	BYTE "  If you get tired of playing, press ESC to return to title screen.", 0
	BYTE 0
	BYTE "  The level ends when the music stops!", 0
	BYTE 0
	BYTE "  In the title screen you need to choose a difficulty and press the number rela- ", 0
	BYTE "  ted to your choise.", 0
	BYTE 0
	BYTE 0
	BYTE "                                                Press RETURN to return...", 0
LQ_INSTRUCTIONS = 18

TXT_POINTS \
	BYTE 201,205,187,218,196,191,218,191,218,218,196,191,194,196,191,218,196,191,218,194,191,194,32,194,194,32,32,218,196,191,218,194,191,194,218,196,191,218,191,218,218,196,191, 0
	BYTE 186,32,32,179,32,179,179,179,179,179,32,194,195,194,217,195,196,180,32,179,32,179,32,179,179,32,32,195,196,180,32,179,32,179,179,32,179,179,179,179,192,196,191, 0
	BYTE 200,205,188,192,196,217,217,192,217,192,196,217,193,192,196,193,32,193,32,193,32,192,196,217,193,196,217,193,32,193,32,193,32,193,192,196,217,217,192,217,192,196,217, 0
LQ_POINTS = 3

TXT_MEDAL \
	BYTE "HERE'S A MEDAL FOR YOU:",0

TXT_REWARD_GOLD \
	BYTE 201,205,187,201,205,187,203,32,32,201,203,187, 0
	BYTE 186,32,203,186,32,186,186,32,32,32,186,186, 0
	BYTE 200,205,188,200,205,188,202,205,188,205,202,188, 0
LQ_REWARD_GOLD = 3

TXT_REWARD_SILVER \
	BYTE 201,205,187,203,203,32,203,32,32,203,201,205,187,203,205,187, 0
	BYTE 200, 205, 187,186,186,32,200,187,201,188,186,185,32,204,203,188, 0
	BYTE 200,205,188,202,202,205,188,200,188,32,200,205,188,202,200,205, 0
LQ_REWARD_SILVER = 3

TXT_REWARD_BRONZE \
	BYTE 201,187,32,203,205,187,201,205,187,201,187,201,201,205,187,201,205,187, 0
	BYTE 204,202,187,204,203,188,186,32,186,186,186,186,201,205,188,186,185, 0 
	BYTE 200,205,188,202,200,205,200,205,188,188,200,188,200,205,188,200,205,188, 0
LQ_REWARD_BRONZE = 3
               
TXT_PTS_0 \
	BYTE "YOU GOT ", 0

TXT_PTS_1 \
	BYTE " PTS.", 0

             
TXT_FINISH \
	BYTE "WANNA TRY AGAIN?", 0
	BYTE " Press ESC to quit.", 0
	BYTE " Press SPACE to replay.", 0
	BYTE " Press RETURN to go back to title screen.", 0
LQ_FINISH = 4

TXT_SIGNATURE \
	BYTE "[= BYTES SURFER =]",0

TXT_PTS_NOW \
	BYTE "POINTS:",0

; BUFFERS
LAST_STEP DWORD ?
VSYNC BYTE 25 DUP (90 DUP (?))
BF_DEFAULT_FRAMED BYTE \
	88 DUP (G_FRAME), 13, 10,
	20 DUP (G_FRAME, 86 DUP (" "), G_FRAME, 13, 10),
	88 DUP (G_FRAME), 0
BF_DEFAULT_EMPTY BYTE 22 DUP (88 DUP (" "), 13, 10), 0

; CURSOR HACKS
CCI CONSOLE_CURSOR_INFO <>
CHAND DD ?

.code

HideCursor PROC USES eax
	invoke GetStdHandle, STD_OUTPUT_HANDLE
	mov CHAND, eax
	invoke GetConsoleCursorInfo, CHAND, addr CCI
	mov CCI.bVisible, FALSE
	invoke SetConsoleCursorInfo, CHAND, addr CCI
	ret
HideCursor ENDP

ClipText PROC USES eax ebx ecx edx, src: PTR BYTE, lines: DWORD, row: DWORD, col: DWORD
	mov ebx, src
	mov ecx, lines

	mov edx, row
	imul edx, edx, 90	
	add edx, col
	add edx, offset VSYNC
	push edx

ClipTextChar:
	movzx eax, BYTE PTR [ebx]
	add ebx, 1
	test al, al
	je ClipTextLine
	mov BYTE PTR [edx], al
	add edx, 1
	jmp ClipTextChar

ClipTextLine:
	pop edx
	add edx, 90
	push edx
	sub ecx, 1
	cmp ecx, 0
	je ClipTextFinish
	jmp ClipTextChar

ClipTextFinish:
	ret
ClipText ENDP

WaitStep PROC USES eax ebx
	mov ebx, MAIN_TIME_STEP

	; Get elapsed time
	call GetMseconds
	sub eax, LAST_STEP

	; Subtract elapsed time from default step
	sub ebx, eax

	; If negative do not wait step
	bt ebx, 31
	jc JumpSleep

	; Wait (default step - elapsed time)
	INVOKE Sleep, ebx

JumpSleep:
	; Save current time to calculate elapsed later on
	call GetMseconds
	mov LAST_STEP, eax

	ret
WaitStep ENDP

HelpScreen PROC USES eax edx
	INVOKE Str_copy,
		offset BF_DEFAULT_FRAMED,
		offset VSYNC
	
	INVOKE ClipText, offset TXT_INSTRUCTIONS, LQ_INSTRUCTIONS, 2, 4
	
	call Clrscr
	mov edx, offset VSYNC
	call WriteString
	call ReadChar
	
	ret
HelpScreen ENDP

sGotoyx PROC USES edx, row: BYTE, col: BYTE
	mov dl, col
	mov dh, row
	call Gotoxy
	ret
sGotoyx ENDP

PopStep PROC USES eax esi, dest_i: DWORD
	mov edi, dest_i
	mov BYTE PTR [GAME_LANES_0+edi], L_EMPTY
	mov BYTE PTR [GAME_LANES_1+edi], L_EMPTY
	mov BYTE PTR [GAME_LANES_2+edi], L_EMPTY
	
	; Se estiver em um loop de repetições vazias
	mov al, MAIN_Q_REPEAT_COUNTER
	cmp al, 0
	jne NonEmptyRep

GrabFromQueue:
	; Carrega a próxima instrução do esi
	mov esi, MAIN_Q_ESI
	movzx eax, BYTE PTR [esi]
	inc esi
	mov MAIN_Q_ESI, esi

	; O que fazer?
	cmp al, B_RED
	jle FirstLaneBrick

	cmp al, (LEN_B_COLORS*2)
	jl SecondLaneBrick

	cmp al, (LEN_B_COLORS*3)
	jl ThirdLaneBrick

	cmp al, Q_NEXT
	je FinishStep

	cmp al, Q_EOG
	je AllLanesEOG

StartRepetition:
	sub al, (Q_REPEAT_X-1)
	mov MAIN_Q_REPEAT_COUNTER, al
	ret

FirstLaneBrick:
	add al, L_COLOR
	mov BYTE PTR [GAME_LANES_0+edi], al
	jmp GrabFromQueue

SecondLaneBrick:
	add al, L_COLOR
	sub al, LEN_B_COLORS
	mov BYTE PTR [GAME_LANES_1+edi], al
	jmp GrabFromQueue

ThirdLaneBrick:
	add al, L_COLOR
	sub al, (LEN_B_COLORS*2)
	mov BYTE PTR [GAME_LANES_2+edi], al
	jmp GrabFromQueue

AllLanesEOG:
	mov BYTE PTR [GAME_LANES_0+edi], L_EOG
	mov BYTE PTR [GAME_LANES_1+edi], L_EOG
	mov BYTE PTR [GAME_LANES_2+edi], L_EOG
	dec esi
	mov MAIN_Q_ESI, esi
	ret

NonEmptyRep:
	dec al
	mov MAIN_Q_REPEAT_COUNTER, al
	ret

FinishStep:
	ret
PopStep ENDP

GameDrawInventory PROC USES eax ebx edx esi
	mov esi, 0
	mov bl, 0
DrawInventoryLane:
	mov al, bl
	mov dl, 4
	mul dl
	add al, 7
	INVOKE sGotoyx, al, 4
	mov bh, 0

DrawInventoryItem:
	movzx eax, BYTE PTR [PLAYER_INVENTORY_0+esi]
	inc esi

	cmp al, (I_COLOR+B_WHITE)
	je DrawInventoryWhite

	cmp al, (I_COLOR+B_PURPLE)
	je DrawInventoryPurple

	cmp al, (I_COLOR+B_BLUE)
	je DrawInventoryBlue

	cmp al, (I_COLOR+B_GREEN)
	je DrawInventoryGreen

	cmp al, (I_COLOR+B_YELLOW)
	je DrawInventoryYellow

	cmp al, (I_COLOR+B_RED)
	je DrawInventoryRed

DrawInventoryEmpty:
	mov eax, white+(black*16)
	call SetTextColor
	mov al, G_INV_EMPTY
	call WriteChar
	jmp InventoryFinishItem

DrawInventoryWhite:
	mov eax, white+(black*16)
	call SetTextColor
	jmp DrawInventoryNode

DrawInventoryPurple:
	mov eax, magenta+(black*16)
	call SetTextColor
	jmp DrawInventoryNode

DrawInventoryBlue:
	mov eax, blue+(black*16)
	call SetTextColor
	jmp DrawInventoryNode

DrawInventoryGreen:
	mov eax, green+(black*16)
	call SetTextColor
	jmp DrawInventoryNode

DrawInventoryYellow:
	mov eax, yellow+(black*16)
	call SetTextColor
	jmp DrawInventoryNode

DrawInventoryRed:
	mov eax, red+(black*16)
	call SetTextColor

DrawInventoryNode:
	mov al, G_INV_NODE
	call WriteChar

InventoryFinishItem:
	mov al, ' '
	call WriteChar

	inc bh
	cmp bh, LEN_I_BRICKS
	jl DrawInventoryItem

InventoryFinishLane:
	inc bl
	cmp bl, LEN_Q_LANES
	jl DrawInventoryLane

	mov eax, white+(black*16)
	call SetTextColor

	ret
GameDrawInventory ENDP

GameDrawPlayer PROC USES eax edx
	INVOKE sGotoyx, 7, 20
	mov edx, offset GLYPH_PLAYER_EMPTY
	call WriteString
	INVOKE sGotoyx, 11, 20
	mov edx, offset GLYPH_PLAYER_EMPTY
	call WriteString
	INVOKE sGotoyx, 15, 20
	mov edx, offset GLYPH_PLAYER_EMPTY
	call WriteString

	mov al, PLAYER_POS
	mov dl, 4
	mul dl
	add al, 7

	INVOKE sGotoyx, al, 20
	mov edx, offset GLYPH_PLAYER
	call WriteString

	ret
GameDrawPlayer ENDP

GameDrawLanes PROC USES eax ebx edx esi
	mov esi, 0
	mov bl, 0
DrawLane:
	mov al, bl
	mov dl, 4
	mul dl
	add al, 7
	INVOKE sGotoyx, al, 26
	mov bh, 0

DrawLanesItem:
	movzx eax, BYTE PTR [GAME_LANES_0+esi]
	inc esi

	cmp al, (L_COLOR+B_WHITE)
	je DrawLanesWhite

	cmp al, (L_COLOR+B_PURPLE)
	je DrawLanesPurple

	cmp al, (L_COLOR+B_BLUE)
	je DrawLanesBlue

	cmp al, (L_COLOR+B_GREEN)
	je DrawLanesGreen

	cmp al, (L_COLOR+B_YELLOW)
	je DrawLanesYellow

	cmp al, (L_COLOR+B_RED)
	je DrawLanesRed

	cmp al, (L_EOG)
	je DrawLanesEOG

DrawLanesEmpty:
	mov eax, white+(black*16)
	call SetTextColor
	mov al, G_LANE_EMPTY
	call WriteChar
	jmp LanesFinishItem

DrawLanesEOG:
	mov eax, white+(black*16)
	call SetTextColor
	mov al, G_LANE_EOG
	call WriteChar
	jmp LanesFinishItem

DrawLanesWhite:
	mov eax, white+(black*16)
	call SetTextColor
	jmp DrawLanesNode

DrawLanesPurple:
	mov eax, magenta+(black*16)
	call SetTextColor
	jmp DrawLanesNode

DrawLanesBlue:
	mov eax, blue+(black*16)
	call SetTextColor
	jmp DrawLanesNode

DrawLanesGreen:
	mov eax, green+(black*16)
	call SetTextColor
	jmp DrawLanesNode

DrawLanesYellow:
	mov eax, yellow+(black*16)
	call SetTextColor
	jmp DrawLanesNode

DrawLanesRed:
	mov eax, red+(black*16)
	call SetTextColor

DrawLanesNode:
	mov al, G_LANE_NODE
	call WriteChar

LanesFinishItem:
	mov al, ' '
	call WriteChar

	inc bh
	cmp bh, LEN_L_BRICKS
	jl DrawLanesItem

LanesFinishLane:
	inc bl
	cmp bl, LEN_Q_LANES
	jl DrawLane

	mov eax, white+(black*16)
	call SetTextColor

	ret
GameDrawLanes ENDP

GameDrawPoints PROC USES eax
	INVOKE sGotoyx, 20, 12
	mov eax, PLAYER_POINTS
	call WriteDec
	ret
GameDrawPoints ENDP

AddInv PROC USES eax edx esi ecx, nc: BYTE
	xor eax, eax
	mov al, PLAYER_POS
	mov edx, LEN_I_BRICKS
	mul edx
	add eax, offset PLAYER_INVENTORY
	mov esi, eax
	mov edi, eax
	mov ecx, LEN_I_BRICKS

InvCheckLoop:
	lodsb
	cmp al, I_EMPTY
	je InvNotEmpty
	loop InvCheckLoop
	
	mov PLAYER_BLOCKED_X, BLOCKED_STEPS
	mov ecx, LEN_I_BRICKS  
	mov al, I_EMPTY
	
InvEmptyLoop:
	stosb
	loop InvEmptyLoop
	ret

InvNotEmpty:
	mov edi, esi
	dec edi
	mov al, nc
	stosb
	ret

AddInv ENDP

Step PROC USES eax ecx edx esi edi
	mov al, PLAYER_BLOCKED_X
	cmp al, 0
	jne StepBlocked

	xor eax, eax
	mov al, PLAYER_POS
	mov edx, LEN_L_BRICKS
	mul edx
	add eax, offset GAME_LANES
	movzx eax, BYTE PTR [eax]
	
	cmp al, L_EMPTY
	je StepProceed

	cmp al, L_EOG
	je StepEOG

	INVOKE AddInv, al
	jmp StepProceed

StepEOG:
	mov PLAYER_POS, 255
	ret

StepBlocked:
	dec al
	mov PLAYER_BLOCKED_X, al
	
StepProceed:
	mov esi, OFFSET GAME_LANES +1
	mov edi, OFFSET GAME_LANES
	mov ecx, ((LENGTHOF GAME_LANES) -1)

StepMoveLeftLoop:
	lodsb
	stosb
	loop StepMoveLeftLoop
	INVOKE PopStep, LEN_L_BRICKS - 1

	ret
Step ENDP

MedalScreen PROC USES eax edx, total: DWORD
	INVOKE Str_copy,
		offset BF_DEFAULT_FRAMED,
		offset VSYNC
	
	INVOKE ClipText, offset TXT_POINTS, LQ_POINTS, 3, 23 
	INVOKE ClipText, offset TXT_MEDAL, 1, 7, 33  
	INVOKE ClipText, offset TXT_PTS_0, 1, 14, 36 
	INVOKE ClipText, offset TXT_FINISH, LQ_FINISH, 16, 3  

	mov eax, total 
	mov edx, MEDAL_GOLD 
	mul edx
	mov edx, 0
	mov ebx, 100
	div ebx
	cmp PLAYER_POINTS, eax
	jge RewardGold

	mov eax, total 
	mov edx, MEDAL_SILVER
	mul edx
	mov edx, 0
	mov ebx, 100
	div ebx
	cmp PLAYER_POINTS, eax
	jge RewardSilver

RewardBronze:
	INVOKE ClipText, offset TXT_REWARD_BRONZE, LQ_REWARD_BRONZE, 8, 35 
	jmp RewardFinish
	
RewardGold:
	INVOKE ClipText, offset TXT_REWARD_GOLD, LQ_REWARD_GOLD, 8, 38
	jmp RewardFinish 

RewardSilver:
	INVOKE ClipText, offset TXT_REWARD_SILVER, LQ_REWARD_SILVER, 8, 36
		
RewardFinish:
	call Clrscr
	mov edx, offset VSYNC
	call WriteString

	INVOKE sGotoyx, 14, 44
	mov eax, PLAYER_POINTS
	call WriteDec

	mov al, " "
	call WriteChar

	mov edx, offset TXT_PTS_1
	call WriteString

	call ReadChar
	ret

MedalScreen ENDP

InventoryElem PROC USES edx, sy: BYTE, sx: BYTE ; RETURNS: EAX
	xor eax, eax
	mov al, sy
	mov dl, LEN_I_BRICKS
	mul dl
	add eax, offset PLAYER_INVENTORY
	add al, sx
	ret
InventoryElem ENDP

ThreeMatchSearcher PROC USES esi eax ebx edx, sy: BYTE, sx: BYTE, me: PTR BYTE
	; All the credits for this proc goes to Bianca
	mov esi, me

	movzx eax, BYTE PTR [esi]
	mov dl, al
	and dl, 00001111b ; CHECK IF NEEDED IN POS-PRODUCTION

	or al, 01000000b ; MARK AS PROCESS(ING|ED)
	mov BYTE PTR[esi], al

CompareLeft:
	cmp sx, 0
	je CompareUp

	movzx eax, BYTE PTR [esi - 1]
	cmp al, dl
	jne CompareUp

	mov al, sx
	dec al
	dec esi
	INVOKE ThreeMatchSearcher, sy, al, esi
	inc esi

CompareUp:
	cmp sy, 0
	je CompareRight

	movzx eax, BYTE PTR [esi - LEN_I_BRICKS]
	cmp al, dl
	jne CompareRight

	mov bl, sy
	dec bl
	sub esi, LEN_I_BRICKS
	INVOKE ThreeMatchSearcher, bl, sx, esi
	add esi, LEN_I_BRICKS

CompareRight:
	cmp sx, LEN_I_BRICKS-1
	je CompareDown

	movzx eax, BYTE PTR [esi + 1]
	cmp al, dl
	jne CompareDown

	mov bl, sx
	inc bl
	inc esi
	INVOKE ThreeMatchSearcher, sy, bl, esi
	dec esi

CompareDown:
	cmp sy, LEN_Q_LANES-1
	je EndComparison

	movzx eax, BYTE PTR [esi + LEN_I_BRICKS]
	cmp al, dl
	jne EndComparison

	mov bl, sy
	inc bl
	add esi, LEN_I_BRICKS
	INVOKE ThreeMatchSearcher, bl, sx, esi
	sub esi, LEN_I_BRICKS

EndComparison:
	mov al, dl
	or al, 11000000b ; MARK AS TO CANDIDATE TO REMOVE
	mov BYTE PTR[esi], al
	
	mov eax, MATCH_COUNTER
	inc eax
	mov MATCH_COUNTER, eax

	ret
ThreeMatchSearcher ENDP

InventoryRemark PROC USES eax ecx esi edi, brick: BYTE
	mov esi, OFFSET PLAYER_INVENTORY
	mov edi, OFFSET PLAYER_INVENTORY
	mov ecx, LENGTHOF PLAYER_INVENTORY

	cmp MATCH_COUNTER, 3
	jl UndoAll

	xor eax, eax
	mov al, brick
	sub al, I_COLOR
	add eax, offset P_PURPLE
	movzx eax, BYTE PTR[eax]
	mov edx, MATCH_COUNTER
	mul eax
	add eax, PLAYER_POINTS
	mov PLAYER_POINTS, eax

WhenMatchItem:
	lodsb
	and al, 10000000b
	cmp al, 10000000b
	je MarkToRemove
	jmp Ignore

MarkToRemove:
	mov al, I_REMOVING
	stosb
	loop WhenMatchItem
	jmp Finish

Ignore:
	inc edi
	loop WhenMatchItem
	jmp Finish

UndoAll:
	lodsb
	and al, 00111111b
	stosb

Finish:
	ret
InventoryRemark ENDP

InventoryClean PROC
	mov ebx, 0
PerLane:
	INVOKE InventoryElem, bh, 0
	mov esi, eax
	mov edi, eax
	mov ecx, LEN_I_BRICKS

PerItem:
	lodsb
	cmp al, I_REMOVING
	je FinishItem
	stosb

FinishItem:
	loop PerItem

	mov al, I_EMPTY
	cmp esi, edi
	je FillTail
	jmp Finish

FillTail:
	stosb
	cmp esi, edi
	je FillTail

Finish:
	ret
InventoryClean ENDP

ThreeMatchSearch PROC USES eax ebx ecx
	xor bx, bx
NextElem:
	INVOKE InventoryElem, bh, bl
	movzx ecx, BYTE PTR [esi]

	cmp cl, I_EMPTY
	je FinishLine

	cmp cl, I_REMOVING
	je FinishElem

	mov MATCH_COUNTER, 0
	INVOKE ThreeMatchSearcher, bh, bl, eax
	INVOKE InventoryRemark, cl

FinishElem:
	inc bl

	cmp bl, LEN_I_BRICKS
	je FinishLine

	jmp NextElem

FinishLine:
	inc bh

	cmp bh, LEN_Q_LANES
	je Finish

	mov bl, 0
	jmp NextElem

Finish:
	INVOKE InventoryClean
	ret
ThreeMatchSearch ENDP

Game PROC USES eax ecx edx, level: PTR BYTE, meta: PTR BYTE
	; Inicia o ponteiro do QUEUE
	mov eax, level
	mov MAIN_Q_ESI, eax
	mov ecx, 0

	; Dados iniciais
	mov PLAYER_POS, 1
	mov PLAYER_POINTS, 0

GameFillIn:
	INVOKE PopStep, ecx
	inc ecx
	cmp ecx, LEN_L_BRICKS
	jl GameFillIn

GameStaticFrame:
	INVOKE Str_copy,
		offset BF_DEFAULT_EMPTY,
		offset VSYNC

	INVOKE ClipText, meta, 3, 1, 4
	INVOKE ClipText, offset GLYPH_LANE_BORDER, 1, 5, 4
	INVOKE ClipText, offset GLYPH_LANE_BORDER, 1, 17, 4
	INVOKE ClipText, offset GLYPH_LANE_SPLT, 1, 9, 4
	INVOKE ClipText, offset GLYPH_LANE_SPLT, 1, 13, 4
	INVOKE ClipText, offset GLYPH_INV_SPLT, 1, 7, 18
	INVOKE ClipText, offset GLYPH_INV_SPLT, 1, 11, 18
	INVOKE ClipText, offset GLYPH_INV_SPLT, 1, 15, 18
	INVOKE ClipText, offset TXT_PTS_NOW, 1, 20, 4
	INVOKE ClipText, offset TXT_SIGNATURE, 1, 20, 66

GameDrawStaticFrame:
	call Clrscr
	mov edx, offset VSYNC
	call WriteString

GameMainLoop:
	INVOKE GameDrawInventory
	INVOKE GameDrawPlayer
	INVOKE GameDrawLanes
	INVOKE GameDrawPoints

	call ReadKey
	cmp dx, VK_DOWN
	je PlayerGoDown
	cmp dx, VK_UP
	je PlayerGoUp

GamePosMove:
	INVOKE Step
	INVOKE WaitStep

	mov al, PLAYER_POS
	cmp al, 255
	jne GameMainLoop
	jmp GameFinish


PlayerGoUp:
	mov al, PLAYER_POS
	cmp al, 0
	jne MoveUp
	jmp GamePosMove

MoveUp:
	dec al
	mov PLAYER_POS, al
	jmp GamePosMove

PlayerGoDown:
	mov al, PLAYER_POS
	cmp al, LEN_Q_LANES -1
	jne MoveDown
	jmp GamePosMove

MoveDown:
	inc al
	mov PLAYER_POS, al
	jmp GamePosMove

GameFinish:
	ret
Game ENDP

TitleScreen PROC USES eax edx
TitleStart: 
	INVOKE Str_copy,
		offset BF_DEFAULT_FRAMED,
		offset VSYNC
	
	INVOKE ClipText, offset TXT_LOGO, LQ_LOGO, 1, 16
	INVOKE ClipText, offset TXT_TITLE_MIDDLE, LQ_TITLE_MIDDLE, 9, 29
	INVOKE ClipText, offset TXT_AUTHORS, LQ_AUTHORS, 16, 4
	
	call Clrscr
	mov edx, offset VSYNC
	call WriteString

TitleWaitAction:

	call ReadKey
	
	cmp dx, VK_ESCAPE
	je TitleFinish

	cmp dx, VK_F1
	je TitleGoHelp

	cmp dx, 31h
	je TitleGoEasy

	cmp dx, 32h
	je TitleGoNormal

	cmp dx, 31h
	je TitleGoHard

	INVOKE WaitStep
	jmp TitleWaitAction

TitleGoEasy:
	INVOKE Game, offset LEVEL_EASY, offset META_EASY
	INVOKE MedalScreen, PTS_TOTAL_EASY
	jmp TitleStart
TitleGoNormal:
	INVOKE Game, offset LEVEL_NORMAL, offset META_NORMAL
	INVOKE MedalScreen, PTS_TOTAL_NORMAL
	jmp TitleStart

TitleGoHard:
	INVOKE Game, offset LEVEL_HARD, offset META_HARD
	INVOKE MedalScreen, PTS_TOTAL_HARD
	jmp TitleStart

TitleGoHelp:
	INVOKE HelpScreen
	jmp TitleStart

TitleFinish:
	ret
TitleScreen ENDP

CaptureLevel PROC USES eax	
CaptureLevelLoop:
	INVOKE WaitStep
	call ReadKey

	cmp al, VK_ESCAPE
	jz CaptureLevelFinish

	cmp al, 0
	jnz HaveBrick

	mov eax, 0
	call WriteDec
	jmp CaptureLevelLoop

HaveBrick:
	mov eax, 1
	call WriteDec
	jmp CaptureLevelLoop

CaptureLevelFinish:	 
	call ReadChar
	ret
CaptureLevel ENDP

main PROC
	; Starts frame-sync timer
	call GetMseconds
	mov LAST_STEP, eax

	; Get rid of CURSOR
	INVOKE HideCursor

	; First screen
	INVOKE TitleScreen

	; Bye
	exit
main ENDP

END main