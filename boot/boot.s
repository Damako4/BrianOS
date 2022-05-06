.equ ALIGN,   1<<0
.equ MEMINFO, 1<<1
.equ FLAGS,   ALIGN | MEMINFO
.equ MAGIC,   0x1BADB002
.equ CHECKSUM,-(MAGIC + FLAGS)

.section .multiboot
.align 4
.long MAGIC 
.long FLAGS
.long CHECKSUM

.section .bss
.align 16
stack_bottom:
.skip 16384
stack_top:

.section .text
.global _start
.type _start, @function
_start:
  mov $stack_top, %esp  
  mov $stack_bottom, %ebp  

  call kernel_main
halt:
  hlt
  jmp halt
