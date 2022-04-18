global my_strcpy

section .text
my_strcpy:
    mov rcx, rdx  ;_strcopy(rdi, rsi, rdx)

    cmp rdi, rsi ; src == dst ? quit : not_equal()
    jne not_equal
    jmp quit

not_equal: ; строки не перекрываются
    cmp rdi, rsi ; rdi < rsi == dst string < src string
    jl simple_copy

    mov rax, rdi
    sub rax, rsi

    cmp rax, rcx
    jge simple_copy

complicated_copy: ; строки перекрываются
    add rdi, rcx ; смещаемся на длину и копируем с конца
    add rsi, rcx
    dec rsi
    dec rdi
    std ; df = 1

simple_copy:
    rep movsb ; from rsi to rdi while df==0  len == rcx раз
    cld ; df = 0
quit:
    ret