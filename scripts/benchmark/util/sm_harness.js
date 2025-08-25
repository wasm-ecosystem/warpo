arguments = scriptArgs

const buf = read(arguments[0], 'binary');

var shouldExecute = arguments[1] != undefined
console.log();

function format_float(val) {
	return (+val).toFixed(30)
}

var compstart = performance.now()
WebAssembly.instantiate(buf).then(result => {
	var compdur = performance.now() - compstart
	var execdur = 0

	if (shouldExecute) {
		var execstart = performance.now()
		var res = result.instance.exports[arguments[1]](0, 0)
		execdur = performance.now() - execstart
		console.log("RES " + res.toFixed(2))
	}

	var totaldur = performance.now() - compstart
	console.log("Total time (ms): " + totaldur.toFixed(3))

	var compperc = 100 * compdur / (compdur + execdur)
	var execperc = 100 * execdur / (compdur + execdur)
	console.log("Compilation time (ms): " + compdur.toFixed(3) + " (" + compperc.toFixed(2) + "%)")
	if (shouldExecute) console.log("Execution time (ms): " + execdur.toFixed(3) + " (" + execperc.toFixed(2) + "%)")
	console.log()
});

