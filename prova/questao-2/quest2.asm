.data
	n: .word 7
	vetor: .word 1 37 13 3 57 12 4
.text
	li $a1, 0 # utilizado pra percorrer os endereços no vetor
	lw $s1, vetor($a1) # carrega em $s1 o valor no endereço $a1 do vetor
	li $a3, 1 # utilizado pra controlar as iterações
	li $s0, 0 # utilizado pra armazenar o maior valor atual do vetor
	lw $v1, n # utlizado pra controlar a quantidade maxima de iterações
	j percorrer_vetor
percorrer_vetor:
	bgt $s0, $s1 ,maior_valor # caso o valor de $s0 for maior que o de $s1, o de $s1 é substituido
	blt $a3, $v1, iterar #  caso o valor de a3 não supere o de $v1, itera
	beq $a3, $v1, finalizar # caso o valor de $a3 se iguale ao de $v1, finaliza a execução
iterar:
	add $a3, $a3, 1 # adiciona 1 em $a3 para uma nova iteração
	add $a1, $a1, 4 # adiciona 4 em $a1 para pegar o próximo endereço de valor inteiro no vetor
	j valor_endereco_vetor
valor_endereco_vetor:
	lw $s0, vetor($a1) # carrega em $s0 o valor que está na posição $a1 do vetor
	j percorrer_vetor
maior_valor:
	move $s1, $s0 # move o valor de $s0 (maior valor) para $s1
	j percorrer_vetor
finalizar:
	move $a0, $s1 # move o valor de $s2 pro registrador $a0
	li $v0, 1 # carrega 1 em $v0 pra printar o int que está em $a0
	syscall
