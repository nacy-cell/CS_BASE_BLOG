---
title: "第五章 [BX]和Loop指令"  
date: 2025-10-24 18:46:15
categories: 
  - 汇编语言
---

## 约定

[BX]：指偏移地址为（BX）的内存单元。

LOOP循环指令

（ ）：指内容

用idata表示常量（立即数）

## [BX]

* EA：偏移地址
* SA：段地址
* PA：物理地址

我们常用[BX]来提供内存单元的偏移地址，通过修改BX的值，可由DS：[BX]来寻址不同地址的内存单元。

## 循环控制指令LOOP

格式：LOOP          标号           ；CX≠0循环
功能：当CX≠0时，（CX）=（CX）－1；转移到标号处循环执行。

计算2^12^

```nasm
assume cs:code,ds:data
data segment 
    res dw 0
data ends

code segment
start:
  mov ax, data
  mov ds, ax
  mov cx, 000ch
  mov ax, 0001h
s: 
  add ax, ax
  loop s
  mov res, ax
  mov ax, 4c00h
  int 21h
code ends
end start
```

CX和LOOP指令配合实现循环功能的三个要点：
1、在CX中存放循环次数
2、LOOP指令中的标号所标识地址要在前面
3、要循环执行的程序段写在标号和LOOP指令之间。

## DEBUG和汇编编译器MASM对指令的不同处理

DEBUG中我们可以使用下面指令来读写内存：

```nasm
MOV AX，[0]
MOV AL，[2]
MOV BX，[1234H]
```

但在汇编程序中只能使用[寄存器]来寻址内存：
`MOV AX，[BX]`
在汇编编译器处理中，
`MOV   AX，[1234H]`=  `MOV AX，1234H`

## LOOP和[BX]的联合使用

计算：FFFF：0—FFFF：B单元中的数据的和，结果保存在DX中

```nasm
assume cs:code
code segment
start:
  mov ax ,0ffffh
  mov ds ,ax
  mov bx, 0h 
  mov cx ,0ch
  mov dx, 0
  mov ah, 0
s:
  mov al, ds:[bx]
  add bx, 1h
  add dx, ax
  loop s
  mov ax, 4c00h
  int 21h
code ends 
end start
```

## 段前缀

在访问内存单元的指令中，用于显式地指明内存单元的段地址的“**段寄存器：**”，在汇编语言中称为段前缀。

## 一段安全的空间

汇编语言程序直接面向机器，如果我们要向内存空间写入数据时，要保证所写入的内存中没有重要的数据，否则会影响系统的正常运行，在一般的PC机中都不使用0：200—0：300这段内存空间，所以我们可以放心使用这段安全的空间。

## 段前缀的使用

编程将内存FFFF:0—FFFF:B单元中的数据拷贝到0:200—0:20B单元中

```nsam
assume cs:code
code segment
start:
    mov ax, 0FFFFH   
    mov ds, ax       

    mov ax, 0H       
    mov es, ax      

    mov si, 0        
    mov di, 200H     
    mov cx, 0CH      

copy_loop:

    mov al, ds:[si]  
    mov es:[di], al 

    inc si          
    inc di           
    loop copy_loop   

    mov ax, 4C00H
    int 21H
code ends
end start
```