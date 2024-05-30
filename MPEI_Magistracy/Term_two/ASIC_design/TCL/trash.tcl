# 1е задание
# Сформируйте запрос своих имени, фамилии и отчества, записывая их в отдельные переменные 
# firstname, middlename и lastname. Выведите в терминал свои ФИО одной переменной.

puts "What is your lastname?"
set lastname [gets stdin]
puts "What is your name?"
set firstname [gets stdin]
puts "What is your middlename?"
set middlename [gets stdin]
set lst [concat $lastname $firstname $middlename]
puts $lst
puts " "

# 2e задание
# Произведите расчёт следующих выражений, задав a - номер по журналу, 
# b - день рождения, c - месяц рождания, d - сумма цифр года рождения:
set a 6
set b 19
set c 2
set d 37
set w [expr $b-$c]
puts "w = b - c => w = $b - $c = $w"
set z [expr $w*$d]
puts "z = w * d => z = $w * $d = $z"
set f [expr $a./$z]
puts "f = a / z => f = $a / $z = $f"
puts " "

#3.1 задание 
# Сформируйте список из 10 элементов со случайными значениями от 0 до 9. Отсортируйте список 
# и выведите его элементы по отдельности. Отсортируйте список в обратном порядке.
set l {9 7 6 0 4 1 3 5 2 8}
puts "Начальный список:"
puts $l
set l [lsort $l ]
puts "отсортированный список:"
puts $l
set l [lreverse $l ]
puts "отсортированный список в обратном порядке:"
puts $l
puts " "

#3.2 задание
# Сформируйте два списка: в одном находится перечисление типов промежуточной аттестации, пройденными Вами в бакалавриате, 
# а в другом - их количество в соответствие с порядком элемента в первом списке.

set type {1t 4t 3t 2t}
set s {1s 4s 3s 2s}

puts "Список типов:"
puts $type
puts "Список количества:"
puts $s
puts " "

# 3.3 задание
# Сделайте ассоциативный массив из этих списков вида "ключ - значение" ("тип - количество"). 
# Выведите в терминал значение каждого элемента массива.

array set array1 [list \
"[lindex $type 0]" "[lindex $s 0]" \
"[lindex $type 1]" "[lindex $s 1]" \
"[lindex $type 2]" "[lindex $s 2]" \
"[lindex $type 3]" "[lindex $s 3]"]

puts "1t соответствует : $array1(1t)"
puts "2t соответствует : $array1(2t)"
puts "3t соответствует : $array1(3t)"
puts "4t соответствует : $array1(4t)"
puts " "

# 3.4 задание
# Отсортируйте массив по алфавиту.

set sorted_array [lsort $type]
set sorted_s $s

for {set i 0} {$i < [llength $sorted_array]} {incr i} {
	for {set y 0} {$y < [llength $type]} {incr y} {
	  if {[lindex $sorted_array $i] == [lindex $type $y]} {
	    set sorted_s [lreplace $sorted_s $i $i [lindex $s $y]]
	  }
	}
}

puts "Отсортированный писок типов:"
puts $sorted_array

array set array2 [list \
"[lindex $sorted_array 0]" "[lindex $sorted_s 0]" \
"[lindex $sorted_array 1]" "[lindex $sorted_s 1]" \
"[lindex $sorted_array 2]" "[lindex $sorted_s 2]" \
"[lindex $sorted_array 3]" "[lindex $sorted_s 3]"]

puts "1t соответствует : $array2(1t)"
puts "2t соответствует : $array2(2t)"
puts "3t соответствует : $array2(3t)"
puts "4t соответствует : $array2(4t)"
puts " "
# 4e задание

# Сформируйте текстовый файл с набором случайных чисел в количестве равном утроеннму значению номера года поступления без номера по журналу. 
# Прочитайте файл в переменную, отсортируйте значения и запишите в другой файл.

set str {}

for {set i 0} {$i < 100} {incr i} {
  set str [linsert $str $i [expr {double(round(100*(rand()*9)))/100}]]
}

puts "В файл no_sort будет записано: $str"

set no_sort_w [open "no_sort.txt" w+]
puts $no_sort_w $str
close $no_sort_w

set no_sort_r [open "no_sort.txt" r]
set no_sort_array [gets $no_sort_r];
close $no_sort_r

set sort_array [lsort $no_sort_array]
set sort_w [open "sort.txt" w+]

puts $sort_w $sort_array

close $sort_w
puts " "
# Задание 5.1 (Создание папок) 
# Сформируйте процедуру записи в файл значения в виде write_to_file("my_file.txt", $a).
proc file {arg1 arg2} {
    set no_sort_w [open "$arg1.txt" w+]
    puts $no_sort_w $arg2
    close $no_sort_w
}

file {1} {1}

# Задание 5.2 (Удаление папок)
# Сформируйте процедуру создания N папок и их удаления. Для этого используйте команды bash для создания mkdir и удаления папок rm -r.
proc folder_mkdir {N} {
    for {set i 0} {$i < $N} {incr i} {
    exec mkdir $i
    }
}

folder_mkdir {5}

puts "Нажмите Enter для удаления папок и txt файлов"
gets stdin

proc folder_rmdir {N} {
    for {set i 0} {$i < $N} {incr i} {
    exec rm -r $i
    }
}

folder_rmdir {5}

exec rm ./*.txt