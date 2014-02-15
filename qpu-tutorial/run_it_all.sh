grep "/\*.*\:" shader_256.s | cut -d "*" -f 2 | cut -d ":" -f 2 > shader_orig.bin
nodejs qpuasm.js shader_256.s > shader_256_compile_run2.s
python extract_bin_from_compiled.py shader_256_compile_run2.s > compile_res.txt
diff -wu shader_orig.bin compile_res.txt > compile_issues.txt
