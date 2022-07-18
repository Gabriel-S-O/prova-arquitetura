.data
	n: .word 7 
	vetor: .word 1 4 9 16 25 36 49 # vetor com os quadrados perfeitos até n (definido como 7)
	separador: .asciiz " - " 
	quebrar_linha: .asciiz "\n"
.text
	lw $t0, n # carrega o valor de N no registrador t0
	li $a1, 1
	ble $a1, $t0, imprimir
imprimir:
	move $a0, $a1 # carrega o valor do registrador a1 no registrador a0
	li $v0, 1 # carrega 1 no registrador v0 pra usar a syscall de printar int
	syscall
	
	la $a0, separador # carrega o endereço do separador no registrador a0
	li $v0, 4 # carrega 4 no registrador v0 pra usar a syscall de printar string
	syscall
	
	lw $a3, vetor ($a2)
	add $a2, $a2, 4
	
	move $a0, $a3
	li $v0, 1
	syscall
	
	la $a0, quebrar_linha # carrega o endereço de quebrar_linha no registrador a0
	li $v0, 4 # carrega 4 no registrador v0 pra usar a syscall de printar string
	syscall
	
	j iterar
iterar:
	add $a1, $a1, 1
	ble $a1, $t0, imprimir
