// qpuasm.js"
//   requires node to run.
//
// To install node:
//   (debian) apt-get install nodejs
//   other, down from http://nodejs.org/download/
//
// To run:
//   node[js] qpuasm [--showbits] [--dumpglobals] [--dumpsymbols] [--verbose] [--in=]filename

var acc_names = mkEnum([
        "r0", "r1", "r2", "r3", "r4", "r5"
]);

var banka_r = mkEnum([
        "ra0", "ra1", "ra2", "ra3", "ra4", "ra5", "ra6", "ra7",
        "ra8", "ra9", "ra10", "ra11", "ra12", "ra13", "ra14", "w",
        "ra16", "ra17", "ra18", "ra19", "ra20", "ra21", "ra22", "ra23",
        "ra24", "ra25", "ra26", "ra27", "ra28", "ra29", "ra30", "ra31",
        "unif", "ra33", "ra34", "vary", "ra36", "ra37", "elem_num", "-",
        "ra40", "x_coord", "ms_mask", "ra43", "ra44", "ra45", "ra46", "ra47",
        "vpm", "vr_busy", "vr_wait", "mutex", "ra52", "ra53", "ra54", "ra55",
        "ra56", "ra57", "ra58", "ra59", "ra60", "ra61", "ra62", "ra63",
]);

var bankb_r = mkEnum([
        "rb0", "rb1", "rb2", "rb3", "rb4", "rb5", "rb6", "rb7",
        "rb8", "rb9", "rb10", "rb11", "rb12", "rb13", "rb14", "z",
        "rb16", "rb17", "rb18", "rb19", "rb20", "rb21", "rb22", "rb23",
        "rb24", "rb25", "rb26", "rb27", "rb28", "rb29", "rb30", "rb31",
        "unif", "rb33", "rb34", "vary", "rb36", "rb37", "qpu_num", "-",
        "rb40", "y_coord", "rev_flag", "rb43", "rb44", "rb45", "rb46", "rb47",
        "vpm", "vw_busy", "vw_wait", "mutex", "rb52", "rb53", "rb54", "rb55",
        "rb56", "rb57", "rb58", "rb59", "rb60", "rb61", "rb62", "rb63",
]);

var banka_w = mkEnum([
        "ra0", "ra1", "ra2", "ra3", "ra4", "ra5", "ra6", "ra7",
        "ra8", "ra9", "ra10", "ra11", "ra12", "ra13", "ra14", "w",
        "ra16", "ra17", "ra18", "ra19", "ra20", "ra21", "ra22", "ra23",
        "ra24", "ra25", "ra26", "ra27", "ra28", "ra29", "ra30", "ra31",
        "r0", "r1", "r2", "r3", "tmurs", "r5quad", "irq", "-",
        "unif_addr", "x_coord", "ms_mask", "stencil", "tlbz", "tlbm", "tlbc", "tlbam",
        "vpm", "vr_setup", "vr_addr", "mutex", "recip", "recipsqrt", "exp", "log",
        "t0s", "t0t", "t0r", "t0b", "t1s", "t1t", "t1r", "t1b",
]);

var bankb_w = mkEnum([
        "rb0", "rb1", "rb2", "rb3", "rb4", "rb5", "rb6", "rb7",
        "rb8", "rb9", "rb10", "rb11", "rb12", "rb13", "rb14", "w",
        "rb16", "rb17", "rb18", "rb19", "rb20", "rb21", "rb22", "rb23",
        "rb24", "rb25", "rb26", "rb27", "rb28", "rb29", "rb30", "rb31",
        "r0", "r1", "r2", "r3", "tmurs", "r5rep", "irq", "-",
        "unif_addr", "y_coord", "rev_flag", "stencil", "tlbz", "tlbm", "tlbc", "tlbam",
        "vpm", "vw_setup", "vw_addr", "mutex", "recip", "recipsqrt", "exp", "log",
        "t0s", "t0t", "t0r", "t0b", "t1s", "t1t", "t1r", "t1b",
]);

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
	2: ["itof", "ftoi", "clz", "mov"],
});

function instructionArgumentCount(x) {
	return arity[x] >= 0 ? arity[x] : 3;
}

var cc = mkEnum([
	"never", "", "zs", "zc", "ns", "nc", "cs", "cc"
]);

var bcc = mkEnum([
        ".allz", ".allnz", ".anyz", ".anynz", ".alln", ".allnn", ".anyn", ".anynn",
        ".allc", ".allnc", ".anyc", ".anync", ".cc12", ".cc13", ".cc14", ""
]);

var imm = mkEnum([
        "0", "1", "2", "3", "4", "5", "6", "7",
        "8", "9", "10", "11", "12", "13", "14", "15",
        "-16", "-15", "-14", "-13", "-12", "-11", "-10", "-9",
        "-8", "-7", "-6", "-5", "-4", "-3", "-2", "-1",
        "1.0", "2.0", "4.0", "8.0", "16.0", "32.0", "64.0", "128.0",
        1/256, 1/128, 1/64, 1/32, 1/16, 1/8, 1/4, 1/2
	
        //" >> r5", " >> 1", " >> 2", " >> 3", " >> 4", " >> 5", " >> 6", " >> 7",
        //" >> 8", " >> 9", " >> 10", " >> 11", " >> 12", " >> 13", " >> 14", " >> 15"
]);

function mkReverseMap(o) { var r={}; for (var k in o) { if (Array.isArray(o[k])) o[k].forEach(function(v){ r[v] = k; }); else r[o[k]] = k; } return r; }

function mkEnum(a) { var o={}; var n=0; a.forEach(function(i) { o[i] = n++; }); return o; }

function isNumber(n) { return !isNaN(parseFloat(n)) && isFinite(n); }

function toHex(n) { return '0x'+("00000000"+(n>>>0).toString(16)).slice(-8); }

function rsplit(s, c) { return [''].concat(s.split(c, 2)).slice(-2); }
function splitOnFirst(s, c) { var i = s.indexOf(c); return i<0 ? [s] : [s.substring(0, i), s.substring(i+1)]; }
function trim(s) { return s.trim(); }

function evaluateExpr(expr, vars) { try { with (vars) return eval(expr); } catch(e) { return e; }; }

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
			symbols[symbol] = evaluateExpr(expr, symbols) || 1;
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
	var error = pass!=1 ? nothing : function() {
		var util = require('util');
		console.log(util.format.apply(this, arguments));
		process.exit(-1);
	};

	_.pc = options.targetaddress || 0;
	var linenumber = 0;

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

		linenumber++;

		// [labelname:] [instruction | directive] [# comment]
		var lineParts = rsplit(line.split('#', 1)[0], ':');

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

		//   mulop:3 addop:5 ra:6 rb:6 adda:3 addb:3 mula:3 mulb:3, op:4 packbits:8 addcc:3 mulcc:3 F:1 X:1 wa:6 wb:6
		var mulop, addop, ra, rb, adda, addb, mula, mulb, op, packbits, addcc, mulcc, F, X, wa, wb;

		//   bra/r addr:32, 1111 0000 cond:4 relative:1 register:1 ra:5 X:1 wa:6 wb:6
		var addr, cond, relative, register;

		//   ldi data:32, 1110 unknown:8 addcc:3 mulcc:3 F:1 X:1 wa:6 wb:6
		var data;

		var add_dst, add_src1, add_src2, mul_dst, mul_src1, mul_src2;

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

			if (i==0 && inst == "ldi") { // ldi.cc.setf reg, immediate
				op = 14;
				wa = banka_w[slots[i][1]];
				if (wa == null) {
					wa = bankb_w[slots[i][1]];
					X = 1;
				}
				if (wa == null && wb == null)
					error("Error: invalid register in ldi instruction");

				if (wa == null) wa = 39;
				if (wb == null) wb = 39;
				data = evaluateExpr(slots[i][2], symbols);
				addcc = cc[pred];
				iword0 = data; iword1 = (op << 28 | 0 << 20 | addcc << 17 | mulcc << 14 | F << 13 | X << 12 | wa << 6 | wb << 0) >>> 0;
				if (slots.length > 1)
				    error("Error:ldi doesn't allow additional instruction slots");
				break;
			}
			else if (i==0 && inst == "brr") { // brr.bcc reg, target
				op = 15;
				bracc = bcc[pred];
				var wa = banka_w[slots[i][1]];
				if (wa == null) {
					wb = bankb_w[slots[i][1]];
				}
				if (wa == null && wb == null)
					error("Error: invalid link register in brr instruction.");
				if (wa == null)
					wa = 39;
				if (wb == null)
					wb = 39;
				var target = evaluateExpr(slots[i][2], symbols);
				if (target == null)
					error("Error: invalid target address in brr instruction.");
				target -= (_.pc + 8*4);
				var reg = 0;
				iword0 = target; iword1 = (op << 28 | bracc << 20 | 1 << 19 | reg << 18 | ra << 13 | F << 12 | wa << 6 | wb << 0) >>> 0;
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
				var ra = banka_r[slots[i][2]];
				if (ra == null)
					error("Error: invalid target register in bra instruction.");
				var reg = 1;
				target = 0;
				iword0 = target; iword1 = (op << 28 | bracc << 20 | 0 << 19 | reg << 18 | ra << 13 | F << 12 | wa << 6 | wb << 0) >>> 0;
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
						error("Error: Operation '"+inst+"' found", slots[i].length-1, "arguments, needs", instructionArgumentCount(inst), "arguments.");

					add_dst = slots[i][1];
					if (add_dst != null && banka_w[add_dst] == null && bankb_w[add_dst] == null)
						error("Error: invalid destination register in first (add) slot.");

					add_src1 = slots[i][2];
					if (add_src1 != null && acc_names[add_src1] == null && banka_r[add_src1] == null && bankb_r[add_src1] == null) {
						// add_src2 is not a acc, ra or rb, now try a small const
					    add_src1 = evaluateSrc(add_src1, symbols, error);		

						if (imm[add_src1] && rb==null && op==null) {
							rb = imm[add_src1];
							op = ops['nopi'];
							adda = 7;
						}
						else
							error("Error: '"+add_src1+"' is not a valid source in the first (add) slot.");
					}
					add_src2 = slots[i][3];
					if (add_src2 == null)
						add_src2 = add_src1;
					if (add_src2 != null && acc_names[add_src2] == null && banka_r[add_src2] == null && bankb_r[add_src2] == null) {
						// add_src2 is not a acc, ra or rb, now try a small const

					    add_src2 = evaluateSrc(add_src2, symbols, error);

						if (imm[add_src2] && ((rb==null && op==null) || (rb==imm[add_src2]) && op==ops['nopi'])) {
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
					if (mul_dst != null && banka_w[mul_dst] == null && bankb_w[mul_dst] == null)
						error("Error: invalid destination register in second (mul) slot.");
					mul_src1 = slots[i][2];
					if (mul_src1 != null && acc_names[mul_src1] == null && banka_r[mul_src1] == null && bankb_r[mul_src1] == null) {
						// if its not an immediate as is, try and evaluate expr
					    mul_src1 = evaluateSrc(mul_src1, symbols, error);

						if (imm[mul_src1] && ((rb==null && op==null) || (op==ops['nopi'] && rb==imm[mul_src1]))) {
							rb = imm[mul_src1];
							op = ops['nopi'];
							mula = 7;
						}
						else
							error("Error: invalid first source register in first (mul) slot.", mul_src1, rb, op);
					}
					mul_src2 = slots[i][3];
					if (mul_src2 == null)
						mul_src2 = mul_src1;
					if (mul_src2 != null && acc_names[mul_src2] == null && banka_r[mul_src2] == null && bankb_r[mul_src2] == null) {
						// if its not an immediate as is, try and evaluate expr
					    mul_src2 = evaluateSrc(mul_src2, symbols, error);

						if ((imm[mul_src2] && rb==null && op==null) || (op==ops['nopi'] && rb==imm[mul_src2])) {
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
				error("Error: instruction reads from register bank b  more than once.");
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
 *   node[js] qpuasm [--showbits] [--dumpglobals] [--dumpsymbols] [--verbose] [--in=]filename
 */
if (typeof module != 'undefined' && module.exports && !module.parent) {

	var fs = require('fs');
	var existsSync = fs.existsSync || require('path').existsSync;

	var options = {in:[]};
	if (process.argv.length < 3) {
		console.log(process.argv[0], process.argv[1], "[--showbits] [--dumpglobals] [--dumpsymbols] [--verbose] [--in]filename");
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

}
