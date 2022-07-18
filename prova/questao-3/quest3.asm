.data
	n: .word 5
	vetor: .word 32 37 95 145 13
	espaco: .asciiz " "
.text
	li $s1, 0 # utlizado como auxiliar para troca de valores
	li $s2, 0 # utlizado como auxiliar para troca de valores
	li $a1, 0 # utilizado pra percorrer os endereços no vetor para x
	li $t1, 0 # utlizado para percorrer os endereços no vetor para y
	li $k0, 0 # utilizado para salvar o menor valor atual do vetor
	li $k1, 0 # utilizado para salvar o atual valor do vetor
	li $a2, 0 # utilizado pra controlar as iterações de x
	li $a3, 1 # utilizado pra controlar as iterações de y
	lw $v1, n # utlizado pra controlar a quantidade maxima de iterações
	j percorrer_x
	
percorrer_x:
	lw $s0, vetor($a1) # carrega em $s0 o valor no endereço $a1 do vetor
	li $t1, 0 # retorna o valor de $t1 pra 0
	add $t1, $t1, 4 # soma 4 em $t1
	mul $t1, $t1, $a2 # multiplica o valor de $t1 pelo de $a2(x)
	blt $a2, $v1, percorrer_y # caso $a2 for menor que $v1, percorre y (busca o menor valor do vetor)
	beq $a2, $v1, finalizar # caso $a2 for igual $v1, finaliza a execução 
	
percorrer_y:
	lw $k0, vetor($t1) # carrega o valor no endereço $t1 do vetor para ter um valor inicial
	blt $a3, $v1, iterar_y # caso $a3 for menor que $v1, aumenta o valor de y
	beq $a3, $v1, trocar_valores # caso $a3 for igual a $v1, aumenta o valor de x
	
iterar_x:
	add $a2, $a2, 1 # adiciona 1 ao x
	move $a3, $a2 # move o valor de $a2 para $a3
	j percorrer_x 

iterar_y:
	add $a3, $a3, 1 # adiciona 1 ao y
	j verificar_menor_valor
	
verificar_menor_valor:
	add $t1, $t1, 4 # adiciona 4 em $t1 para pegar o próximo endereço do vetor
	lw $k1, vetor($t1) # carrega em $k1 o próximo valor do vetor, para a verificação
	blt $k1, $k0, menor_valor # verifica se o valor em $k1 é menor que $k0 (atual menor valor)
	j percorrer_y
	
menor_valor:
	move $k0, $k1 # move o valor de $k1 para $k0
	j percorrer_y
	
trocar_valores:
    	move $s1 ,$s0 # move o valor atual do vetor no endereço x para $s0
    	move $s2 ,$k0 # move o menor valor atual do vetor para $k0
    
    	# Realiza a troca dos valores
    	sw $s2, vetor($a1) # menor
    	sw $s1, vetor($t1) # ultimo
    
    	lw $a0, vetor($a1) # coloca o menor valor do endereço atual($a1) em $a0
    	li $v0, 1 # syscall para printar int
    	syscall
    
        li $a0, 32 # ASCII do espaço em branco (só ta funcionando assim)
        li $v0, 11 # Syscall pra printar caracter
    	syscall
    
    	add $a1, $a1, 4 # adiciona 4 em $ai para pegar o próximo endereço
        j iterar_x
	
finalizar:
	li $v0, 10 # finaliza a execução
	syscall
