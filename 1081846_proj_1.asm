.globl main
.data
         input:     .string"Input a number:\n"
         output:    .string"The damage:\n"
         endl:      .string"\n"
.text
main:
          addi s1, x0, 5
          addi s2, x0, 21
          addi s3, x0, 11
          addi s4, x0, 2
          addi s5, x0, 1
          la a0, input
          li a7, 4
          ecall
          li a7, 5
          ecall
          jal ra, f          
          beq x0, x0, end
f:
          addi sp, sp, -16 #f
          sw ra, 8(sp)
          sw a0, 0(sp)
          bge a0, s2, c1 # x>=21
          bge a0, s3, c2 # 11<=x<=20
          bge a0, s4, c3 # 2<=x<=10
          beq a0, s5, c4 # x==1
          beq a0, x0, c5 # x==0
          addi a0, x0, -1 # other case
		  addi sp,sp, 16
          jalr x0, 0(ra)
c1:
          div a0, a0, s1
          jal ra, f
          addi t0, a0, 0          
          lw a0, 0(sp)
		  lw  ra, 8(sp)
          addi sp, sp, 16
          slli a0, a0, 1 # n*2
          add, a0, a0, t0
          jalr x0, 0(ra)
c2:
          addi a0, a0, -2 
          jal ra, f
          addi t0, a0, 0
          lw a0, 0(sp)
          addi a0, a0, -3
		  sw t0 ,0(sp) # 左值存入
          jal ra, f
		  lw t0,0(sp) # 左值存出
          add a0, a0, t0
          lw ra, 8(sp)
          addi, sp, sp, 16
          jalr x0, 0(ra)
c3:
          addi a0, a0, -1
          jal ra, f
          add t0, x0, a0
          lw a0, 0(sp)
          addi a0, a0, -2
          sw t0, 0(sp)
          jal ra, f
          lw t0,0(sp)
          add a0, a0, t0
          lw ra, 8(sp)
          addi, sp, sp, 16
          jalr x0, 0(ra)
c4:
          add a0, x0, s1
          addi sp, sp, 16
          jalr x0, 0(ra)
c5:
          add a0, x0, s5
          addi sp, sp, 16
          jalr x0, 0(ra)
end:
		  mv t0 ,a0
          la a0, output
          li a7, 4
          ecall
		  mv a0 ,t0
		  li a7,1
		  ecall
          li a7, 10
          ecall
