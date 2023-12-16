%define STDIN 0;    
%define STDOUT 1;    
%define SYS_WRITE  0x01
%define SYS_READ   0x00

section .data
    
    msg_1 db 'Input variables:', 0xa, 0
    len_1 equ $ - msg_1

    msg_2 db 'a = ', 0
    len_2 equ $ - msg_2

    msg_3 db 'b = ', 0
    len_3 equ $ - msg_3
    
    msg_4 db 'Answer:', 0xa, 0
    len_4 equ $ - msg_4

    msg_5 db 0xa, 'Es ist Scheiße passiert!', 0xa
    len_5 equ $ - msg_5
    

    len_inp db 7                
    len_out db 12               
    len_cur db 0                
    sign db 0                   
    
    buffer times 12 db 0        
    
    a dw 0
    b dw 0
    res dd 0

section .text
global _start


_start:
    ;   Вывод 1-го сообщения
    mov rsi, msg_1              
    mov rdx,len_1               
    call write
    
    ;
    ;   Вывод 2-го сообщения
    mov rsi, msg_2
    mov rdx, len_2
    call write
    
    ;
    ;   Ввод a
    call read
    call to_int                 ;   преобразовать 'a' в число
    mov word [a], ax            ;    тогда 'a'
    call test
    call buffer_cl              ;   очистка буфера
    
    ;
    ;   Вывод 3-го сообщения
    mov rsi, msg_3
    mov rdx,len_3
    call write
    
    ;
    ;   Ввод b
    call read
    call to_int
    mov word [b], ax            ;    тогда 'b'
    call test
    call buffer_cl
    
    ;
    ;   Рассчет значений
    call culculate              ;    тогда 'res'
    call to_str                 ;   преобразовать 'res' в строку
    
    ;
    ;   Вывод результата
    mov rsi, buffer
    mov dl, byte [len_cur]
    call write

    ;
    ;   Выод из программы
    call exit



test:
    ret

;   Функция вывода
write:
    mov rax, SYS_WRITE  ;   sys_write()
    mov rdi, STDOUT     ;   file descriptor (stdout)
    syscall
    ret


;   Функция ввода
read:
    mov eax, SYS_READ   ;   sys_read()
    mov rdi, STDIN      ;   file descriptor (stdin)
    mov rsi, buffer     ;   message to write
    mov edx, len_inp    ;   message length
    syscall             ;   execute read(0, buffer, buf_size)
    dec al
    mov byte [len_cur], al
    ret


;   Очистка буфера
buffer_cl:
    xor ecx, ecx
    mov cl, byte [len_cur]
    mov eax, 0
    clear:
        mov byte [buffer + eax], ''
        inc eax
        loop clear
    mov byte [len_cur], 0
    ret
;   Функции преобраования в число
to_int:
    mov byte [sign], 0
    mov edx, 0                  ;   edx тогда адрес строки
    mov bl, [buffer + edx]       ;   bl  тогда первый символ строки
    cmp bl,'-'
    jne int_no_sign
    inc edx                     ;   '+' адрес строки
    dec al                      ;   '-' длина строки
    mov byte [len_cur], al
    mov byte [sign], 1 
    
int_no_sign:
    xor ecx, ecx
    mov di,10                   ;   di тогда мноитель
    mov cl, [len_cur]           ;   cx тогда счётчик цикла
    ;   jecxz studw_error          ;   длина = 0 тогда ошибка
    
    xor rax,rax
    xor rbx,rbx
    
next_symb:
        mov bl, [buffer + edx]  ;   bl тогда символ строки
        inc edx                 ;   '+' адрес
        cmp bl,'0'
        jl error                ;   код символа < '0' тогда ошибка
        cmp bl,'9'
        jg error                ;   код символа > '9' тогда ошибка
        sub bl,'0'              ;   преобразование в число
        push rdx
        mul di                  ;   ax тогда ax * 10
        pop rdx
        jc error              ;   результат > 2^16  тогда ошибка
        add ax, bx
        jc error              ;   переполнение      тогда ошибка
    loop next_symb              ;   цикл
    mov dl, byte [sign]
    test dl, dl
    jz int_plus
    cmp ax, 32768              ;   модуль отр.числа  <= 32768
    ja error                  ;   больше            тогда ошибка
    neg ax
    ret
    
int_plus:
    cmp ax,32767              ;   пол.число  <= 32767
    ja error                    ;   больше            тогда ошибка
    ret


;   Функции преобраования в строку
to_str:
    mov byte [sign], 0
    mov eax, dword [res]
    mov ecx, 0
    test eax, eax               ;   проверка знака
    mov ebx, 10
    jns str_no_sign
    mov byte [sign], 1          ;   добавление знака
    neg eax
str_no_sign:
    xor edx, edx            ;   обнуление старшей части двойного слова
    div ebx                    ;   edx:eax / ebx
    add dx,'0'                ;   преобразование в код символа
    push dx                    ;   сохранение в стек
    inc ecx
    test eax, eax            ;   проверка AX
    jnz str_no_sign             ;   частное не 0 тогда икл
if_sing_str:
    mov dl, byte [sign]
    test dl, dl
    jz str
    mov byte [buffer + eax], '-'
    inc eax
str:                        ;   икл из стека
    pop dx
    mov byte [buffer + eax],dl
    inc eax                    ;   '+' адрес буфера
    loop str
    mov byte [buffer + eax], 0x0a
    inc eax
    mov byte [len_cur], al
    ret


;   Функция вывода ошибки   
error:
    mov rsi, msg_5
    mov rdx,len_5
    call write
    call exit
    

;   Функция выода из прораммы
exit:
    mov ebx, 0
    mov rax,60                  ;   sys_exit()
    syscall
    
    

culculate:
    mov rbp, rsp; for correct debugging
    ; Сравниваем a и b  
    mov ax, word [a]
    cmp ax, word [b]

    ; Применяем условный переход для каждого условия
    jg a_greater_than_b
    je a_equals_b
    jl a_less_than_b ; поставить флаг вместо l

a_greater_than_b:
    xor edx, edx
    cwd
    div word [a]
    mov ax, dx
    add ax, 1
    mov word [res], ax
    ret

a_equals_b:
    ; Результат = 0
    mov dword [res], 11
    ret

a_less_than_b:
    xor rax, rax
    xor rbx, rbx
    xor rdx, rdx
    mov ax, [a]
    imul ax
    mov bx, [b]
    idiv bx
    mov [res], eax  ; сохраняем 64-битный результат
ret
