#include "../drivers/screen.h"

void kernel_main(void)
{
	clear_screen();
	kprint("Hello World");
}
