.set vw_layout, function vw_layout(row_step, element_stride, offset) { return (offset | 0xa00 | row_step << 12 | element_stride << 20); } vw_layout
.set vw_setup0, function vw_setup0(x, y) { return (2<<30|y<<23|x<<16); } vw_setup0
.set vw_setup1, function vw_setup1(x, y) { return (3<<30|x<<16|y); } vw_setup1

.global entry
.global exit

entry:
	# Determine if this QPU will signal on completion (flag is from uniforms)
	mov rb3, unif

	# Configure access to vpm
	ldi vw_setup, vw_layout(1, 1)

	# Write 5x16 words into vpm
	mov vpm, 1
	mov vpm, 2
	mov vpm, 4
	mov vpm, 8
	mov vpm, elem_num

	# Configure vpm write to memory
	ldi vw_setup, vw_setup0(5, 16)
	ldi vw_setup, vw_setup1(0, 0)

	# Trigger transfer to destination in memory (address is from uniforms)
	nop; mov vw_addr, unif

	# Wait for vpm transfer to finish
	mov.never -, vw_wait

exit:
	# Signal done
	mov irq, rb3
	nop; nop; thrend
	nop
	nop
