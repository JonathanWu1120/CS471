	.file	"powR.c"
	.text
	.globl	powR
	.type	powR, @function
powR:
.LFB0:
	.cfi_startproc
	pushq	%rbp	//push frame pointer (Beginning of frame)
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp //Set current frame by adding stack pointer
	.cfi_def_cfa_register 6
	subq	$16, %rsp // Move end of frame 16 bytes down (Allocation)
	movl	%edi, -4(%rbp) //Put argument 1 (pow) into the stack
	movl	%esi, -8(%rbp) //Put argument 2 (base) into the stack
	cmpl	$0, -4(%rbp) //Compare 0 with pow
	jne	.L2 //Jump to .L2 if true
	movl	$1, %eax //Set 1 as the return value 
	jmp	.L3 //Jump to L3 and finish
.L2:
	movl	-4(%rbp), %eax //Move pow into eax, var1
	leal	-1(%rax), %edx //Puts the address of pow - 1 into edx (the pow-1 in powerR(pow-1,base))
	movl	-8(%rbp), %eax //Puts base into eax
	movl	%eax, %esi //Puts eax on the stack for the recursive call 
	movl	%edx, %edi //Puts edx on the stack for the recursive call
	call	powR //Calls powerR again with the new parameters
	imull	-8(%rbp), %eax //Multiplies base (eax) with the recursive call result
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	powR, .-powR
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
