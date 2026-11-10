# gcc 13.2 x86-64, -O0   （取自 Compiler Explorer 实际编译结果）
matmul(int (*) [3], int (*) [3], int (*) [3]):
        push    rbp
        mov     rbp, rsp
        mov     QWORD PTR [rbp-24], rdi
        mov     QWORD PTR [rbp-32], rsi
        mov     QWORD PTR [rbp-40], rdx
        mov     DWORD PTR [rbp-4], 0
        jmp     .L2
.L7:
        mov     DWORD PTR [rbp-8], 0
        jmp     .L3
.L6:
        mov     eax, DWORD PTR [rbp-4]
        movsx   rdx, eax
        mov     rax, rdx
        add     rax, rax
        add     rax, rdx
        sal     rax, 2
        mov     rdx, rax
        mov     rax, QWORD PTR [rbp-40]
        add     rdx, rax
        mov     eax, DWORD PTR [rbp-8]
        cdqe
        mov     DWORD PTR [rdx+rax*4], 0
        mov     DWORD PTR [rbp-12], 0
        jmp     .L4
.L5:
        mov     eax, DWORD PTR [rbp-4]
        movsx   rdx, eax
        mov     rax, rdx
        add     rax, rax
        add     rax, rdx
        sal     rax, 2
        mov     rdx, rax
        mov     rax, QWORD PTR [rbp-40]
        add     rdx, rax
        mov     eax, DWORD PTR [rbp-8]
        cdqe
        mov     esi, DWORD PTR [rdx+rax*4]
        mov     eax, DWORD PTR [rbp-4]
        movsx   rdx, eax
        mov     rax, rdx
        add     rax, rax
        add     rax, rdx
        sal     rax, 2
        mov     rdx, rax
        mov     rax, QWORD PTR [rbp-24]
        add     rdx, rax
        mov     eax, DWORD PTR [rbp-12]
        cdqe
        mov     ecx, DWORD PTR [rdx+rax*4]
        mov     eax, DWORD PTR [rbp-12]
        movsx   rdx, eax
        mov     rax, rdx
        add     rax, rax
        add     rax, rdx
        sal     rax, 2
        mov     rdx, rax
        mov     rax, QWORD PTR [rbp-32]
        add     rdx, rax
        mov     eax, DWORD PTR [rbp-8]
        cdqe
        mov     eax, DWORD PTR [rdx+rax*4]
        imul    ecx, eax
        mov     eax, DWORD PTR [rbp-4]
        movsx   rdx, eax
        mov     rax, rdx
        add     rax, rax
        add     rax, rdx
        sal     rax, 2
        mov     rdx, rax
        mov     rax, QWORD PTR [rbp-40]
        add     rdx, rax
        add     ecx, esi
        mov     eax, DWORD PTR [rbp-8]
        cdqe
        mov     DWORD PTR [rdx+rax*4], ecx
        add     DWORD PTR [rbp-12], 1
.L4:
        cmp     DWORD PTR [rbp-12], 2
        jle     .L5
        add     DWORD PTR [rbp-8], 1
.L3:
        cmp     DWORD PTR [rbp-8], 2
        jle     .L6
        add     DWORD PTR [rbp-4], 1
.L2:
        cmp     DWORD PTR [rbp-4], 2
        jle     .L7
        nop
        nop
        pop     rbp
        ret
.LC0:
        .string "%d "
main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 144
        mov     DWORD PTR [rbp-48], 1
        mov     DWORD PTR [rbp-44], 2
        mov     DWORD PTR [rbp-40], 3
        mov     DWORD PTR [rbp-36], 4
        mov     DWORD PTR [rbp-32], 5
        mov     DWORD PTR [rbp-28], 6
        mov     DWORD PTR [rbp-24], 7
        mov     DWORD PTR [rbp-20], 8
        mov     DWORD PTR [rbp-16], 9
        mov     DWORD PTR [rbp-96], 9
        mov     DWORD PTR [rbp-92], 8
        mov     DWORD PTR [rbp-88], 7
        mov     DWORD PTR [rbp-84], 6
        mov     DWORD PTR [rbp-80], 5
        mov     DWORD PTR [rbp-76], 4
        mov     DWORD PTR [rbp-72], 3
        mov     DWORD PTR [rbp-68], 2
        mov     DWORD PTR [rbp-64], 1
        lea     rdx, [rbp-144]
        lea     rcx, [rbp-96]
        lea     rax, [rbp-48]
        mov     rsi, rcx
        mov     rdi, rax
        call    matmul(int (*) [3], int (*) [3], int (*) [3])
        mov     DWORD PTR [rbp-4], 0
        jmp     .L9
.L12:
        mov     DWORD PTR [rbp-8], 0
        jmp     .L10
.L11:
        mov     eax, DWORD PTR [rbp-8]
        movsx   rcx, eax
        mov     eax, DWORD PTR [rbp-4]
        movsx   rdx, eax
        mov     rax, rdx
        add     rax, rax
        add     rax, rdx
        add     rax, rcx
        mov     eax, DWORD PTR [rbp-144+rax*4]
        mov     esi, eax
        mov     edi, OFFSET FLAT:.LC0
        mov     eax, 0
        call    printf
        add     DWORD PTR [rbp-8], 1
.L10:
        cmp     DWORD PTR [rbp-8], 2
        jle     .L11
        mov     edi, 10
        call    putchar
        add     DWORD PTR [rbp-4], 1
.L9:
        cmp     DWORD PTR [rbp-4], 2
        jle     .L12
        mov     eax, 0
        leave
        ret
