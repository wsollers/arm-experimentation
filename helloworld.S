
.arch armv8-a


.data

msg:
    .ascii        "Well Hello, ARM64!\n"
len = . - msg

buffer:
    .space 1024
bufflen = . - buffer


.text

/* Our application's entry point. */
.globl _start
_start:
  // return address protection
  //pacibsp

  
  bl WRITE_SYSOUT




  bl EXIT_PROGRAM

_strcpy:
//char* strcpy(char* destination, const char* source);




WRITE_SYSOUT:
  // Store the Link Register (x30 == lr) and frame pointer (x29 == fp)
  // on to the stack
  stp     fp, lr, [sp,#-16]!
  // Equivalent to: stp     x29, x30, [sp, -#16]!
  mov     fp, sp

  // To call write() we need our character in memory so let's put
  // it on the stack
  //strb    w0, [sp,#-16]!
  sub     sp, sp, #16
    /* syscall write(int fd, const void *buf, size_t count) */
    mov     x0, #1      /* fd := STDOUT_FILENO */
    ldr     x1, =msg    /* buf := msg */
    ldr     x2, =len    /* count := len */
    mov     x8, #64     /* write is syscall #64 */
    svc     #0          /* invoke syscall */
    //autibsp                         // validate return address
    mov     sp, fp
    ldp     fp, lr, [sp], #16
    ret

EXIT_PROGRAM:
    /* syscall exit(int status) */
    mov     x0, #0      /* status := 0 */
    mov     x8, #93     /* exit is syscall #93 */
    svc     #0          /* invoke syscall */
    ret                 /* we should never return! */

