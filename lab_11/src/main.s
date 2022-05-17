global main

; Цикл событий GTK+
extern gtk_init, gtk_main, gtk_main_quit

; Класс GtkWindow
extern gtk_window_new

; Класс GtkEntry
extern gtk_entry_new, gtk_entry_get_text

; Класс GtkLabel
extern gtk_label_new, gtk_label_set_text

; Класс GtkButton
extern gtk_button_new_with_label

; Класс GtkBox
extern gtk_box_new, gtk_box_pack_start

; Класс GtkContainer
extern gtk_container_add

; Класс GtkWidget
extern gtk_widget_show_all

; Сигнал GObject
extern g_signal_connect_data

section .data

szResultLabel  db "       ", 0 ; Метка вывода
szButtonLabel  db "Сложить", 0 ; Метка кнопки

szEventClicked db "clicked", 0 ; Имя события нажатия на кнопку
szEventDestroy db "destroy", 0 ; Имя события завершения

section .bss

hWindow resq 1 ; Главное окно
hAEntry resq 1 ; Поле ввода A
hBEntry resq 1 ; Поле ввода B
hCLabel resq 1 ; Метка вывода
hButton resq 1 ; Кнопка
hLayout resq 1 ; Компоновщик

lpAText resq 1 ; Текст поля A
lpBText resq 1 ; Текст поля B

section .text

main: ; Точка входа

    push rbp
    mov  rbp, rsp

    ; Инициализируем GTK+

    sub  rsp, 0x20

    mov  [rbp - 0x14], rdi
    mov  [rbp - 0x20], rsi

    lea  rdi, [rbp - 0x14]
    lea  rsi, [rbp - 0x20]

    call gtk_init

    ; Создаём главное окно

    mov  rdi, 0x0
    call gtk_window_new
    mov  [hWindow], rax

    ; Создаём поле A

    call gtk_entry_new
    mov  [hAEntry], rax

    ; Создаём поле B

    call gtk_entry_new
    mov  [hBEntry], rax

    ; Создаём метку C

    mov  rdi, szResultLabel

    call gtk_label_new
    mov  [hCLabel], rax

    ; Создаём кнопку

    mov  rdi, szButtonLabel
    call gtk_button_new_with_label
    mov  [hButton], rax

    ; Создаём компоновщик

    mov  rdi, 0x01
    mov  rsi, 0x14

    call gtk_box_new

    mov  [hLayout], rax

    ; Компонуем интерфейс

    mov  rdi, [hLayout]
    mov  rsi, [hAEntry]

    mov  rdx, 0x0
    mov  rcx, 0x0
    mov   r8, 0x0

    call gtk_box_pack_start

    mov  rdi, [hLayout]
    mov  rsi, [hBEntry]

    mov  rdx, 0x0
    mov  rcx, 0x0
    mov   r8, 0x0

    call gtk_box_pack_start

    mov  rdi, [hLayout]
    mov  rsi, [hButton]

    mov  rdx, 0x0
    mov  rcx, 0x0
    mov   r8, 0x0

    call gtk_box_pack_start

    mov  rdi, [hLayout]
    mov  rsi, [hCLabel]

    mov  rdx, 0x0
    mov  rcx, 0x0
    mov   r8, 0x0

    call gtk_box_pack_start

    ; Привязываем компоновщик

    mov  rdi, [hWindow]
    mov  rsi, [hLayout]

    call gtk_container_add

    ; Назначаем обработчик нажатия на кнопку

    mov  rdi, [hButton]

    mov  rsi, szEventClicked
    mov  rdx,   eventClicked

    mov  rcx, 0x0
    mov   r8, 0x0
    mov   r9, 0x0

    call g_signal_connect_data

    ; Назначаем обработчик завершения

    mov  rdi, [hButton]

    mov  rsi, szEventDestroy
    mov  rdx, gtk_main_quit

    mov  rcx, 0x0
    mov   r8, 0x0
    mov   r9, 0x0

    call g_signal_connect_data

    ; Отображаем главное окно

    mov  rdi, [hWindow]
    call gtk_widget_show_all

    ; Запускаем цикл событий

    call gtk_main

    ; Выходим из функции

    add  rsp, 0x20
    mov  rax, 0x00

    leave
    ret

eventClicked: ; Обработчик нажатия на кнопку

    push rbp
    mov  rbp, rsp

    ; Читаем текст поля A

    mov  rdi, [hAEntry]
    call gtk_entry_get_text
    mov  [lpAText], rax

    ; Читаем текст поля B

    mov  rdi, [hBEntry]
    call gtk_entry_get_text
    mov  [lpBText], rax

    ; Складываем цифры

    xor  rcx, rcx

    mov  rax, [lpAText]
    mov  rbx, [lpBText]

    add  rcx, [rax]
    add  rcx, [rbx]

    sub  rcx, '0'

    mov  [szResultLabel], rcx

    ; Пишем сумму в метку

    mov  rdi, [hCLabel]
    mov  rsi, szResultLabel

    call gtk_label_set_text

    ; Выходим из функции

    leave
    ret
