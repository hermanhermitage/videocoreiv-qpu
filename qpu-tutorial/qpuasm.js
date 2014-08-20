// qpuasm.js"
//  requires node to run.
//
// To install node:
//  (debian) apt-get install nodejs
//  other, down from http://nodejs.org/download/
//
// To run:
//  node[js] qpuasm [--showbits] [--dumpglobals] [--dumpsymbols] [--verbose] [--in=]filename

var module;

var assemble = (function(module){
	var acc_names = mkEnum([
					"r0", "r1", "r2", "r3", "r4", "r5"
	]);
	
	var banka_r = mkEnum([
					"ra0", "ra1", "ra2", "ra3", "ra4", "ra5", "ra6", "ra7",
					"ra8", "ra9", "ra10", "ra11", "ra12", "ra13", "ra14", "ra15",
					"ra16", "ra17", "ra18", "ra19", "ra20", "ra21", "ra22", "ra23",
					"ra24", "ra25", "ra26", "ra27", "ra28", "ra29", "ra30", "ra31",
					"unif", "ra33", "ra34", "vary", "ra36", "ra37", "elem_num", "-",
					"ra40", "x_coord", "ms_mask", "ra43", "ra44", "ra45", "ra46", "ra47",
					"vpm", "vr_busy", "vr_wait", "mutex", "ra52", "ra53", "ra54", "ra55",
					"ra56", "ra57", "ra58", "ra59", "ra60", "ra61", "ra62", "ra63",
	]);
	banka_r['w'] = banka_r['ra15'];
	
	var bankb_r = mkEnum([
					"rb0", "rb1", "rb2", "rb3", "rb4", "rb5", "rb6", "rb7",
					"rb8", "rb9", "rb10", "rb11", "rb12", "rb13", "rb14", "rb15",
					"rb16", "rb17", "rb18", "rb19", "rb20", "rb21", "rb22", "rb23",
					"rb24", "rb25", "rb26", "rb27", "rb28", "rb29", "rb30", "rb31",
					"unif", "rb33", "rb34", "vary", "rb36", "rb37", "qpu_num", "-",
					"rb40", "y_coord", "rev_flag", "rb43", "rb44", "rb45", "rb46", "rb47",
					"vpm", "vw_busy", "vw_wait", "mutex", "rb52", "rb53", "rb54", "rb55",
					"rb56", "rb57", "rb58", "rb59", "rb60", "rb61", "rb62", "rb63",
	]);
	bankb_r['z'] = bankb_r['rb15'];
	
	var banka_w = mkEnum([
					"ra0", "ra1", "ra2", "ra3", "ra4", "ra5", "ra6", "ra7",
					"ra8", "ra9", "ra10", "ra11", "ra12", "ra13", "ra14", "ra15",
					"ra16", "ra17", "ra18", "ra19", "ra20", "ra21", "ra22", "ra23",
					"ra24", "ra25", "ra26", "ra27", "ra28", "ra29", "ra30", "ra31",
					"r0", "r1", "r2", "r3", "tmurs", "r5quad", "irq", "-",
					"unif_addr", "x_coord", "ms_mask", "stencil", "tlbz", "tlbm", "tlbc", "tlbam",
					"vpm", "vr_setup", "vr_addr", "mutex", "recip", "recipsqrt", "exp", "log",
					"t0s", "t0t", "t0r", "t0b", "t1s", "t1t", "t1r", "t1b",
	]);
	banka_w['w'] = banka_w['ra15'];
	
	var bankb_w = mkEnum([
					"rb0", "rb1", "rb2", "rb3", "rb4", "rb5", "rb6", "rb7",
					"rb8", "rb9", "rb10", "rb11", "rb12", "rb13", "rb14", "rb15",
					"rb16", "rb17", "rb18", "rb19", "rb20", "rb21", "rb22", "rb23",
					"rb24", "rb25", "rb26", "rb27", "rb28", "rb29", "rb30", "rb31",
					"r0", "r1", "r2", "r3", "tmurs", "r5rep", "irq", "-",
					"unif_addr_rel", "y_coord", "rev_flag", "stencil", "tlbz", "tlbm", "tlbc", "tlbam",
					"vpm", "vw_setup", "vw_addr", "mutex", "recip", "recipsqrt", "exp", "log",
					"t0s", "t0t", "t0r", "t0b", "t1s", "t1t", "t1r", "t1b",
	]);
	bankb_w['z'] = bankb_w['rb15'];
	
	var addops = mkEnum([
				 "nop", "fadd", "fsub", "fmin", "fmax", "fminabs", "fmaxabs", "ftoi",
				 "itof", "addop9", "addop10", "addop11", "add", "sub", "shr", "asr",
				 "ror", "shl", "min", "max", "and", "or", "xor", "not",
				 "clz", "addop25", "addop26", "addop27", "addop28", "addop29", "v8adds", "v8subs"]);
	addops['mov'] = addops['or'];
	
	var mulops = mkEnum([
		"nop", "fmul", "mul24", "v8muld", "v8min", "v8max", "v8adds", "v8subs"
		]);
	mulops['mov'] = mulops['v8min'];
	
	var ops = mkEnum([
		"bkpt", "nop", "thrsw", "thrend", "sbwait", "sbdone", "lthrsw", "loadcv",
		"loadc", "ldcend", "ldtmu0", "ldtmu1", "loadam", "nopi", "ldi", "bra"]);
	
	var arity = mkReverseMap({
		0: ["bkpt", "nop", "thrsw", "thrend", "sbwait", "sbdone", "lthrsw", "loadcv", "loadc", "ldcend", "ldtmu0", "ldtmu1", "loadam"],
		2: ["itof", "ftoi", "not", "clz", "mov"],
	});
	
	function instructionArgumentCount(x) {
		return arity[x] >= 0 ? arity[x] : 3;
	}
	
	var cc = mkEnum([
		"never", "", "zs", "zc", "ns", "nc", "cs", "cc"
	]);
	
	var bcc = mkEnum([
					"allz", "allnz", "anyz", "anynz", "alln", "allnn", "anyn", "anynn",
					"allc", "allnc", "anyc", "anync", "cc12", "cc13", "cc14", ""
	]);
	
	var imm = mkEnum([
					"0", "1", "2", "3", "4", "5", "6", "7",
					"8", "9", "10", "11", "12", "13", "14", "15",
					"-16", "-15", "-14", "-13", "-12", "-11", "-10", "-9",
					"-8", "-7", "-6", "-5", "-4", "-3", "-2", "-1",
					"1.0", "2.0", "4.0", "8.0", "16.0", "32.0", "64.0", "128.0",
					1/256, 1/128, 1/64, 1/32, 1/16, 1/8, 1/4, 1/2,
		// are the rotators ok here? will they collide with a constant imm lookup
					" >> r5", " >> 1", " >> 2", " >> 3", " >> 4", " >> 5", " >> 6", " >> 7",
					" >> 8", " >> 9", " >> 10", " >> 11", " >> 12", " >> 13", " >> 14", " >> 15"
	]);
	
	var pack_add = mkEnum([
		"", ".16a", ".16b", ".8abcd", ".8a", ".8b", ".8c", ".8d", ".s", ".16as", ".16bs", ".8abcds", ".8as", ".8bs", ".8cs", ".8ds"
	]);
	
	var pack_mul = mkEnum([
		"", ".packm01", ".packm02", ".8abcd", ".8a", ".8b", ".8c", ".8d", ".packm08", ".packm09", ".packm10", ".packm11", ".packm12", ".packm13", ".packm14", ".packm15"
	]);
	
	var unpack_add = mkEnum([
		"", ".16a", ".16b", ".8dr", ".8a", ".8b", ".8c", ".8d"
	]);
	
	var unpack_mul = mkEnum([
		"", ".16a", ".16b", ".8dr", ".8a", ".8b", ".8c", ".8d"
	]);
	
	function mkReverseMap(o) { var r={}; for (var k in o) { if (Array.isArray(o[k])) o[k].forEach(function(v){ r[v] = k; }); else r[o[k]] = k; } return r; }
	
	function mkEnum(a) { var o={}; var n=0; a.forEach(function(i) { o[i] = n++; }); return o; }
	
	function isNumber(n) { return !isNaN(parseFloat(n)) && isFinite(n); }
	
	function toHex(n) { return '0x'+("00000000"+(n>>>0).toString(16)).slice(-8); }
	
	function rsplit(s, c) { return [''].concat(s.split(c, 2)).slice(-2); }
	function splitOnFirst(s, c) { var i = s.indexOf(c); return i<0 ? [s] : [s.substring(0, i), s.substring(i+1)]; }
	function trim(s) { return s.trim(); }
	
	function evaluateExpr(expr, vars) { try { with (vars) return eval(expr); } catch(e) { error("Error: "+e.message+" in '"+expr+"'"); return e; }; }
	
	var error;
	
	function evaluateSrc(src, symbols, error) {
		if (imm[src] == null) {
			var value = evaluateExpr(src, symbols);
			if (value instanceof Error)
				error("Error: "+value.message+" in '"+src+"'");
			else
				src = value;
		}
		return src;
	}
	
	function evaluateRaPlusOff(line, symbols) {
	// todo: absolute: br 0x100, br expr,
	// todo: relative: br +0x100, br -0x100, ra+expr, ra-expr
			var reg_val_tuple = splitOnFirst(line, "+");
			if (reg_val_tuple.length > 1 && banka_r[reg_val_tuple[0]] != null) {
		return [banka_r[reg_val_tuple[0]], evaluateExpr(reg_val_tuple[1],symbols)];
			} else if (banka_r[line] != null) {
		return [banka_r[line], 0];
			} else {
		// If its just a simple +const or -const offset by pc to allow brr -, +128 (rel) etc to be treated differentely to brr -, 124 (abs)
		if (isFinite(Number(line)))
			return [null, ((line.trim().indexOf("+")==0 || line.trim().indexOf("-")==0) ? symbols._.pc + 4*8 : 0) + Number(line)];
		return [null, evaluateExpr(line,symbols)];
			}
	
	}
	
	function fromQpuVector(vector) {
	
		var bits;
	
		if (vector.length != 16)
			error("Error: vector must have 16 values.");
		var min = 3;
		var max = -2;
		for (var i=0; i<16; i++) {
			min = Math.min(min, vector[i]);
			max = Math.max(max, vector[i]);
			if (!isNumber(vector[i]) || Math.floor(vector[i]) != vector[i])
				error("Error: vector must contain only integers between 0..3 or -2..1");
			bits |= ((vector[i] & 0x3) & 0x1) << i;
			bits |= ((vector[i] & 0x3) & 0x2) << (16+i-1);
		}
	
		if ((min<0 || max>3) && (min<-2 || max>1))
			error("Error: vector must contain only integers between 0..3 or -2..1");
		
		return [bits, max > 1 ? 0x3 : 0x1];
	}
	
	function instructionToParts(x) {
		// "op [arg1 [,arg2 [,arg3]]]" -> [op, arg1, arg2, arg3]
	
		var r = [];
		x = x.trim().replace(' ', ',');
		var lastIndex = 0;
		var nest = 0;
		for (var i=0; i<x.length; i++) {
			var c = x.charAt(i);
			if (c=='(' || c=='[' || c=='{' || c=='"')
				nest++;
			else if (c==')' || c==']' || c=='}' || c=='"')
				nest--;
			else if (c==',' && nest==0) {
				r.push(x.substring(lastIndex, i).trim());
				lastIndex = i+1;
			}
		}
		r.push(x.substring(lastIndex, i).trim());
		return r;
	}
	// console.log(instructionToParts("op a, (b,c,d), d, e"));
	
	function assemble(program, options) {
	
		options = options || {};
	
		var _ = {
			pc: 0,
			globals: {},
			options: options,
	
			".set": function(body) {
				var split = splitOnFirst(body, ',');
				var symbol = split[0];
				var expr = split[1];
				symbols[symbol] = evaluateExpr(expr, symbols);
				if (options.verbose) {
					show('/* '+symbol+' = '+symbols[symbol]+' */ /*', ".set "+body, '*/');
				}
			},
	
			".global": function(body) {
				globals[body] = 1;
			}
		};
	
		var symbols = {
			_: _
		}
	
		var globals = _.globals;
		
		function nothing() {}
	
		for (var pass=0; pass<2; pass++) {
	
		var show = pass!=1 ? nothing : console.log;
		error = pass!=1 ? nothing : function() {
			var util = require('util');
			console.log(options.in+':'+linenumber);
			console.log(util.format.apply(this, arguments));
			if (!options['ignore-errors']) process.exit(-1);
		};
	
		_.pc = options.targetaddress || 0;
		var linenumber = 0;
		var blockcomment = false;
	
		// Dump global symbols
		if (pass==1) {
			show("/* Exported Symbols */");
			for (symbol in symbols) {
				if (globals[symbol]) {
					console.log("#define", "qpu_symbol_"+symbol, toHex(symbols[symbol]));
				}
			}
	
			// Assembled Program
			show("\n/* Assembled Program */");
		}
	
		program.split('\n').forEach(function(line){
	
			var chkaddr, chk0, chk1;
			linenumber++;
	
			// Ignore lines if still in a C style block comment
			if (blockcomment) {
				if (line.indexOf('*/') < 0)
					return;
	
				blockcomment = false;
				line = line.substring(line.indexOf('*/')+2);
			}
	
			// Allow C style block comments on the start of a line
			if (line.trim().indexOf('/*') == 0) {
								
				if (line.trim().indexOf('*/') < 0) { // Beginning of a multi-line block comment?
					blockcomment = true;
					return;
				}
	
				var commentParts = line.trim().substring(2, line.trim().indexOf('*/')).trim().replace(':','').replace(',','').split(' ');
				
				// Grab chkaddr: chk0, chk1
				if (commentParts.length >= 2) {
					if (commentParts.length > 2)
						chkaddr = parseInt(commentParts.shift(), 16);
					chk0 = parseInt(commentParts.shift(), 16) >>> 0;
					chk1 = parseInt(commentParts.shift(), 16) >>> 0;
				}
				// Trim off the comment
				line = line.trim().substring(line.indexOf('*/')+2);
			}
	
			// [/* addr: word1 word2 */] [labelname:] [instruction | directive] [# comment]
			var lineParts = rsplit(line.replace('//','#').split('#', 1)[0], ':');
	
			// labelname
			if (lineParts[0]) {
				symbols[lineParts[0]] = _.pc;
				show('/* '+lineParts[0]+': */');
			}
	
			lineParts[1] = lineParts[1].trim();
	
			// instruction: empty
			if (lineParts[1] == "") {
				return;
			}
	
			// directive: .keyword [body]
			if (lineParts[1].indexOf(".") == 0) {
				var directiveParts = splitOnFirst(lineParts[1], ' ');
				if (_[directiveParts[0]])
					_[directiveParts[0]](directiveParts[1]);
				else
					error("Error: unknown directive", lineParts[1]);
				return;
			}
				
			// instruction: slot1 [; slot2 [; slot3]]
			var slots = lineParts[1].split(";").map(instructionToParts);
	
			if (slots.length > 3)
				error("Error: instruction has more than 3 slots.");
	
			//	 mulop:3 addop:5 ra:6 rb:6 adda:3 addb:3 mula:3 mulb:3, op:4 packbits:8 addcc:3 mulcc:3 F:1 X:1 wa:6 wb:6
			var mulop, addop, ra, rb, adda, addb, mula, mulb, op, packbits, addcc, mulcc, F, X, wa, wb;
			var unpack, packmode, pack;
	
			//	 bra/r addr:32, 1111 0000 cond:4 relative:1 register:1 ra:5 X:1 wa:6 wb:6
			var addr, cond, relative, register;
	
			//	 ldi data:32, 1110 unknown:8 addcc:3 mulcc:3 F:1 X:1 wa:6 wb:6
			var data;
	
			var add_dst, add_src1, add_src2, mul_dst, mul_src1, mul_src2;
			var add_dst_rotator, add_src1_rotator, add_src2_rotator, mul_dst_rotator, mul_src1_rotator, mul_src2_rotator;
			var add_dst_pack, add_src1_unpack, add_src2_unpack, mul_dst_pack, mul_src1_unpack, mul_src2_unpack;
	
			var iword0, iword1;
	
			for (var i=0; i<slots.length; i++) {
	
				// inst[.pred][.setf]
				var inst = slots[i][0].split(".")[0];
				var pred = (slots[i][0].split(".")[1]) || "";
				var setf = (slots[i][0].split(".")[2]) || "";
	
				if (pred=="setf" && setf == "") {
					setf = "setf";
					pred = "";
				}
	
				if (setf == "setf") {
					F = 1;
					if (addop != null && addop != addops["nop"])
						error("Error: add operation must be nop for multiply to use .setf");
						
				}
	
				if ((i==0 || (i==1 && addop == addops["nop"] && addcc==cc["never"]) || (i==1 && op==14)) && (inst == "ldi" || inst == "sacq" || inst == "srel")) { // [nop | ldi]; ldi.cc.setf reg, immediate
					op = 14;
	
					// parse packer
					var ldi_dst = slots[i][1];
					var ldi_dst_pack;
	
					if (ldi_dst != null && ldi_dst.lastIndexOf('.') >= 0) {
						// try: dst[.pack]
						ldi_dst_pack = pack_add[ldi_dst.substring(ldi_dst.lastIndexOf('.'))];
						if (ldi_dst_pack != null)
							ldi_dst = ldi_dst.substring(0, ldi_dst.lastIndexOf('.'));
						else
							error("Error: invalid destination packing in first (add) slot.");
					}
	
					if (i==0) { // first ldi of a pair
						addcc = cc[pred];
						add_dst_pack = ldi_dst_pack;
						if (addcc == null)
							error("Error: invalid condition predicate for first (add) slot.");
						if ((X == null || X == 0) && banka_w[ldi_dst] != null) {
							wa = banka_w[ldi_dst];
							X = 0;
						}
						else if ((X == null || X == 1) && bankb_w[ldi_dst] != null) {
							wa = bankb_w[ldi_dst];
							X = 1;
						}
						else {
							error("Error: invalid register in ldi instruction");
						}
					}
					else { // second ldi of a pair
						mulcc = cc[pred];
						mul_dst_pack = ldi_dst_pack;
						if (mulcc == null)
							error("Error: invalid condition predicate for second (mul) slot.");
						if ((X == null || X == 0) && bankb_w[ldi_dst] != null) {
							wb = bankb_w[ldi_dst];
							X = 0;
						}
						else if ((X == null || X == 1) && banka_w[ldi_dst] != null) {
							wb = banka_w[ldi_dst];
							X = 1;
						}
						else {
							error("Error: invalid register in ldi instruction");
						}
					}
	
					var immdata = evaluateExpr(slots[i][2], symbols);
					if (data == null || data == immdata)
						data = immdata;
					else
						error("Error: ldi constant must be the same in both instructions");
	
					if ((i==0 && (slots.length < 2 || (slots[1][0].indexOf('ldi') != 0 && slots[1][0].indexOf('sacq') != 0 && slots[1][0].indexOf('srel') != 0) )) || i==1) {
						// Vector const?
						if (Array.isArray(data)) {
							var pair = fromQpuVector(data);
							data = pair[0];
							unpack = pair[1];
						}
						// Packer
						if (add_dst_pack || mul_dst_pack) {
							if (add_dst_pack) {
								if (X != 0)
									error("Error: can only pack to ra0-ra31 in first ldi slot");
								else
									pack = add_dst_pack;
							}
							else {
								// pack to ra, rb or r0-r3
								packmode = 1;
							}
						}
	
						// Semaphore acquire/release?
						if (inst == "sacq" || inst == "srel") {
							var old = data;
							if (inst == "sacq") data = data | 0x00000010;
							if (inst == "srel") data = data & 0xffffffef;
	
							// Allow advanced use say sacq r0, 0xffffffff, provided the immediate value
							// is compatible with the value required in the semaphore acquire bit (bit 4)
							if (old != data && old > 0xf)
								error('Error: sacq/srel semaphore out of range 0..15');
	
							// Mark as semaphore instruction
									unpack |= 0x4;
	
							// todo, were both slots the same sacq or srel?
							if (i==1 && (slots[0][0].indexOf('nop') != 0 && slots[0][0].indexOf(inst) != 0))
								error('Error: semaphore instruction must be the same in both slots');
						}
	
						// If destination is -, make sure any implicit always condition changes to .never
						if (wa == null) {
							wa = 39;
							/* todo: this messes up perfect bitmatch when reassembling disassembly
							if (X==0) {
								if (addcc == cc[""]) addcc = cc["never"];
							}
							else {
								if (mulcc == cc[""]) mulcc = cc["never"];
							}
							*/
						}
						if (wb == null) {
							wb = 39;
							/* todo: this messes up perfect bitmatch when reassembling diassembly
							if (X==0) {
								if (mulcc == cc[""]) mulcc = cc["never"];
							}
							else {
								if (addcc == cc[""]) addcc = cc["never"];
							}
							*/
						}
	
						packbits = unpack << 5 | packmode << 4 | pack;
						iword0 = data >>> 0; iword1 = (op << 28 | packbits << 20 | addcc << 17 | mulcc << 14 | F << 13 | X << 12 | wa << 6 | wb << 0) >>> 0;
						if (slots.length > i+1)
								error("Error:ldi doesn't allow additional instruction slots");
						break;
					}
					continue;
				}
				else if (i==0 && inst == "brr") { // brr.bcc reg, target
					op = 15;
					bracc = bcc[pred];
					var wa = banka_w[slots[i][1]];
					if (wa == null) {
						wa = bankb_w[slots[i][1]];
						X = 1;
					}
					if (wa == null && wb == null)
						error("Error: invalid link register in brr instruction.");
					if (wa == null)
						wa = 39;
					if (wb == null)
						wb = 39;
	
					var reg_and_target = evaluateRaPlusOff(slots[i][2], symbols);
					var target = reg_and_target[1];
					if (target == null)
						error("Error: invalid target address in brr instruction.");
					target -= (_.pc + 8*4);
					var reg = 0;
					if (reg_and_target[0] != null) {
							reg = 1;
							ra = reg_and_target[0];
					} else {
							ra = 0; // TODO: Is this the right value for ra if reg == 0? What is ra meaning if reg == 0?
					}
					iword0 = target >>>0; iword1 = (op << 28 | bracc << 20 | 1 << 19 | reg << 18 | ra << 13 | X << 12 | wa << 6 | wb << 0) >>> 0;
					if (slots.length > 1)
							error("Error: brr doesn't allow additional instruction slots");
					break;
				}
				else if (i==0 && inst == "bra") { // bra.bcc wreg, reg
					op = 15;
					bracc = bcc[pred];
					var wa = banka_r[slots[i][1]];
					if (wa == null) {
						wb = bankb_w[slots[i][1]];
					}
					if (wa == null && wb == null)
						error("Error: invalid link register in bra instruction.");
					if (wa == null)
						wa = 39;
					if (wb == null)
						wb = 39;
					var reg = 0;
					var reg_and_target = evaluateRaPlusOff(slots[i][2], symbols);
					var target = reg_and_target[1];
					if (target == null)
						error("Error: invalid target address in bra instruction.");
					var reg = 0;
					if (reg_and_target[0] != null) {
							reg = 1;
							ra = reg_and_target[0];
					} else {
							ra = 0; // TODO: Is this the right value for ra if reg == 0? What is ra meaning if reg == 0?
					}
					iword0 = target>>>0; iword1 = (op << 28 | bracc << 20 | 0 << 19 | reg << 18 | ra << 13 | F << 12 | wa << 6 | wb << 0) >>> 0;
					if (slots.length > 1)
							error("Error: bra doesn't allow additional instruction slots");
					break;
				}
				if (addop == null) {
					addop = addops[inst];
					if (addop !=null ) {
						// add_dst, add_src1 [, add_src2]
						// todo: op.pred.setf dst[.pack][<< shift], (src1[.unpack][<< shift] | smallconst) [, (src2[.unpack][<<shift] | smallconst) ]
						// -> [regname, pack, shift] or smallconst
						addcc = cc[pred];
						if (addcc == null)
							error("Error: invalid condition for first (add) slot.");
						if (addop == addops["nop"] && addcc == 1)
							addcc = 0;
	
						if (slots[i].length-1 != instructionArgumentCount(inst))
							error("Error: Operation '"+inst+"' found", slots[i].length-1, "arguments, expected", instructionArgumentCount(inst), "arguments.");
	
						add_dst = slots[i][1];
	
						if (add_dst != null && add_dst.lastIndexOf('.') >= 0) {
							// try: dst[.pack]
							add_dst_pack = pack_add[add_dst.substring(add_dst.lastIndexOf('.'))];
							if (add_dst_pack != null)
								add_dst = add_dst.substring(0, add_dst.lastIndexOf('.'));
							else
								error("Error: invalid destination packing in first (add) slot.");
						}
	
						if (add_dst != null && banka_w[add_dst] == null && bankb_w[add_dst] == null)
							error("Error: invalid destination register in first (add) slot.");
	
						add_src1 = slots[i][2];
						if (add_src1 != null && add_src1.lastIndexOf('.') >= 0) {
							// try: src1[.unpack]
							add_src1_unpack = unpack_add[add_src1.substring(add_src1.lastIndexOf('.'))];
							if (add_src1_unpack != null)
								add_src1 = add_src1.substring(0, add_src1.lastIndexOf('.'));
							//else
							//	might not be error, because might be a number eg 1.0 or a expression myvar.field
						}
	
						if (add_src1 != null && acc_names[add_src1] == null && banka_r[add_src1] == null && bankb_r[add_src1] == null) {
							// add_src2 is not a acc, ra or rb, now try a small const
								add_src1 = evaluateSrc(add_src1, symbols, error);
	
							if (imm[add_src1]!=null && rb==null && op==null) {
								rb = imm[add_src1];
								op = ops['nopi'];
								adda = 7;
							}
							else
								error("Error: '"+add_src1+"' is not a valid source in the first (add) slot.");
						}
	
						add_src2 = slots[i][3];
						if (add_src2 == null) {
							add_src2 = add_src1;
							add_src2_unpack = add_src1_unpack;
						}
						if (add_src2_unpack == null && typeof(add_src2)=="string" && add_src2.lastIndexOf('.') >= 0) {
							//try: src2[.unpack]
							add_src2_unpack = unpack_add[add_src2.substring(add_src2.lastIndexOf('.'))];
							if (add_src2_unpack != null)
								add_src2 = add_src2.substring(0, add_src2.lastIndexOf('.'));
							//else
							//	might not be an error as above
						}
						if (add_src2 != null && acc_names[add_src2] == null && banka_r[add_src2] == null && bankb_r[add_src2] == null) {
							// add_src2 is not a acc, ra or rb, now try a small const
	
								add_src2 = evaluateSrc(add_src2, symbols, error);
	
							if (imm[add_src2]!=null && ((rb==null && op==null) || (rb==imm[add_src2]) && op==ops['nopi'])) {
								rb = imm[add_src2];
								op = ops['nopi'];
								addb = 7;
							}
							else
								error("Error: invalid second source register in first (add) slot.");
						}
						continue;
					}
				}
				if (mulop == null) {
					mulop = mulops[inst];
					if (mulop != null) {
						// todo: op.pred.setf dst[.pack][<< shift], (src1[.unpack][<< shift] | smallconst) [, (src2[.unpack][<<shift] | smallconst) ]
																					// dst[.pack][<< shift] => (reg.pack, expr) => expr is << k|r5, or expr is value to be calculated, and maybe constant
						 // scan alphanumeric+. unil space or other symbol
						mulcc = cc[pred];
						if (mulcc == null)
							error("Error: invalid condition predicate for second (mul) slot.");
						if (mulop == mulops["nop"] && mulcc == 1)
							mulcc = 0;
	
						if (slots[i].length-1 != instructionArgumentCount(inst))
							error("Error: ", inst, "should have", instructionArgumentCount(inst), "arguments.");
	
						mul_dst = slots[i][1];
						if (mul_dst != null && mul_dst.lastIndexOf('.') >= 0) {
							// try: dst[.pack]
							mul_dst_pack = pack_mul[mul_dst.substring(mul_dst.lastIndexOf('.'))];
							if (mul_dst_pack != null)
								mul_dst = mul_dst.substring(0, mul_dst.lastIndexOf('.'));
							else
								error("Error: invalid destination packing in second (mul) slot.");
						}
						if (mul_dst != null && banka_w[mul_dst] == null && bankb_w[mul_dst] == null)
							error("Error: invalid destination register in second (mul) slot.");
	
						mul_src1 = slots[i][2];
						if (typeof(mul_src1) == "string" && (mul_src1.search(">>") != -1 /*todo: || mul_src1.search("<<") != -1*/)) {
							var reg_and_rotation = mul_src1.split(">>");
							mul_src1 = reg_and_rotation[0].trim();
							mul_src1_rotator = reg_and_rotation[1].trim()=="r5" ? "r5" : evaluateExpr(reg_and_rotation[1], symbols);
						}
						if (typeof(mul_src1) == "string" && mul_src1.lastIndexOf('.') >= 0) {
							// try: src1[.unpack]
							mul_src1_unpack = unpack_mul[mul_src1.substring(mul_src1.lastIndexOf('.'))];
							if (mul_src1_unpack != null)
								mul_src1 = mul_src1.substring(0, mul_src1.lastIndexOf('.'));
							//else
							//	might not be error, because might be a number eg 1.0 or a expression myvar.field
						}
						if (mul_src1 != null && acc_names[mul_src1] == null && banka_r[mul_src1] == null && bankb_r[mul_src1] == null) {
							// if its not an immediate as is, try and evaluate expr
								mul_src1 = evaluateSrc(mul_src1, symbols, error);
	
							if (imm[mul_src1]!=null && ((rb==null && op==null) || (op==ops['nopi'] && rb==imm[mul_src1]))) {
								rb = imm[mul_src1];
								op = ops['nopi'];
								mula = 7;
							}
							else
								error("Error: invalid first source register in first (mul) slot.", mul_src1, rb, op);
						}
	
						mul_src2 = slots[i][3];
						if (mul_src2 == null) {
							mul_src2 = mul_src1;
							mul_src2_rotator = mul_src1_rotator;
							mul_src2_unpack = mul_src1_unpack;
						}
						if (typeof(mul_src2) == "string" && (mul_src2.search(">>") != -1 /*todo: || mul_src2.search("<<") != -1*/)) {
							var reg_and_rotation = mul_src2.split(">>");
							mul_src2 = reg_and_rotation[0].trim();
							mul_src2_rotator = reg_and_rotation[1].trim()=="r5" ? "r5" : evaluateExpr(reg_and_rotation[1], symbols);
						}
						if (mul_src2_unpack == null && typeof(mul_src2) == "string" && mul_src2.lastIndexOf('.') >= 0) {
							//try: src2[.unpack]
							mul_src2_unpack = unpack_add[mul_src2.substring(mul_src2.lastIndexOf('.'))];
							if (mul_src2_unpack != null)
								mul_src2 = mul_src2.substring(0, mul_src2.lastIndexOf('.'));
							//else
							//	might not be an error as above
						}
						if (mul_src2 != null && acc_names[mul_src2] == null && banka_r[mul_src2] == null && bankb_r[mul_src2] == null) {
							// if its not an immediate as is, try and evaluate expr
								mul_src2 = evaluateSrc(mul_src2, symbols, error);
	
							if ((imm[mul_src2]!=null && rb==null && op==null) || (op==ops['nopi'] && rb==imm[mul_src2])) {
								rb = imm[mul_src2];
								op = ops['nopi'];
								mulb = 7;
							}
							else
								error("Error: invalid second source register in second (mul) slot.", mul_src2, rb, op);
						}
						continue;
					}
				}
				if (op == null) {
					op = ops[inst];
					if (op != null) {
						continue;
					}
				}
				error("Error: unknown operation '"+inst+"' in slot"+i,'at line', linenumber);
			}
	
			// lets grab rb for the rotators
			if (mul_src1_rotator != null || mul_src2_rotator != null) {
	
				if (op != null)
					error("Error: cannot use rotator with non empty third slot.");
	
				op = ops["nopi"];
	
				if (mul_src1_rotator != mul_src2_rotator)
					error("Error: mismatched rotators in second (mul) slot.");
				
				if (mul_src1_rotator != null) {
					if (rb == null || rb == imm[" >> "+mul_src1_rotator])
						rb = imm[" >> "+mul_src1_rotator];
					else
						error("Error: cannot use rotator due to conflict.");
	
				}
	
				if (mul_src2_rotator != null) {
					if (rb == null || rb == imm[" >> "+mul_src2_rotator])
						rb = imm[" >> "+mul_src2_rotator];
					else
						error("Error: cannot use rotator due to conflict.");
	
				}
			}
	
	
			// should we ever swap nop/movs between add and mul?
	
			// destination:
			// if add_can_a and mul_can_b then X=0
			// if add_can_b and mul_can_a then X=1
			// if add_must_a and mul_must_a then conflict: both add and mul operations need to write to bank a
			// if add_must_b and mul_must_b then conflict: both add and mul operations need to write to bank b
			if ((add_dst == null || banka_w[add_dst] != null) && (mul_dst == null || bankb_w[mul_dst] != null)) {
				X = 0; wa = banka_w[add_dst]; wb = bankb_w[mul_dst];
			}
			else if ((add_dst == null || bankb_w[add_dst] != null) && (mul_dst == null || banka_w[mul_dst] != null)) {
				X = 1; wa = bankb_w[add_dst]; wb = banka_w[mul_dst];
			}
			else if (banka_w[add_dst] != null && bankb_w[add_dst] == null && banka_w[mul_dst] != null && bankb_w[mul_dst] == null) {
				error("Error: both add and mul operations are writing to bank a.");
			}
			else if (banka_w[add_dst] == null && bankb_w[add_dst] != null && banka_w[mul_dst] == null && bankb_w[mul_dst] != null) {
				error("Error: both add and mul operations are writing to bank b");
			}
			else {
				error("Error: unexpected error handling add and mul operation destination register.", add_dst, mul_dst);
			}
			// sources
			// if add_src1 is r0...r4 use that
			// if add_src1_must_a then use_a = src1
			// if add_src1_must_b then use_b = src1
			// if add_src2 is r0...r4 use that
			// if add_src2_must_a and use_a free, then use_a = src2
			// if add_src2_must_b and use_b free, then use_a = src2
			// if mul_src1 is r0...r4 then use that
			// if mul_src1_must_a and use_a free then use_a = mul_src1
			// if mul_src1_must_b and use_b free then use_b = mul_src1
			// if mul_src2 is r0...r4 then use that
			// if mul_src2_must_a and use_a free then use_a = mul_src2
			// if mul_src2_must_b and use_b free then use_b = mul_src2
	
			if (acc_names[add_src1] != null) {
				adda = acc_names[add_src1];
			}
			else if (banka_r[add_src1] != null && bankb_r[add_src1] == null) {
				if (ra != null && ra != banka_r[add_src1])
					error("Error: instruction reads from register bank a more than once.");
				adda = 6; ra = banka_r[add_src1];
			}
			else if (bankb_r[add_src1] != null && banka_r[add_src1] == null) {
				if (rb != null && rb != bankb_r[add_src1])
					error("Error: instruction reads from register bank b more than once.");
				adda = 7; rb = bankb_r[add_src1];
			}
			if (acc_names[add_src2] != null) {
				addb = acc_names[add_src2];
			}
			else if (banka_r[add_src2] != null && bankb_r[add_src2] == null) {
				if (ra != null && ra != banka_r[add_src2])
					error("Error: instruction reads from register bank a more than once.");
				addb = 6; ra = banka_r[add_src2];
			}
			else if (bankb_r[add_src2] != null && banka_r[add_src2] == null) {
				if (rb != null && rb != bankb_r[add_src2])
					error("Error: instruction reads from register bank b more than once.");
				addb = 7; rb = bankb_r[add_src2];
			}
			if (acc_names[mul_src1] != null) {
				mula = acc_names[mul_src1];
			}
			else if (banka_r[mul_src1] != null && bankb_r[mul_src1] == null) {
				if (ra != null && ra != banka_r[mul_src1])
					error("Error: instruction reads from register bank a more than once.");
				mula = 6; ra = banka_r[mul_src1];
			}
			else if (bankb_r[mul_src1] != null && banka_r[mul_src1] == null) {
				if (rb != null && rb != bankb_r[mul_src1])
					error("Error: instruction reads from register bank b	more than once.");
				mula = 7; rb = bankb_r[mul_src1];
			}
			if (acc_names[mul_src2] != null) {
				mulb = acc_names[mul_src2];
			}
			else if (banka_r[mul_src2] != null && bankb_r[mul_src2] == null) {
				if (ra != null && ra != banka_r[mul_src2])
					error("Error: instruction reads from register bank a more than once.");
				mulb = 6; ra = banka_r[mul_src2];
			}
			else if (bankb_r[mul_src2] != null && banka_r[mul_src2] == null) {
				if (rb != null && rb != bankb_r[mul_src2])
					error("Error: instruction reads from register bank b more than once.");
				mulb = 7; rb = bankb_r[mul_src2];
			}
			// now remaining maybes
			if (banka_r[add_src1] != null && bankb_r[add_src1] != null) {
				if (ra == banka_r[add_src1]) {
					adda = 6;
				}
				else if (rb == bankb_r[add_src1]) {
					adda = 7;
				}
				else if (ra == null) {
					adda = 6; ra = banka_r[add_src1];
				}
				else if (rb == null) {
					adda = 7; rb = bankb_r[add_src1];
				}
				else {
					error("Error: instruction must read from register bank a or b more than once.");
				}
			}
			if (banka_r[add_src2] != null && bankb_r[add_src2] != null) {
				if (ra == banka_r[add_src2]) {
					addb = 6;
				}
				else if (rb == bankb_r[add_src2]) {
					addb = 7;
				}
				else if (ra == null) {
					addb = 6; ra = banka_r[add_src2];
				}
				else if (rb == null) {
					addb = 7; rb = bankb_r[add_src2];
				}
				else {
					error("Error: instruction must read from register bank a or b more than once.");
				}
			}
			if (banka_r[mul_src1] != null && bankb_r[mul_src1] != null) {
				if (ra == banka_r[mul_src1]) {
					mula = 6;
				}
				else if (rb == bankb_r[mul_src1]) {
					mula = 7;
				}
				else if (ra == null) {
					mula = 6; ra = banka_r[mul_src1];
				}
				else if (rb == null) {
					mula = 7; rb = bankb_r[mul_src1];
				}
				else {
					error("Error: instruction must read from register bank a or b more than once.");
				}
			}
			if (banka_r[mul_src2] != null && bankb_r[mul_src2] != null) {
				if (ra == banka_r[mul_src2]) {
					mulb = 6;
				}
				else if (rb == bankb_r[mul_src2]) {
					mulb = 7;
				}
				else if (ra == null) {
					mulb = 6; ra = banka_r[mul_src2];
				}
				else if (rb == null) {
					mulb = 7; rb = bankb_r[mul_src2];
				}
				else {
					error("Error: instruction must read from register bank a or b more than once.");
				}
			}
	
			// Now lets do the pack and unpack:
			//
			//	(.unpack, .packmode, .pack): addop add_dst[.pack], add_src1[.unpack], add_src2[.unpack]; mulop mul_dst[.pack], mul_src1[.unpack], mul_src2[.unpack]
			//
			//	There are no pack/unpack enable bits, it all comes down to .packmode and what sources and destinations support packing and unpacking.
			//	when a source/destination doesnt support the packing/unpacking it will be used in its natural state.
			//
			//	From empirical testing:
			//
			//	Unpack:
			//		packmode=0:
			//			add source can unpack raX.unpack
			//			mul source can unpack raX.unpack
			//		packmode=1:
			//			add source can unpack r4.unpack
			//			mul source can unpack r4.unpack
			//
			//	Pack:
			//		packmode=0:
			//			add destination can pack raX.pack
			//			mul destination can pack raX.pack
			//		packmode=1:
			//			add destination cannot pack
			//			mul destination can pack rX.pack, raX.pack or rbX.pack
			
			// First all instances of unpacking and packing must be the same bits
			var desired_unpack = add_src1_unpack || add_src2_unpack || mul_src1_unpack || mul_src2_unpack;
			var desired_pack = add_dst_pack || mul_dst_pack;
	
			if (!desired_unpack && !desired_pack)
				; // No packing needed.
			else if ((add_src1_unpack != null && add_src1_unpack != desired_unpack)
			|| (add_src2_unpack != null && add_src2_unpack != desired_unpack)
			|| (mul_src1_unpack != null && mul_src1_unpack != desired_unpack)
			|| (mul_src2_unpack != null && mul_src2_unpack != desired_unpack))
				error("Error: all sources that unpack must use a common unpacking");
			else if ((add_dst_pack != null && add_dst_pack != desired_pack)
					 || (mul_dst_pack != null && mul_dst_pack != desired_pack))
				error("Error: all destinations that pack must use a common packing");
			else {
				// Unpacking
				if (desired_unpack && ((adda == 4 && add_src1_unpack)|| (addb == 4 && add_src2_unpack) || (mula == 4 && mul_src1_unpack) || (mulb == 4 && mul_src2_unpack))) {
					// unpacking r4 forces packmode 1
					if (packmode != null && packmode != 1)
						error('Error: conflict in packing/unpacking choices.');
					if ((adda == 4 && add_src1_unpack != desired_unpack) || (addb == 4 && add_src2_unpack != desired_unpack)
					|| (mula == 4 && mul_src1_unpack != desired_unpack) || (mulb == 4 && mul_src2_unpack != desired_unpack))
						error('Error: all references to r4 must use be unpacked and they must use the same unpacking.', desired_unpack, adda, addb, mula, mulb);
	
					packmode = 1;
				}
				else if (desired_unpack && ((adda == 6 && add_src1_unpack)|| (addb == 6 && add_src2_unpack) || (mula == 6 && mul_src1_unpack) || (mulb == 6 && mul_src2_unpack))) {
					// unpacking r6 requires packmode 0
					if (packmode != null && packmode != 0)
						error('Error: conflict in packing/unpacking choices.');
					if ((adda == 6 && add_src1_unpack != desired_unpack) || (addb == 6 && add_src2_unpack != desired_unpack)
					|| (mula == 6 && mul_src1_unpack != desired_unpack) || (mulb == 6 && mul_src2_unpack != desired_unpack))
						error('Error: all references to ra0-ra31 must use be unpacked and they must use the same unpacking.');
					packmode = 0;
				}
				else if (desired_unpack) {
					error('Error: only ra0-ra31 or r4 may be unpacked.');
				}
	
				// Packing
	//			console.log('-->', desired_pack, add_dst_pack, mul_dst_pack);
				if (desired_pack && add_dst_pack) {
					// ra packing must use packmode 0
					if (packmode != null && packmode != 0)
						error('Error: conflict in packing/unpacking choices.');
					if ((X!=0) && add_dst >= 32)
						error('Error: can only pack to ra0..ra31 in add slot.');
					if (mul_dst_pack)
						error('Error: cannot pack to both add and multiply slots.');
					
					packmode = 0;
				}
				else if (desired_pack && mul_dst_pack) {
					if (X==0 || (mul_dst >= banka_w["r0"] && mul_dst <= banka_w["r3"])) {
						// writing to bank rb, or r0-r3,
						if (packmode != null && packmode != 1)
							error('Error: conflict in packing/unpacking choices.');
						packmode = 1;
					}
					else { // ra.pack
						// Good to pack in either packmode
						if (packmode == null) packmode = 1;
					}
				}
	
			}
			packbits = desired_unpack << 5 | packmode << 4 | desired_pack;
	
			if (op == null)
				op = ops["nop"];
	
			if ((addop != null || mulop != null || op != null) && iword0 == null && iword1 == null) {
				if (addop == null) addop = addops["nop"];
				if (mulop == null) mulop = mulops["nop"];
				if (ra==null) ra = banka_r["-"];
				if (rb==null) rb = bankb_r["-"];
				if (wa==null) wa = banka_r["-"];
				if (wb==null) wb = bankb_r["-"];
	
				//console.log(mulop, addop, ra, rb, adda, addb, mula, mulb);//ra, rb, adda, addb, add_src1, add_src2, mulcc);
				//console.log(op, packbits, addcc, mulcc, F, X, wa, wb);
				iword0 = (mulop << 29 | addop << 24 | ra << 18 | rb << 12 | adda << 9 | addb << 6 | mula << 3 | mulb << 0) >>> 0;
				iword1 = (op << 28 | packbits << 20 | addcc << 17 | mulcc << 14 | F << 13 | X << 12 | wa << 6 | wb << 0) >>> 0;
			}
	
			if (iword0 != null && iword1 != null) {
				show('/* '+toHex(_.pc)+': */', toHex(iword0)+', '+toHex(iword1)+", /*", lineParts[1], '*/');
				_.pc += 8;
				if (options.showbits && (op == ops['bra'])) {
					show('/*', 'target =', toHex(target||0), '*/');
					show('/*', 'op =', op||0, ', bracc =', bracc||0, ', reg =', reg||0, ', ra =', ra||0, ', F =', F||0, ', wa =', wa||0, ', wb =', wb||0);
					show();
				}
				else if (options.showbits && (op == ops['ldi'])) {
					show('/*', 'data =', toHex(data>>>0), '*/');
					show('/*', 'op =', op||0, ', addcc =', addcc||0, ', mulcc =', mulcc||0, ', F =', F||0, ', X =', X||0, ', wa =', wa||0, ', wb =', wb||0);
					show();
				}
				else if (options.showbits) {
					show('/*', 'mulop =', mulop||0, ', addop =', addop||0, ', ra =', ra||0, ', rb =', rb||0, ', adda =', adda||0, ', addb =', addb||0, ', mula =', mula||0, ', mulb =', mulb||0, '*/');
					show('/*', 'op =', op||0, ', packbits =', packbits||0, ', addcc =', addcc||0, ', mulcc =', mulcc||0, ', F =', F||0, ', X =', X||0, ', wa =', wa||0, ', wb =', wb||0, '*/');
					show();
				}
			}
			else
				show(lineParts[1], addop, mulop, op);
	
			if (chk0 != null && chk1 != null) {
				if (chk0 != iword0 || chk1 != iword1) {
					// Final check for a case of X mismatch when it doesnt matter
					if (!options.strictmatch && ((chk1 & 0xffffefff) == (iword1 & 0xffffefff)) && (wa == 39 || (wa >= 32 && wa <= 35)) && (wb == 39 || (wb >= 32 && wb <= 35)))
						;//console.log('same same but different');
					else
						error('Assembly check failed. Got', toHex(iword0), toHex(iword1), 'expected', toHex(chk0), toHex(chk1));
				}
			}
		});
	
		}
	
		for (global in globals) {
			if (symbols[global] == null)
				error("Error: global",global,"is missing a definition.");
		}
	
		if (options.dumpglobals)
			console.log(globals);
	
		if (options.dumpsymbols)
			console.log(symbols);
	}
	
	/*
	 * When run from node/command line:
	 *	 node[js] qpuasm [--showbits] [--dumpglobals] [--dumpsymbols] [--verbose] [--in=]filename
	 */
	if (typeof module != 'undefined' && module.exports && !module.parent) {
	
		var fs = require('fs');
		var existsSync = fs.existsSync || require('path').existsSync;
	
		var options = {in:[]};
		if (process.argv.length < 3) {
			console.log(process.argv[0], process.argv[1], "[--showbits] [--dumpglobals] [--dumpsymbols] [--verbose] [--ignore-errors] [--strict-match] [--in]filename");
		}
		for (var i=2; i<process.argv.length; i++) {
			if(process.argv[i].indexOf('--no-') == 0) {
				var param = process.argv[i].substring(5).split('=', 1);
				options[param[0]] = param[1] || false;
			}
			else if(process.argv[i].indexOf('--') == 0) {
				var param = process.argv[i].substring(2).split('=', 1);
				options[param[0]] = param[1] || true;
			}
			else {
				options.in = process.argv[i];
				if (existsSync(options.in))
					assemble(fs.readFileSync(options.in, 'utf8'), options);
				else
					console.log('Error: Can\'t open', options.in, 'to assemble.');
			}
		}
	
	}else{
		module = module || {};
		module.exports = assemble;
		module.exports.acc_names = acc_names;
		module.exports.banka_r = banka_r;
		module.exports.bankb_r = bankb_r;
		module.exports.banka_w = banka_w;
		module.exports.bankb_w = bankb_w;
		module.exports.addops = addops;
		module.exports.mulops = mulops;
		module.exports.ops = ops;
		module.exports.arity = arity;
		module.exports.instructionArgumentCount = instructionArgumentCount;
		module.exports.cc = cc;
		module.exports.bcc = bcc;
		module.exports.imm = imm;
		module.exports.pack_add = pack_add;
		module.exports.pack_mul = pack_mul;
		module.exports.unpack_add = unpack_add;
		module.exports.unpack_mul = unpack_mul;
		module.exports.mkReverseMap = mkReverseMap;
		module.exports.mkEnum = mkEnum;
		module.exports.isNumber = isNumber;
		module.exports.toHex = toHex;
		module.exports.rsplit = rsplit;
		module.exports.splitOnFirst = splitOnFirst;
		module.exports.trim = trim;
		module.exports.evaluateExpr = evaluateExpr;
		module.exports.error = error;
		module.exports.evaluateSrc = evaluateSrc;
		module.exports.evaluateRaPlusOff = evaluateRaPlusOff;
		module.exports.fromQpuVector = fromQpuVector;
		module.exports.instructionToParts = instructionToParts;
		return module.exports
	}
})(module);
