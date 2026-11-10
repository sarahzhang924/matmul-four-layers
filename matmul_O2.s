# gcc 13.2 x86-64, -O2   （取自 Compiler Explorer 实际编译结果）
matmul(int (*) [3], int (*) [3], int (*) [3]):
        push    r12
        lea     r11, [rdi+12]
        xor     r12d, r12d
        push    rbp
        mov     rbp, rsi
        push    rbx
        lea     rbx, [rsi+12]
.L2:
        mov     r10, rbp
        mov     r9, rdx
.L4:
        mov     DWORD PTR [r9], 0
        mov     r8, r10
        mov     rax, rdi
        xor     esi, esi
.L3:
        mov     ecx, DWORD PTR [rax]
        imul    ecx, DWORD PTR [r8]
        add     rax, 4
        add     r8, 12
        add     esi, ecx
        mov     DWORD PTR [r9], esi
        cmp     rax, r11
        jne     .L3
        add     r10, 4
        add     r9, 4
        cmp     r10, rbx
        jne     .L4
        add     r12, 3
        add     rdi, 12
        lea     r11, [rax+12]
        add     rdx, 12
        cmp     r12, 9
        jne     .L2
        pop     rbx
        pop     rbp
        pop     r12
        ret
.LC4:
        .string "%d "
main:
        push    rbp
        push    rbx
        sub     rsp, 152
        movdqa  xmm0, XMMWORD PTR .LC0[rip]
        lea     rdx, [rsp+96]
        lea     rsi, [rsp+48]
        mov     rdi, rsp
        mov     DWORD PTR [rsp+32], 9
        movaps  XMMWORD PTR [rsp], xmm0
        movdqa  xmm0, XMMWORD PTR .LC1[rip]
        lea     rbx, [rsp+96]
        lea     rbp, [rsp+132]
        mov     DWORD PTR [rsp+80], 1
        movaps  XMMWORD PTR [rsp+16], xmm0
        movdqa  xmm0, XMMWORD PTR .LC2[rip]
        movaps  XMMWORD PTR [rsp+48], xmm0
        movdqa  xmm0, XMMWORD PTR .LC3[rip]
        movaps  XMMWORD PTR [rsp+64], xmm0
        call    matmul(int (*) [3], int (*) [3], int (*) [3])
.L11:
        mov     esi, DWORD PTR [rbx]
        mov     edi, OFFSET FLAT:.LC4
        xor     eax, eax
        add     rbx, 12
        call    printf
        mov     esi, DWORD PTR [rbx-8]
        mov     edi, OFFSET FLAT:.LC4
        xor     eax, eax
        call    printf
        mov     esi, DWORD PTR [rbx-4]
        mov     edi, OFFSET FLAT:.LC4
        xor     eax, eax
        call    printf
        mov     edi, 10
        call    putchar
        cmp     rbp, rbx
        jne     .L11
        add     rsp, 152
        xor     eax, eax
        pop     rbx
        pop     rbp
        ret
.LC0:
        .long   1
        .long   2
        .long   3
        .long   4
.LC1:
        .long   5
        .long   6
        .long   7
        .long   8
.LC2:
        .long   9
        .long   8
        .long   7
        .long   6
.LC3:
        .long   5
        .long   4
        .long   3
        .long   2
