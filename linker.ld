ENTRY(_start)

SECTIONS
{
  . = 1M; /* Where kernel is being loaded, begin sections here */
  
  /* First put multiboot header and then .text section */
  .text BLOCK(4K) : ALIGN(4K)
  {
    *(.multiboot)
    *(.text)
  }
  
  /* Read-only data */
  .rodata BLOCK(4K) : ALIGN(4K)
  {
    *(.rodata)
  }

  /* Read-write data, initialized */
  .data BLOCK(4K) : ALIGN(4K)
  {
    *(.data)
  }

  /* Read-write data, uninitialized and stack */
  .bss BLOCK(4K) : ALIGN(4K)
  {
    *(COMMON)
    *(.bss)
  }
}
