#!/bin/bash

compil="cc -Wall -Werror -Wextra"
lib="../libasm.a"

$compil c_files/main.c -o maintest "$lib"
$compil c_files/test_atoi_base.c -o testatoi "$lib"
$compil c_files/test_read.c -o test_read "$lib"
$compil c_files/test_write.c -o test_write "$lib"
$compil c_files/test_list_push_front.c -o test_pfront "$lib"
$compil c_files/test_list_size.c -o test_lsize "$lib"
$compil c_files/test_nb_sort.c -o test_lsort "$lib"
$compil c_files/test_list_remove_if.c -o removeif "$lib"
